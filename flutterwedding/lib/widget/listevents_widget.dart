import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterwedding/Myconstant/myconstant.dart';
import 'package:flutterwedding/Mycreen/addcustomer_screen.dart';
import 'package:flutterwedding/Mycreen/addevents_screen.dart';
import 'package:flutterwedding/Mycreen/editmyevent_screen.dart';
import 'package:flutterwedding/Mycreen/myuser_eventsscreen.dart';
import 'package:flutterwedding/Mymodel/eventmodel.dart';
import 'package:flutterwedding/Mymodel/usermodel.dart';
import 'package:flutterwedding/Mystyle/mystyle.dart';
import 'package:flutterwedding/widget/showallguestevent.dart';

class Myevents extends StatefulWidget {
  final Usermodel usermodel;
  final String? eventdate;
  const Myevents({
    Key? key,
    required this.usermodel,
    this.eventdate,
  }) : super(key: key);

  @override
  State<Myevents> createState() => _MyeventsState();
}

class _MyeventsState extends State<Myevents> {
  late double widths, heights;
  String? eventdate, iduser;
  Usermodel? usermodel;
  Eventsmodel? eventmodel;
  bool status = true;
  bool loadstatus = true;
  List<Eventsmodel> listeventmodel = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usermodel = widget.usermodel;
    eventdate = widget.eventdate;
    iduser = usermodel!.iduser;
    setState(() {
      getallevents();
    });
  }

  Future<void> getallevents() async {
    String url =
        "${Myconstant().domain}/projectsabaykot/getEventWhereIdadmin.php?isAdd=true&iduser=$iduser";
    await Dio().get(url).then((value) {
      setState(() {
        loadstatus = false;
      });

      var result = json.decode(value.data);
      if (result.toString() != 'null') {
        for (var map in result) {
          eventmodel = Eventsmodel.fromJson(map);
          setState(() {
            listeventmodel.add(eventmodel!);
            // var date = eventmodel!.expridate;
            // DateTime d1 =
            //     DateFormat('dd-MM-yyyy', 'en_US').parse(date.toString());
            // DateTime d2 = DateTime.now();
            // if (d1.isAfter(d2)) {
            //
            // }
          });
        }
      } else {
        setState(() {
          status = false;
        });
      }
    });
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
                      const SizedBox(
                        height: 70.0,
                      )
                    ],
                  ),
                ),
          buttomaddevents(),
        ],
      ),
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
      itemCount: listeventmodel.length,
      itemBuilder: (context, index) => mycontents(index),
    );
  }

  Widget mycontents(int index) {
    return Card(
      color: Colors.blue.shade100,
      child: Column(
        children: [
          Row(
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
                Container(
                  margin: const EdgeInsets.all(8.0),
                  width: widths * 0.35,
                  height: widths * 0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          "${Myconstant().domain}${listeventmodel[index].picture}"),
                    ),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white70,
                      width: 5.01,
                      strokeAlign: 0.3,
                    ),
                  ),
                ),
              ]),
              SizedBox(
                width: widths * 0.54,
                height: widths * 0.34,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Mystyle()
                          .showtitle3("កម្មវិធី:", Color(Myconstant().appbar)),
                      Mystyle().showtitle4(
                          "${listeventmodel[index].eventname}", Colors.red),
                      Row(
                        children: [
                          Mystyle().showtitle3(
                              "ថ្ងៃទី:", Color(Myconstant().appbar)),
                          Mystyle().showtitle4(
                              "${listeventmodel[index].eventdate}", Colors.red),
                        ],
                      ),
                      Row(
                        children: [
                          Mystyle()
                              .showtitle3("​ម៉ោង:", Color(Myconstant().appbar)),
                          Mystyle().showtitle4(
                              "${listeventmodel[index].eventtime}", Colors.red),
                        ],
                      ),
                      Mystyle().showtitle4(
                          "detail: ${listeventmodel[index].eventdetail}",
                          Colors.blue),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        onPressed: () {
                          MaterialPageRoute route = MaterialPageRoute(
                            builder: (context) => Addcustomer(
                                usermodel: usermodel!,
                                idevent: listeventmodel[index].idevent!),
                          );
                          Navigator.push(context, route);
                        },
                        icon: const Icon(
                          Icons.group_add,
                        ),
                        color: Color(Myconstant().appbar),
                      )),
                  Mystyle().showtitle4("បញ្ចូលអ្នកប្រើ", Colors.red)
                ],
              ),
              Column(
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        onPressed: () {
                          MaterialPageRoute route = MaterialPageRoute(
                            builder: (context) => Myuserevents(
                                idevent: listeventmodel[index].idevent!),
                          );
                          Navigator.push(context, route);
                        },
                        icon: const Icon(
                          Icons.group,
                        ),
                        color: Color(Myconstant().appbar),
                      )),
                  Mystyle().showtitle4("បង្ហាញអ្នកប្រើ", Colors.red)
                ],
              ),
              Column(
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        onPressed: () {
                          MaterialPageRoute route = MaterialPageRoute(
                            builder: (context) => Showallguestevent(
                                idevent: listeventmodel[index].idevent!),
                          );
                          Navigator.push(context, route);
                        },
                        icon: const Icon(Icons.diversity_1),
                        color: Color(Myconstant().appbar),
                      )),
                  Mystyle().showtitle4("បង្ហាញភ្ញៀវ", Colors.red)
                ],
              ),
              Column(
                children: [
                  Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: IconButton(
                        onPressed: () {
                          MaterialPageRoute route = MaterialPageRoute(
                            builder: (context) => Editmyevents(
                                eventsmodel: listeventmodel, index: index),
                          );
                          Navigator.push(context, route).then((value) {
                            listeventmodel.clear();
                            getallevents();
                          });
                        },
                        icon: const Icon(Icons.edit),
                        color: Color(Myconstant().appbar),
                      )),
                  Mystyle().showtitle4("កែប្រែកម្មវិធី", Colors.red)
                ],
              )
            ],
          ),
          const SizedBox(
            height: 6.0,
          )
        ],
      ),
    );
  }

  Widget buttomaddevents() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0, right: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () {
                  MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => Addevents(usermodel: usermodel!),
                  );
                  Navigator.push(context, route).then(
                    (value) {
                      listeventmodel.clear();
                      getallevents();
                    },
                  );
                },
                backgroundColor: Colors.blue.shade700,
                shape:
                    CircleBorder(side: BorderSide(color: Colors.blue.shade700)),
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
