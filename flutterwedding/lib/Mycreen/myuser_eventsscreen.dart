import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterwedding/Myconstant/myconstant.dart';
import 'package:flutterwedding/Mymodel/customermodel.dart';
import 'package:flutterwedding/Mystyle/mystyle.dart';

class Myuserevents extends StatefulWidget {
  final String idevent;
  const Myuserevents({
    Key? key,
    this.idevent = '',
  }) : super(key: key);

  @override
  State<Myuserevents> createState() => _MyusereventsState();
}

class _MyusereventsState extends State<Myuserevents> {
  String? idevent;
  List<Customermodel> listuserevent = [];
  bool status = true, loadstatus = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    idevent = widget.idevent;
    getuserevent();
  }

  Future<void> getuserevent() async {
    String url =
        "${Myconstant().domain}/projectsabaykot/getuserEventWhereIdevent.php?isAdd=true&idevent=$idevent";
    try {
      await Dio().get(url).then((value) {
        setState(() {
          loadstatus = false;
        });
        var result = json.decode(value.data);
        if (result != null) {
          for (var map in result) {
            Customermodel customermodel = Customermodel.fromJson(map);
            setState(() {
              listuserevent.add(customermodel);
            });
          }
        } else {
          setState(() {
            status = false;
          });
        }
      });
    } catch (e) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(Myconstant().appbar),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.chevron_left,
            color: Colors.white,
            size: 45.0,
          ),
        ),
        title: Container(margin: const EdgeInsets.only(left: 40.0),
          child: Mystyle().showtitle1("អ្នកប្រើកម្មវិធី", Colors.white)),
      ),
      body: loadstatus ? Mystyle().showprogress() : showcontents(),
    );
  }

  Widget showcontents() {
    return status
        ? showlistcontent()
        : Mystyle().showinformation("មិនទាន់មានអ្នកប្រើ...!");
  }

  Widget showlistcontent() => Column(
        children: [
          showlistcustomer(),
        ],
      );

  Widget showlistcustomer() {
    return ListView.builder(
      physics: const ScrollPhysics(),
      shrinkWrap: true,
      itemCount: listuserevent.length,
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
                        "${Myconstant().domain}${listuserevent[index].picture}",
                      ),
                      fit: BoxFit.fill),
                ),
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: Mystyle().showtitle3(
                    "${listuserevent[index].usercustomer}",
                    Colors.blue.shade700),
              ),
              Expanded(
                child: Mystyle().showtitle3("${listuserevent[index].password}",
                    Color(Myconstant().appbar)),
              ),
              Expanded(
                child: Mystyle()
                    .showtitle4(" :${listuserevent[index].phone}", Colors.red),
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
                            "${Myconstant().domain}${listuserevent[index].picture}"),
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
                        "name: ${listuserevent[index].namecustomer}",
                        Colors.green.shade500),
                    Mystyle().showtitle3(
                        "username: ${listuserevent[index].usercustomer}",
                        Colors.green.shade500),
                    Mystyle().showtitle3(
                        "password: ${listuserevent[index].password}",
                        Colors.green.shade500),
                    Mystyle().showtitle3("phone: ${listuserevent[index].phone}",
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
