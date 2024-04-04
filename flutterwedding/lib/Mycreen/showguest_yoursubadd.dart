import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterwedding/Myconstant/myconstant.dart';
import 'package:flutterwedding/Mycreen/editguest_screen.dart';
import 'package:flutterwedding/Mycreen/pdf_api.dart';
import 'package:flutterwedding/Mymodel/eventmodel.dart';
import 'package:flutterwedding/Mymodel/guestmodel.dart';
import 'package:flutterwedding/Mystyle/mystyle.dart';
import 'package:flutterwedding/Myutilities/mydialog.dart';
import 'package:flutterwedding/Mycreen/addguest_sceen.dart';
import 'package:intl/intl.dart';

class Gusetcustadd extends StatefulWidget {
  final String? idcustomer;
  const Gusetcustadd({
    Key? key,
    this.idcustomer,
  }) : super(key: key);

  @override
  State<Gusetcustadd> createState() => _GusetcustaddState();
}

class _GusetcustaddState extends State<Gusetcustadd> {
  String? idcustomers, idevent, eventname;
  Guestmodel? guestmodel;
  Eventsmodel? eventsmodel;
  int totalamountdolla = 0;
  int totalamountkh = 0;
  String mytotaldollar = "";
  String mytotalkh = "";
  List<Guestmodel> listguest = [];
  List<Guestmodel> displaylist = [];
  bool status = true;
  bool loadstatus = true;
  int count = 0;
  @override
  void initState() {
    super.initState();
    //finduser();
    setState(() {
      idcustomers = widget.idcustomer;
      getguestwhereidcus();
    });
  }

