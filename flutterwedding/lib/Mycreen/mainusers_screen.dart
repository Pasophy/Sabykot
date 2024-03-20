import 'package:flutter/material.dart';
import 'package:flutterwedding/Myconstant/myconstant.dart';
import 'package:flutterwedding/Mycreen/myhome_screen.dart';
import 'package:flutterwedding/Mystyle/mystyle.dart';
import 'package:flutterwedding/Myutilities/opendrawer.dart';
import 'package:flutterwedding/widget/listevents_widget.dart';
import 'package:flutterwedding/widget/listguestes_wiget.dart';
import 'package:flutterwedding/widget/mycustomer_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mymainusers extends StatefulWidget {
  const Mymainusers({super.key});

  @override
  State<Mymainusers> createState() => _MymainusersState();
}

class _MymainusersState extends State<Mymainusers> {
  //Usermodel? usermodel;
  String? iduser, nameuser, usertype;
  String? idcustomer, usercustomer, customertype;
  SharedPreferences? preferences;
  Widget currentwidget = const Myevents();
  List<Widget> listwidget = [
    Mystyle().showtitle1("MY EVENTS", Colors.white),
    Mystyle().showtitle1("MY CUSTOMER", Colors.white),
    Mystyle().showtitle1(" EVENTEXPRID", Colors.white)
  ];
  int index = 0;
  @override
  void initState() {
    super.initState();
    setState(() {
      finduser();
    });
    //usermodel = widget.usermodel;
  }

  Future<void> finduser() async {
    preferences = await SharedPreferences.getInstance();
    iduser = preferences!.getString("iduser");
    nameuser = preferences!.getString('username');
    usertype = preferences!.getString("usertype");
    idcustomer = preferences!.getString("idcustomer");
    usercustomer = preferences!.getString("usercustomer");
    customertype = preferences!.getString("customertype");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(Myconstant().appbar),
        leading: opendrawer(),
        title: Container(
          margin: const EdgeInsets.only(left: 30.0),
          child: Row(
            children: [
              listwidget[index],
            ],
          ),
        ),
      ),
      drawer: drawermainuser(),
      body: currentwidget,
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
              menugueste(),
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
      title: Mystyle().showtitle2(" EVENTS", Color(Myconstant().iconcolor)),
      hoverColor: Colors.red,
      onTap: () {
        setState(() {
          index = 0;
          currentwidget = const Myevents();
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
      title:
          Mystyle().showtitle2(" CUSTOMER", Color(Myconstant().iconcolor)),
      hoverColor: Colors.black54,
      onTap: () {
        setState(() {
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
            nameuser != null
                ? Mystyle()
                    .showtitle1("user $nameuser", Color(Myconstant().iconcolor))
                : Mystyle().showtitle1(
                    "user $usercustomer", Color(Myconstant().iconcolor)),
          ],
        ),
      ),
    );
  }
}
