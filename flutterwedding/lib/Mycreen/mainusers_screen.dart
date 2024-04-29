import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterwedding/Myconstant/myconstant.dart';
import 'package:flutterwedding/Mycreen/myhome_screen.dart';
import 'package:flutterwedding/Mycreen/search_event_screen.dart';
import 'package:flutterwedding/Mymodel/usermodel.dart';
import 'package:flutterwedding/Mystyle/mystyle.dart';
import 'package:flutterwedding/Myutilities/mydialog.dart';
import 'package:flutterwedding/Myutilities/opendrawer.dart';
import 'package:flutterwedding/widget/listevents_widget.dart';
import 'package:flutterwedding/widget/mycustomer_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mymainusers extends StatefulWidget {
  const Mymainusers({super.key});

  @override
  State<Mymainusers> createState() => _MymainusersState();
}

class _MymainusersState extends State<Mymainusers> {
  Usermodel? usermodel;
  String? iduser, nameuser, usertype;
  String? idcustomer, usercustomer, customertype;
  SharedPreferences? preferences;
  Widget? currentwidget;
  late double widths, heights;
  bool showseach = true;
  String? eventdate = "newevent";

  List<Widget> listwidget = [
    Mystyle().showtitle1("កម្មវិធីរបស់ខ្ញុំ", Colors.white),
    Mystyle().showtitle1("អ្នកប្រើកម្មវីធី", Colors.white),
    Mystyle().showtitle1("កម្មវិធីផុតកំណត់", Colors.white),
    textfieldsearch(),
  ];

  int index = 0;
  @override
  void initState() {
    super.initState();
    setState(() {
      finduser();
    });
  }

  Future<void> finduser() async {
    preferences = await SharedPreferences.getInstance();
    iduser = preferences!.getString("iduser");
    nameuser = preferences!.getString('username');
    usertype = preferences!.getString("usertype");

    String url =
        "${Myconstant().domain}/projectsabaykot/getadminWhereUseradmin.php?isAdd=true&username=$nameuser";
    try {
      Response response = await Dio().get(url);
      var result = json.decode(response.data);
      if (response.toString() == 'null') {
      } else {
        for (var map in result) {
          usermodel = Usermodel.fromJson(map);
          setState(() {
            currentwidget = Myevents(usermodel: usermodel!);
          });
        }
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      mydialog(context, 'no connection');
    }
  }

  Future<void> getuserwhereulogin() async {}

  @override
  Widget build(BuildContext context) {
    widths = MediaQuery.sizeOf(context).width;
    heights = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(Myconstant().appbar),
        leading: opendrawer(),
        actions: [
          showseach
              ? Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: IconButton(
                    onPressed: () {
                      MaterialPageRoute route = MaterialPageRoute(
                        builder: (context) => Searchevent(
                            usermodel: usermodel!, eventdate: eventdate),
                      );
                      Navigator.push(context, route);
                    },
                    icon: const Icon(Icons.search),
                    color: Colors.white,
                    iconSize: 35.0,
                  ))
              : const Text("")
        ],
        title: Container(
          margin: const EdgeInsets.only(left: 15.0),
          child: Row(
            children: [
              listwidget[index],
            ],
          ),
        ),
      ),
      drawer: usermodel == null ? Mystyle().showprogress() : drawermainuser(),
      body: usermodel == null ? Mystyle().showprogress() : currentwidget,
    );
  }

  Widget drawermainuser() {
    return Drawer(
      child: Stack(
        children: [
          Column(
            children: [
              drawerheader(),
              const SizedBox(height: 15.0),
              menuevents(),
              menucustomer(),
             
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
          .showtitle2(" កម្មវិធីរបស់ខ្ញុំ", Color(Myconstant().iconcolor)),
      hoverColor: Colors.red,
      onTap: () {
        setState(() {
          eventdate = "newevent";
          showseach = true;
          index = 0;
          currentwidget = Myevents(usermodel: usermodel!);
        });
        Navigator.pop(context);
      },
    );
  }

  Widget menucustomer() {
    return ListTile(
      leading: SizedBox(
          height: 40.0,
          width: 40.0,
          child: CircleAvatar(
            backgroundColor: Color(Myconstant().iconcolor),
            child: const Icon(
              Icons.attribution,
              size: 30.0,
              color: Colors.white,
            ),
          )),
      title: Mystyle()
          .showtitle2(" អ្នបប្រើកម្មវិធី", Color(Myconstant().iconcolor)),
      hoverColor: Colors.black54,
      onTap: () {
        setState(() {
          showseach = false;
          index = 1;
          nameuser != null
              ? currentwidget = Mycustomer(
                  usertype: usertype!,
                  iduser: iduser,
                  nameuser: nameuser,
                )
              : currentwidget = Mycustomer(
                  usertype: customertype!,
                  iduser: idcustomer,
                  nameuser: usercustomer);
        });
        Navigator.pop(context);
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
        margin: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(8.0),
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      "${Myconstant().domain}${usermodel!.picture}"),
                ),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white70,
                  width: 5.01,
                  strokeAlign: 0.3,
                ),
              ),
            ),
            Mystyle().showtitle1(
                "${usermodel!.nameuser}", Color(Myconstant().iconcolor))
          ],
        ),
      ),
    );
  }
}

Container textfieldsearch() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30.0),
      color: Colors.white,
    ),
    height: 50.0,
    width: 250.0,
    child: TextField(
      decoration: InputDecoration(
        hintText: 'Searchevents',
        hintStyle: TextStyle(
          height: -0.5,
          color: Colors.blue.shade500,
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
        prefixIcon: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.search),
          color: Color(Myconstant().appbar),
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
