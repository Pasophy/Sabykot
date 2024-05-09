import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterwedding/Myconstant/myconstant.dart';
import 'package:flutterwedding/Mycreen/addcustomer_screen.dart';
import 'package:flutterwedding/Mycreen/editmyevent_screen.dart';
import 'package:flutterwedding/Mycreen/myuser_eventsscreen.dart';
import 'package:flutterwedding/Mymodel/eventmodel.dart';
import 'package:flutterwedding/Mymodel/usermodel.dart';
import 'package:flutterwedding/Mystyle/mystyle.dart';
import 'package:flutterwedding/Mycreen/showguest_your_event.dart';

class Searchevent extends StatefulWidget {
  final Usermodel usermodel;
  final String? eventdate;
  const Searchevent({
    Key? key,
    required this.usermodel,
    this.eventdate,
  }) : super(key: key);

  @override
  State<Searchevent> createState() => _SearcheventState();
}

class _SearcheventState extends State<Searchevent> {
  late double widths, heights;
  String? eventdate, iduser;
  Usermodel? usermodel;
  bool status = true;
  bool loadstatus = true;
  List<Eventsmodel> listeventmodel = [];
  // ignore: non_constant_identifier_names
  List<Eventsmodel> display_list = [];

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
    Dio().get(url).then((value) {
      setState(() {
        loadstatus = false;
      });

      var result = json.decode(value.data);
      if (result.toString() != 'null') {
        for (var map in result) {
          Eventsmodel eventmodel = Eventsmodel.fromJson(map);
          setState(() {
            // var date = eventmodel.expridate;
            // DateTime d1 =
            //     DateFormat('dd-MM-yyyy', 'en_US').parse(date.toString());
            // DateTime d2 = DateTime.now();
            // if (d1.isBefore(d2)) {

            // }
            listeventmodel.add(eventmodel);
            display_list = List.from(listeventmodel);
          });
        }
      } else {
        setState(() {
          status = false;
        });
      }
    });
  }

  void updatelist(String value) {
    setState(() {
      //getallevents();
      display_list = listeventmodel
          .where((element) =>
              element.eventdate!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    widths = MediaQuery.sizeOf(context).width;
    heights = MediaQuery.sizeOf(context).height;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(
          FocusNode(),
        ),
        child: Stack(
          children: [
            loadstatus
                ? Mystyle().showprogress()
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 70.0,
                        ),
                        showcontent(),
                      ],
                    ),
                  ),
            Container(
              height: 90.0,
              width: double.infinity,
              color: Color(Myconstant().appbar),
            ),
            Row(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 25.0),
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: 45.0,
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 25.0),
                      child: textfieldsearch(),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget showcontent() {
    return status
        ? showlistcontent()
        : Container(margin:const EdgeInsets.only(top: 200.0) ,
          child: Mystyle().showinformation("មិនទាន់មានកម្មវិធី...!"));
  }

  Widget showlistcontent() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      itemCount: display_list.length,
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
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.all(8.0),
                    width: widths * 0.35,
                    height: widths * 0.4,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                            "${Myconstant().domain}${display_list[index].picture}"),
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white70,
                        width: 5.01,
                        strokeAlign: 0.3,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: widths * 0.54,
                height: widths * 0.34,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                       Text(
                        "កម្មវិធី",
                        style: TextStyle(
                            fontSize: widths * 0.04,
                            color: Color(Myconstant().appbar),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Battambang'),
                      ),
                      // Mystyle()
                      //     .showtitle3("កម្មវិធី:", Color(Myconstant().appbar)),
                      Text(
                        "${listeventmodel[index].eventname}",
                        style: TextStyle(
                            fontSize: widths * 0.03,
                            color: Colors.red,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Battambang'),
                      ),
                      // Mystyle().showtitle4(
                      //     "${listeventmodel[index].eventname}", Colors.red),
                      Row(
                        children: [
                          Text(
                            " ថ្ងៃទី:",
                            style: TextStyle(
                                fontSize: widths * 0.04,
                                color: Color(Myconstant().appbar),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Battambang'),
                          ),
                          // Mystyle().showtitle3(
                          //     "ថ្ងៃទី:", Color(Myconstant().appbar)),
                          Text(
                            " ${listeventmodel[index].eventdate}",
                            style: TextStyle(
                                fontSize: widths * 0.03,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Battambang'),
                          ),
                          // Mystyle().showtitle4(
                          //     "${listeventmodel[index].eventdate}", Colors.red),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            " ម៉ោង:",
                            style: TextStyle(
                                fontSize: widths * 0.04,
                                color: Color(Myconstant().appbar),
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Battambang'),
                          ),
                          // Mystyle()
                          //     .showtitle3("​ម៉ោង:", Color(Myconstant().appbar)),
                          Text(
                            " ${listeventmodel[index].eventtime}",
                            style: TextStyle(
                                fontSize: widths * 0.03,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Battambang'),
                          ),
                          // Mystyle().showtitle4(
                          //     "${listeventmodel[index].eventtime}", Colors.red),
                        ],
                      ),

                      Text(
                        "detail: ${listeventmodel[index].eventdetail}",
                        style: TextStyle(
                            fontSize: widths * 0.025,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Battambang'),
                      ),
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
                            builder: (context) => Showyourguest(
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

  Widget textfieldsearch() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white,
      ),
      height: 50.0,
      width: 300.0,
      child: TextField(
        keyboardType: TextInputType.datetime,
        onChanged: (value) => updatelist(value),
        decoration: InputDecoration(
          hintText: 'Searcheventdate',
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
}
