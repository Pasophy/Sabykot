import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterwedding/Myconstant/myconstant.dart';
import 'package:flutterwedding/Mycreen/addcustomer_screen.dart';
import 'package:flutterwedding/Mymodel/customermodel.dart';
import 'package:flutterwedding/Mystyle/mystyle.dart';
import 'package:flutterwedding/Myutilities/mydialog.dart';

class Mycustomer extends StatefulWidget {
  final String? usertype;
  final String? iduser;
  final String? nameuser;
  const Mycustomer({
    Key? key,
    this.usertype,
    this.iduser,
    this.nameuser,
  }) : super(key: key);

  @override
  State<Mycustomer> createState() => _MycustomerState();
}

class _MycustomerState extends State<Mycustomer> {
  String? userlogin, idlogin, namelogin;
  List<Customermodel> listcustomer = [];
  bool status = true;
  bool loadstatus = true;
  //int index = 0;
  int count = 0;
  @override
  void initState() {
    super.initState();
    //finduser();
    setState(() {
      userlogin = widget.usertype;
      idlogin = widget.iduser;
      namelogin = widget.nameuser;
      getcuswhereulogin();
      print("================>$namelogin");
    });
  }

  Future<void> getcuswhereulogin() async {
    String url;
    if (userlogin == "admin") {
      url = "${Myconstant().domain}/projectsabaykot/getAllDatacustomer.php";
    } else {
      url =
          "${Myconstant().domain}/projectsabaykot/getcustomerWhereUsercustomer.php?isAdd=true&usercustomer=$namelogin";
    }
    try {
      await Dio().get(url).then((value) {
        setState(() {
          loadstatus = false;
        });
        var result = json.decode(value.data);
        if (result.toString() != 'null') {
          for (var map in result) {
            Customermodel customermodel = Customermodel.fromJson(map);
            setState(() {
              listcustomer.add(customermodel);
              count++;
            });
          }
        } else {
          setState(() {
            status = false;
          });
          mydialog(context, 'មិនទាន់មានអ្នកប្រើ ...!');
        }
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          loadstatus ? Mystyle().showprogress() : showcontents(),

          buttomaddcustomer(),
          //DatePickerTheme(data: data, child: child)
        ],
      ),
    );
  }

  Widget showcontents() {
    return status
        ? showlistcontent()
        : Mystyle().showinformation("មិនទាន់មានអតិថិជន...!");
  }

  Widget showlistcontent() => Column(
        children: [
          Container(
            color: Colors.amber,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Mystyle().showtitle1("fname", Colors.red.shade700),
                Mystyle().showtitle1("uname", Colors.red.shade700),
                Mystyle().showtitle1("password", Colors.red.shade700),
              ],
            ),
          ),
          showlistcustomer(),
        ],
      );

  ListView showlistcustomer() {
    return ListView.builder(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemCount: listcustomer.length,
      itemBuilder: (context, index) => Container(
        decoration: BoxDecoration(
            color: Colors.amber.shade100,
            shape: BoxShape.rectangle,
            border: Border(
                top: BorderSide(color: Color(Myconstant().appbar)),
                bottom: BorderSide(color: Color(Myconstant().appbar)))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Mystyle().showtitle2(
                "${listcustomer[index].namecustomer}", Colors.black),
            Mystyle().showtitle2(
                "${listcustomer[index].usercustomer}", Colors.black),
            Mystyle()
                .showtitle2("${listcustomer[index].password}", Colors.black),
          ],
        ),
      ),
    );
  }

  Container buttomaddcustomer() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0, right: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () {
                  //finduser();
                  if (userlogin == "admin") {
                    MaterialPageRoute route = MaterialPageRoute(
                      builder: (context) =>
                          Addcustomer(iduser: idlogin, nameuser: namelogin),
                    );
                    Navigator.push(context, route).then((value) =>getcuswhereulogin());
                  } else {
                    mydialog(context, "អ្នកមិនសិទ្ធបង្កើតបញ្ជី...!");
                  }
                },
                backgroundColor: Color(Myconstant().appbar),
                shape: CircleBorder(
                    side: BorderSide(color: Color(Myconstant().appbar))),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
