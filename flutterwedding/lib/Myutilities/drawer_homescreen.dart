import 'package:flutter/material.dart';
import 'package:flutterwedding/Myconstant/myconstant.dart';
import 'package:flutterwedding/Mystyle/mystyle.dart';
import 'package:flutterwedding/Mycreen/mysignin_screen.dart';
import 'package:flutterwedding/Mycreen/mysignup_screen.dart';

Widget drawerhomescrenc(BuildContext context) {
  return Drawer(
    child: Stack(
      children: [
        Column(
          children: [
            drawerheader(),
            const SizedBox(height: 15.0),
            menusignin(context),
            menusignup(context),
          ],
        ),
        boildlogo(),
        menulogout(context),
      ],
    ),
  );
}

Widget menusignin(BuildContext context) {
  return ListTile(
    leading: SizedBox(
        height: 40.0,
        width: 40.0,
        child: CircleAvatar(
          backgroundColor: Color(Myconstant().iconcolor),
          child: const Icon(Icons.exit_to_app, size: 25.0, color: Colors.white),
        )),
    title: Mystyle().showtitle1(" ចូលគណនី", Color(Myconstant().appbar)),
    hoverColor: Colors.red,
    onTap: () {
      Navigator.pop(context);
      MaterialPageRoute route = MaterialPageRoute(
        builder: (values) => const Mysignin(),
      );
      Navigator.push(context, route);
    },
  );
}

Widget menusignup(BuildContext context) {
  return ListTile(
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
    title: Mystyle().showtitle1(" បង្កើតគណនី", Color(Myconstant().appbar)),
    hoverColor: Colors.black54,
    onTap: () {
      Navigator.pop(context);
      MaterialPageRoute route = MaterialPageRoute(
        builder: (values) => const Mysignup(),
      );
      Navigator.push(context, route);
    },
  );
}

Widget menulogout(BuildContext context) {
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
                  size: 35.0,
                  color: Colors.white,
                ),
              )),
          title: Mystyle().showtitle1("ចាកចេញ", Colors.white),
          hoverColor: Colors.black54,
          onTap: () {
            Navigator.pop(context);
            MaterialPageRoute route = MaterialPageRoute(
              builder: (values) => const Mysignup(),
            );
            Navigator.push(context, route);
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
            child: const CircleAvatar(
              backgroundImage: ExactAssetImage("images/logo.jpg"),
            ),
          ),
          Mystyle().showtitle1("SABAY KOT", Color(Myconstant().appbar))
        ],
      ),
    ),
  );
}
