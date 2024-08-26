import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterwedding/Myconstant/myconstant.dart';
import 'package:flutterwedding/Mycreen/myhome_screen.dart';
import 'package:flutterwedding/Mycreen/showguest_your_event.dart';
import 'package:flutterwedding/Mycreen/showguest_yoursubadd.dart';
import 'package:flutterwedding/Mymodel/customermodel.dart';
import 'package:flutterwedding/Mymodel/eventmodel.dart';
import 'package:flutterwedding/Mystyle/mystyle.dart';
import 'package:flutterwedding/Myutilities/mydialog.dart';
import 'package:flutterwedding/Myutilities/opendrawer.dart';
import 'package:flutterwedding/widget/event_customer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Maincustomer extends StatefulWidget {
  const Maincustomer({super.key});
  @override
  State<Maincustomer> createState() => _MaincustomerState();
}

class _MaincustomerState extends State<Maincustomer> {
  Customermodel? customermodel;
  Eventsmodel? eventsmodel;
  List<Eventsmodel> listevents = [];
  int index = 0;
  String? idevent, idcustomer, customeruser, customertype;
  Widget? currentwidget;
  SharedPreferences? preferences;
  List<Widget> appbartitle = [
    Container(
        margin: const EdgeInsets.only(left: 30.0),
        child: Mystyle().showtitle1("កម្មវិធីរបស់អ្នក", Colors.white)),
    Container(
        margin: const EdgeInsets.only(left: 30.0),
        child: Mystyle().showtitle1("បញ្ជីឈ្មោះភ្ញៀវ", Colors.white))
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkcustomerlongin();
  }

  Future<void> checkcustomerlongin() async {
    preferences = await SharedPreferences.getInstance();
    idcustomer = preferences!.getString("idcustomer");
    customertype = preferences!.getString("usertype");
    customeruser = preferences!.getString("usercustomer");

    String url =
        "${Myconstant().domain}/projectsabaykot/getcustomerWhereUsercustomer.php?isAdd=true&usercustomer=$customeruser";
    try {
      Response response = await Dio().get(url);
      var result = json.decode(response.data);
      if (response.toString() == 'null') {
        // ignore: use_build_context_synchronously
        mydialog(context, 'No username ...!');
      } else {
        for (var map in result) {
          setState(() {
            customermodel = Customermodel.fromJson(map);
            idevent = customermodel!.idevent;
            currentwidget = Customerevent(customermodel: customermodel!);
          });
        }
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      mydialog(context, 'customer error==>ok');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(Myconstant().appbar),
        leading: opendrawer(),
        title: appbartitle[index],
      ),
      drawer: customermodel == null
          ? Mystyle().showprogress()
          : drawermaincustomer(),
      body: currentwidget ?? Mystyle().showprogress(),
    );
  }

  Widget drawermaincustomer() {
    return Drawer(
      child: Stack(
        children: [
          Column(
            children: [
              drawerheader(),
              const SizedBox(height: 15.0),
              menuevents(),
              menuaddguestevent(),
              menueshowguste(),
            ],
          ),
          boildlogo(),
          menulogout(),
        ],
      ),
    );
  }

  Widget menuevents() {
    return ListTile(
      leading: SizedBox(
          height: 40.0,
          width: 40.0,
          child: CircleAvatar(
            backgroundColor: Color(Myconstant().iconcolor),
            child: const Icon(Icons.event, size: 25.0, color: Colors.white),
          )),
      title: Mystyle()
          .showtitle2(" កម្មវិធីរបស់អ្នក", Color(Myconstant().iconcolor)),
      hoverColor: Colors.red,
      onTap: () {
        setState(() {
          index = 0;
          currentwidget = Customerevent(customermodel: customermodel!);
        });
        Navigator.pop(context);
      },
    );
  }

  Widget menueshowguste() {
    return ListTile(
      leading: SizedBox(
          height: 40.0,
          width: 40.0,
          child: CircleAvatar(
            backgroundColor: Color(Myconstant().iconcolor),
            child:
                const Icon(Icons.diversity_1, size: 25.0, color: Colors.white),
          )),
      title: Mystyle()
          .showtitle2("បង្ហាញឈ្មោះភ្ញៀវ", Color(Myconstant().iconcolor)),
      hoverColor: Colors.red,
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => Showyourguest(idevent: idevent),
        );
        Navigator.pop(context);
        Navigator.push(context, route);
      },
    );
  }

  Widget menuaddguestevent() {
    return ListTile(
      leading: SizedBox(
          height: 40.0,
          width: 40.0,
          child: CircleAvatar(
            backgroundColor: Color(Myconstant().iconcolor),
            child: const Icon(
              Icons.edit_square,
              size: 25.0,
              color: Colors.white,
            ),
          )),
      title:
          Mystyle().showtitle2("កត់ត្រាចំណងដៃ", Color(Myconstant().iconcolor)),
      hoverColor: Colors.black54,
      onTap: () {
        MaterialPageRoute route = MaterialPageRoute(
          builder: (context) => Gusetcustadd(
            idcustomer: idcustomer!,
            ideven: idevent!,
          ),
        );
        Navigator.pop(context);
        Navigator.push(context, route);
        // Navigator.push(context,route).then((val) {
        //   Navigator.pop(context);
        // });
      },
    );
  }

  Widget menulogout() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color(Myconstant().appbar),
            gradient: RadialGradient(colors: [
              Colors.white,
              Color(Myconstant().appbar),
            ], radius: 3.2, center: const Alignment(1.0, -0.2)),
          ),
          child: ListTile(
            leading: SizedBox(
                height: 40.0,
                width: 40.0,
                child: CircleAvatar(
                  backgroundColor: Color(Myconstant().iconcolor),
                  child: const Icon(
                    Icons.output,
                    size: 30.0,
                    color: Colors.white,
                  ),
                )),
            title: Mystyle().showtitle1("ចាកចេញ", Colors.white),
            hoverColor: Colors.black54,
            onTap: () {
              preferences!.clear();
              MaterialPageRoute route = MaterialPageRoute(
                builder: (context) => const Myhomecreen(),
              );
              Navigator.pushAndRemoveUntil(context, route, (route) => false);
            },
          ),
        ),
      ],
    );
  }

  Widget drawerheader() {
    return Container(
      height: 200.0,
      decoration: BoxDecoration(
        color: Color(Myconstant().appbar),
        gradient: RadialGradient(colors: [
          Colors.white,
          Color(Myconstant().appbar),
        ], radius: 0.9, center: const Alignment(-0.1, -0.1)),
      ),
    );
  }

  Widget boildlogo() {
    return Center(
      child: Container(
        margin: const EdgeInsets.only(top: 35.0),
        child: Column(
          children: [
            Container(
              height: 120.0,
              width: 120.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  style: BorderStyle.solid,
                  width: 2.5,
                ),
              ),
              child: customermodel!.picture == null
                  ? Mystyle().showprogress()
                  : CircleAvatar(
                      backgroundImage: NetworkImage(
                          "${Myconstant().domain}${customermodel!.picture}"),
                    ),
            ),
            customermodel!.namecustomer == null
                ? Mystyle().showprogress()
                : Mystyle().showtitle1("${customermodel!.namecustomer}",
                    Color(Myconstant().iconcolor))
          ],
        ),
      ),
    );
  }
}