  void updatelistcustomer(String value) {
    setState(() {
      displaylist = listguest
          .where((element) =>
              element.nameguest!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  Future<void> getguestwhereidcus() async {
    String url =
        "${Myconstant().domain}/projectsabaykot/getGuestWhereIdcustomer.php?isAdd=true&idcustomer=$idcustomers";
    try {
      await Dio().get(url).then((value) {
        setState(() {
          loadstatus = false;
        });
        var result = json.decode(value.data);
        if (result.toString() != 'null') {
          for (var map in result) {
            guestmodel = Guestmodel.fromJson(map);
            setState(() {
              listguest.add(guestmodel!);
              displaylist = List.from(listguest);
              count++;
              idevent = guestmodel!.idevent;
              if (guestmodel!.currency == "ដុល្លារ") {
                totalamountdolla += int.parse(guestmodel!.amount.toString());
              } else {
                totalamountkh += int.parse(guestmodel!.amount.toString());
              }
            });
          }

          mytotaldollar = NumberFormat('#,##0', 'en_US')
              .format(totalamountdolla)
              .toString();
          mytotalkh =
              NumberFormat('#,##0', 'en_US').format(totalamountkh).toString();
          geteventwhereidevent();
        } else {
          setState(() {
            status = false;
          });
        }
      });
    } catch (e) {}
  }

  Future<void> geteventwhereidevent() async {
    String url =
        "${Myconstant().domain}/projectsabaykot/getEventWhereIdevent.php?isAdd=true&idevent=$idevent";
    try {
      await Dio().get(url).then((value) {
        var result = json.decode(value.data);
        if (result.toString() != 'null') {
          for (var map in result) {
            setState(() {
              eventsmodel = Eventsmodel.fromJson(map);
              eventname = eventsmodel!.eventname;
            });
          }
        } else {
          mydialog(context, "no connection");
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
        actions: [
          Container(
              margin: const EdgeInsets.only(right: 15.0),
              child: IconButton(
                onPressed: () async {
                  if (listguest.isEmpty) {
                    mydialog(context, "មិនមានចំនួនភ្ញៀវ...!");
                  } else {
                    final data = await Generatepdffile().generatrpdf(
                        eventsmodel!, listguest, mytotaldollar, mytotalkh);
                    Generatepdffile().savepdffile("Guest PDF", data);
                  }
                },
                icon: const Icon(Icons.picture_as_pdf_rounded),
                color: Colors.white,
                iconSize: 40.0,
              ))
        ],
        title: Mystyle().showtitle1("បញ្ចូលឈ្មោះភ្ញៀវ", Colors.white),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(top: 115.0, bottom: 100.0),
              child: Column(
                children: [
                  loadstatus ? Mystyle().showprogress() : showcontents(),
                ],
              ),
            ),
          ),
          listguest.isEmpty
              ? const Text("")
              : Column(
                  children: [
                    Card(
                      margin: const EdgeInsets.only(top: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [textfieldsearch()],
                      ),
                    ),
                    Center(
                      child: Card(
                        margin: const EdgeInsets.only(top: 5.0),
                        child: totalamont(),
                      ),
                    ),
                  ],
                ),
          buttomaddguest(),
        ],
      ),
    );
  }

  Widget showcontents() {
    return status
        ? showlistcustomer()
        : Mystyle().showinformation("មិនទាន់មានឈ្មោះភ្ញៀវ...!");
  }

  Widget buttomaddguest() {
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
                    builder: (context) =>
                        Addyourguest(idvent: idevent, idcustomer: idcustomers),
                  );
                  Navigator.push(context, route).then(
                    (value) {
                      listguest.clear();
                      getguestwhereidcus();
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

  Widget totalamont() {
    return Container(
      alignment: Alignment.centerLeft,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: Colors.white24,
      ),
      height: 50.0,
      child: Text(
        "TOTAL:Dollar=$mytotaldollar \$ Riel = $mytotalkh R",
        style: TextStyle(
          color: Colors.red.shade700,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
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
      itemCount: displaylist.length,
      itemBuilder: (context, index) => GestureDetector(
        onTap: () {
          showdetailcustomer(index);
        },
        child: Card(
          margin: const EdgeInsets.symmetric(vertical: 1.0),
          child: Container(
            padding: const EdgeInsets.only(
              left: 5.0,
            ),
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const SizedBox(
                  width: 10.0,
                ),
                Expanded(
                  flex: 1,
                  child: Mystyle().showtitle3(
                      "${displaylist.length - index}", Colors.blue.shade700),
                ),
                Expanded(
                  flex: 2,
                  child: Mystyle().showtitle3(
                      "${displaylist[index].nameguest}", Colors.blue.shade700),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    children: [
                      Mystyle().showtitle3(
                          "${displaylist[index].amount}", Colors.blue.shade700),
                      const SizedBox(width: 5.0),
                      displaylist[index].currency == "រៀល"
                          ? Mystyle().showtitle3("R", Colors.red)
                          : Mystyle().showtitle3("\$", Colors.red),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 2.0),
                  child: IconButton(
                    onPressed: () {
                      MaterialPageRoute route = MaterialPageRoute(
                        builder: (context) =>
                            Editmyguest(listguest: listguest, index: index),
                      );
                      Navigator.push(context, route).then((value) {
                        listguest.clear();
                        getguestwhereidcus();
                      });
                    },
                    icon: Icon(Icons.edit, color: Color(Myconstant().appbar),size: 20.0,),
                  ),
                ),
              ],
            ),
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
              Mystyle().showtitle3("ព័ត៌មានលម្អិត", Color(Myconstant().appbar)),
            ],
          ),
          actions: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Mystyle().showtitle3(
                        "ឈ្មោះ: ${displaylist[index].nameguest}",
                        Color(Myconstant().appbar)),
                    Mystyle().showtitle3(
                        "ចំនួនទឹកប្រាក់: ${displaylist[index].amount}  ${displaylist[index].currency}",
                        Color(Myconstant().appbar)),
                    Mystyle().showtitle3(
                        "ចងដៃ: ${displaylist[index].paymenttype}",
                        Color(Myconstant().appbar)),
                    Mystyle().showtitle3(
                        "ស្ថានភាព: ${displaylist[index].status}",
                        Color(Myconstant().appbar)),
                    Mystyle().showtitle3(
                        "អាស័យដ្ឋាន: ${displaylist[index].address}",
                        Color(Myconstant().appbar)),
                  ],
                ),
                const SizedBox(height: 10.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                          backgroundColor: Color(Myconstant().appbar)),
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
