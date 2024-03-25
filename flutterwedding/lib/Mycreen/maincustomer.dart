import 'package:flutter/material.dart';
import 'package:flutterwedding/Myconstant/myconstant.dart';
import 'package:flutterwedding/Mycreen/myhome_screen.dart';
import 'package:flutterwedding/Mystyle/mystyle.dart';
import 'package:flutterwedding/widget/listevents_widget.dart';
import 'package:flutterwedding/widget/listguestes_wiget.dart';
import 'package:flutterwedding/widget/mycustomer_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Maincustomer extends StatefulWidget {
  const Maincustomer({super.key});

  @override
  State<Maincustomer> createState() => _MaincustomerState();
}

class _MaincustomerState extends State<Maincustomer> {
  int index = 0;
  String? idcustomer, customeruser, namecustomer;
  Widget currentwidget = const Mycustomer();
  SharedPreferences? preferences;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkcustomerlongin();
  }

  Future<void> checkcustomerlongin() async {
    preferences = await SharedPreferences.getInstance();
    idcustomer = preferences!.getString("idcustomer");
    namecustomer = preferences!.getString("namecustomer");
    customeruser = preferences!.getString("customeruser");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(Myconstant().appbar),
        title: Mystyle().showtitle1("MAIN CUSTOMER", Colors.white),
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
      title: Mystyle().showtitle2(" EVENTS", Color(Myconstant().iconcolor)),
      hoverColor: Colors.red,
      onTap: () {
        setState(() {
          index = 0;
          //currentwidget = const Myevents();
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
      title: Mystyle().showtitle2(" CUSTOMER", Color(Myconstant().iconcolor)),
      hoverColor: Colors.black54,
      onTap: () {
        setState(() {});
        Navigator.pop(context);
      },
    );
  }

  Widget menugueste() {
    return ListTile(
      leading: SizedBox(
          height: 40.0,
          width: 40.0,
          child: CircleAvatar(
            backgroundColor: Color(Myconstant().iconcolor),
            child: const Icon(
              Icons.event_available,
              size: 25.0,
              color: Colors.white,
            ),
          )),
      title:
          Mystyle().showtitle2(" EVENTEXPRID", Color(Myconstant().iconcolor)),
      hoverColor: Colors.black54,
      onTap: () {
        setState(() {
          index = 2;
          currentwidget = const Myguestes();
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
                    size: 25.0,
                    color: Colors.white,
                  ),
                )),
            title:
                Mystyle().showtitle2("LOG OUT", Color(Myconstant().iconcolor)),
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
              height: 130.0,
              width: 130.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  style: BorderStyle.solid,
                  width: 2.5,
                ),
              ),
              child: const CircleAvatar(
                backgroundImage: ExactAssetImage("images/logo.jpg"),
              ),
            ),
            Mystyle().showtitle1("user", Color(Myconstant().iconcolor))
          ],
        ),
      ),
    );
  }
}
