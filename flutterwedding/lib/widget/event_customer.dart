import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterwedding/Myconstant/myconstant.dart';
import 'package:flutterwedding/Mycreen/myuser_eventsscreen.dart';
import 'package:flutterwedding/Mymodel/customermodel.dart';
import 'package:flutterwedding/Mymodel/eventmodel.dart';
import 'package:flutterwedding/Mystyle/mystyle.dart';
import 'package:flutterwedding/Myutilities/mydialog.dart';

class Customerevent extends StatefulWidget {
  final Customermodel customermodel;
  const Customerevent({
    Key? key,
    required this.customermodel,
  }) : super(key: key);

  @override
  State<Customerevent> createState() => _CustomereventState();
}

class _CustomereventState extends State<Customerevent> {
  Eventsmodel? eventsmodel;
  Customermodel? customermodel;
  String? idevent;
  List<Eventsmodel> listevents = [];
  bool status = true;
  bool loadstatus = true;
  late double widths, heights;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      customermodel = widget.customermodel;
      idevent = customermodel!.idevent;
      geteventwhereid();
    });
  }

  Future<void> geteventwhereid() async {
    String url =
        "${Myconstant().domain}/projectsabaykot/getEventWhereIdevent.php?isAdd=true&idevent=$idevent";
    try {
      await Dio().get(url).then((value) {
        setState(() {
          loadstatus = false;
        });
        var result = json.decode(value.data);
        if (value.toString() != 'null') {
          for (var map in result) {
            eventsmodel = Eventsmodel.fromJson(map);
            setState(() {
              listevents.add(eventsmodel!);
            });
          }
        } else {
          setState(() {
            status = false;
          });
        }
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      mydialog(context, 'not internet');
    }
  }

  @override
  Widget build(BuildContext context) {
    widths = MediaQuery.sizeOf(context).width;
    heights = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: Stack(
        children: [
          loadstatus
              ? Mystyle().showprogress()
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      showcontent(),
                    ],
                  ),
                ),
          showbuttombar(),
        ],
      ),
    );
  }

  Widget showbuttombar() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: 77.0,
          padding: const EdgeInsets.only(top: 5.0),
          decoration: BoxDecoration(
              color: Colors.brown.shade50,
              border: Border(top: BorderSide(color: Colors.brown.shade200))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(Myconstant().iconcolor),
                      ),
                      child: IconButton(
                        onPressed: () {
                          MaterialPageRoute route = MaterialPageRoute(
                            builder: (context) =>
                                Myuserevents(idevent: eventsmodel!.idevent!),
                          );
                          Navigator.push(context, route);
                          print("==================>${eventsmodel!.idevent!}");
                        },
                        icon: const Icon(
                          Icons.group,
                          color: Colors.white,
                        ),
                        color: Color(Myconstant().appbar),
                      )),
                  Mystyle().showtitle4("showuser", Colors.red)
                ],
              ),
              Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(Myconstant().iconcolor),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.diversity_1),
                        color: Colors.white,
                      )),
                  Mystyle().showtitle4("showguest", Colors.red)
                ],
              ),
              Column(
                children: [
                  Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(Myconstant().iconcolor),
                      ),
                      child: IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.group_add,
                        ),
                        color: Colors.white,
                      )),
                  Mystyle().showtitle4("addguest", Colors.red)
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget showcontent() {
    return status
        ? showlistcontent()
        : Mystyle().showinformation("មិនទាន់មានកម្មវិធី...!");
  }

  Widget showlistcontent() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: listevents.length,
      itemBuilder: (context, index) => mycontents(index),
    );
  }

  Widget mycontents(int index) {
    return Column(
      children: [
        const SizedBox(
          height: 10.0,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  margin: const EdgeInsets.all(20.0),
                  width: widths * 0.7,
                  height: widths * 0.8,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "${Myconstant().domain}${listevents[index].picture}"),
                    ),
                    shape: BoxShape.rectangle,
                    borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                    border: Border.all(
                      color: Colors.white70,
                      width: 5.01,
                      strokeAlign: 0.3,
                    ),
                  ),
                ),
              ],
            ),
            Mystyle().showtitleevent("កម្មវិធី:", Color(Myconstant().appbar)),
            Mystyle().showtitle1("${listevents[index].eventname}", Colors.red),
            Container(
              margin: EdgeInsets.only(left: widths * 0.2, top: 10.0),
              child: Row(
                children: [
                  Mystyle().showtitle1("ថ្ងៃទី:", Color(Myconstant().appbar)),
                  Mystyle()
                      .showtitle1("${listevents[index].eventdate}", Colors.red),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: widths * 0.2, top: 10.0),
              child: Row(
                children: [
                  Mystyle().showtitle1("​ម៉ោង:", Color(Myconstant().appbar)),
                  Mystyle()
                      .showtitle1("${listevents[index].eventtime}", Colors.red),
                ],
              ),
            ),
            const SizedBox(height: 15.0),
            Mystyle().showtitle2(
                "detail: ${listevents[index].eventdetail}", Colors.blue),
            const SizedBox(height: 30.0),
            const SizedBox(
              height: 25.0,
            )
          ],
        ),
      ],
    );
  }
}
