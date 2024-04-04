import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterwedding/Myconstant/myconstant.dart';
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
  List<Customermodel> display_list = [];
  bool status = true;
  bool loadstatus = true;
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
    });
  }

  void updatelistcustomer(String value) {
    setState(() {
      display_list = listcustomer
          .where((element) =>
              element.namecustomer!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  Future<void> getcuswhereulogin() async {
    String url =
        "${Myconstant().domain}/projectsabaykot/getCustomerWhereIduser.php?isAdd=true&iduser=$idlogin";
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
              display_list = List.from(listcustomer);
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
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(
        FocusNode(),
      ),
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              margin: const EdgeInsets.only(top: 60.0),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    loadstatus ? Mystyle().showprogress() : showcontents(),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                Card(
                  margin: const EdgeInsets.only(top: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [textfieldsearch()],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget showcontents() {
    return status
        ? showlistcustomer()
        : Mystyle().showinformation("មិនទាន់មានអតិថិជន...!");
  }

  Widget textfieldsearch() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white24,
      ),
      height: 50.0,
      width: MediaQuery.sizeOf(context).width * 0.95,
      child: TextField(
        onChanged: (value) => updatelistcustomer(value),
        decoration: InputDecoration(
          hintText: 'Searchname',
          hintStyle: TextStyle(
            height: -0.5,
            color: Colors.blue.shade500,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: const Icon(
            Icons.search,
            size: 30.0,
            weight: 10.0,
            color: Colors.blue,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(
              style: BorderStyle.none,
              color: Color(Myconstant().reds),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: BorderSide(
              style: BorderStyle.none,
              color: Color(Myconstant().reds),
              width: 1.0,
            ),
          ),
        ),
        style: TextStyle(
          color: Color(Myconstant().reds),
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          height: 1.0,
        ),
      ),
    );
  }

  Widget showlistcustomer() {
    return ListView.builder(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemCount: display_list.length,
      itemBuilder: (context, index) => Card(
        margin: const EdgeInsets.symmetric(vertical: 1.0),
        child: Container(
          padding: const EdgeInsets.only(
            left: 5.0,
          ),
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 60.0,
                width: 50.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: NetworkImage(
                        "${Myconstant().domain}${display_list[index].picture}",
                      ),
                      fit: BoxFit.fill),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Mystyle().showtitle3(
                    "${display_list[index].usercustomer}",
                    Colors.blue.shade700),
              ),
              Expanded(
                child: Mystyle().showtitle3("${display_list[index].password}",
                    Color(Myconstant().appbar)),
              ),
              Expanded(
                child: Mystyle()
                    .showtitle4(" :${display_list[index].phone}", Colors.red),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 2.0),
                child: IconButton(
                  onPressed: () {
                    showdetailcustomer(index);
                  },
                  icon: const Icon(Icons.remove_red_eye_outlined),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> showdetailcustomer(int index) async {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          titlePadding: const EdgeInsets.only(top: 10.0),
          actionsPadding: const EdgeInsets.only(top: 10.0, bottom: 15.0),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Mystyle().showtitle3("Customerdetail", Colors.green.shade500),
            ],
          ),
          actions: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(20.0),
                    image: DecorationImage(
                        image: NetworkImage(
                            "${Myconstant().domain}${display_list[index].picture}"),
                        fit: BoxFit.fill),
                  ),
                  margin: const EdgeInsets.all(8.0),
                  width: MediaQuery.sizeOf(context).width * 0.35,
                  height: MediaQuery.sizeOf(context).height * 0.15,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Mystyle().showtitle3(
                        "name: ${display_list[index].namecustomer}",
                        Colors.green.shade500),
                    Mystyle().showtitle3(
                        "username: ${display_list[index].usercustomer}",
                        Colors.green.shade500),
                    Mystyle().showtitle3(
                        "password: ${display_list[index].password}",
                        Colors.green.shade500),
                    Mystyle().showtitle3("phone: ${display_list[index].phone}",
                        Colors.green.shade500),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.green.shade500),
                      child: Mystyle().showtitle3("back", Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
