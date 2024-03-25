import 'package:flutter/material.dart';
import 'package:flutterwedding/Myconstant/myconstant.dart';
import 'package:flutterwedding/Mycreen/myhome_screen.dart';
import 'package:flutterwedding/Mycreen/search_event_screen.dart';
import 'package:flutterwedding/Mymodel/usermodel.dart';
import 'package:flutterwedding/Mystyle/mystyle.dart';
import 'package:flutterwedding/Myutilities/opendrawer.dart';
import 'package:flutterwedding/widget/listevents_widget.dart';
import 'package:flutterwedding/widget/listguestes_wiget.dart';
import 'package:flutterwedding/widget/mycustomer_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mymainusers extends StatefulWidget {
  final Usermodel usermodel;
  const Mymainusers({
    Key? key,
    required this.usermodel,
  }) : super(key: key);

  @override
  State<Mymainusers> createState() => _MymainusersState();
}

class _MymainusersState extends State<Mymainusers> {
  Usermodel? usermodels;
  String? iduser, nameuser, usertype;
  String? idcustomer, usercustomer, customertype;
  SharedPreferences? preferences;
  Widget? currentwidget;
  late double widths, heights;
  bool showseach = true;

  List<Widget> listwidget = [
    Mystyle().showtitle1("MY EVENTS", Colors.white),
    Mystyle().showtitle1("MY CUSTOMER", Colors.white),
    Mystyle().showtitle1(" EVENTEXPRID", Colors.white),
    textfieldsearch(),
  ];

  int index = 0;
  @override
  void initState() {
    super.initState();
    setState(() {
      finduser();
    });
    usermodels = widget.usermodel;
    currentwidget = Myevents(usermodel: usermodels!);
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
    widths = MediaQuery.sizeOf(context).width;
    heights = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade600,
        leading: opendrawer(),
        actions: [
          showseach
              ? Container(
                  margin: const EdgeInsets.only(right: 20.0),
                  child: IconButton(
                    onPressed: () {
                      MaterialPageRoute route = MaterialPageRoute(
                        builder: (context) =>
                            Searchevent(usermodel: usermodels!),
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
          showseach = true;
          index = 0;
          currentwidget = Myevents(usermodel: usermodels!);
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
        showseach = false;
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
