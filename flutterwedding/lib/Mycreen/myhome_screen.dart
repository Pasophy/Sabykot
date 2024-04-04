import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter/material.dart';
import 'package:flutterwedding/Myconstant/myconstant.dart';
import 'package:flutterwedding/Mycreen/maincustomer.dart';
import 'package:flutterwedding/Mycreen/mainusers_screen.dart';
import 'package:flutterwedding/Mycreen/mysignin_screen.dart';
import 'package:flutterwedding/Mycreen/mysignup_screen.dart';
import 'package:flutterwedding/Mymodel/customermodel.dart';
import 'package:flutterwedding/Mymodel/usermodel.dart';
import 'package:flutterwedding/Mystyle/mystyle.dart';
import 'package:flutterwedding/Myutilities/mydialog.dart';
import 'package:flutterwedding/Myutilities/opendrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Myhomecreen extends StatefulWidget {
  const Myhomecreen({super.key});

  @override
  State<Myhomecreen> createState() => _MyhomecreenState();
}

class _MyhomecreenState extends State<Myhomecreen> {
  Usermodel? usermodel;
  Customermodel? customermodel;
  String? usertype;
  String? usercusname;

  late double widths, heights;
  bool eyes = true;
  String? username, password;
  @override
  void initState() {
    super.initState();
    checkuserloging();
  }

  Future<void> checkuserloging() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
        usertype = preferences.getString('usertype');
        usercusname = preferences.getString("usercustomer");
        if (usertype == "admin") {
          routrtoservice(const Mymainusers());
        } else if (usertype == "customer") {
          routrtoservice(const Maincustomer());
        }
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      mydialog(context, 'no internet');
    }
  }

  void routrtoservice(Widget widget) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => widget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    widths = MediaQuery.sizeOf(context).width;
    heights = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(
          leading: opendrawer(),
          backgroundColor: Color(Myconstant().appbar),
          title: Mystyle().showtitle1(
            "សូមស្វាគមន៍សប្បាយកត់",
            Color(Myconstant().titlecolor),
          )),
      drawer: drawerhomescrenc(),
      body: Container(
        decoration: BoxDecoration(
          color: Color(Myconstant().appbar),
          gradient: RadialGradient(
            colors: [
              Colors.white,
              Colors.blue.shade600,
            ],
            radius: 1.9,
            center: const Alignment(-0.1, -0.1),
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                showbanner(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showbanner() {
    return ImageSlideshow(
      /// Width of the [ImageSlideshow].
      width: double.infinity,

      /// Height of the [ImageSlideshow].
      height: 700.0,

      /// The page to show when first creating the [ImageSlideshow].
      initialPage: 0,

      /// The color to paint the indicator.
      indicatorColor: Colors.blue.shade800,

      /// The color to paint behind th indicator.
      indicatorBackgroundColor: Colors.grey,

      /// Called whenever the page in the center of the viewport changes.
      onPageChanged: (value) {
        print('Page changed: $value');
      },

      /// Auto scroll interval.
      /// Do not auto scroll with null or 0.
      //autoPlayInterval: 3000,

      /// Loops back to first slide.
      isLoop: true,

      /// The widgets to display in the [ImageSlideshow].
      /// Add the sample image file into the images folder
      children: <Widget>[
        Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 370.0,
                width: 350.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.white,
                    style: BorderStyle.solid,
                    width: 3.0,
                  ),
                ),
                child: const CircleAvatar(
                  backgroundImage: ExactAssetImage("images/logo.jpg"),
                ),
              ),
            ],
          ),
        ),
        Image.asset(
          'images/Wedding1.png',
          fit: BoxFit.fill,
        ),
        Image.asset(
          'images/Wedding2.png',
          fit: BoxFit.fill,
        ),
        Image.asset(
          'images/Wedding3.png',
          fit: BoxFit.fill,
        ),
        Image.asset(
          'images/Wedding4.png',
          fit: BoxFit.fill,
        ),
        Image.asset(
          'images/Wedding5.png',
          fit: BoxFit.fill,
        ),
      ],
    );
  }

  Widget drawerhomescrenc() {
    return Drawer(
      child: Stack(
        children: [
          Column(
            children: [
              drawerheader(),
              const SizedBox(height: 15.0),
              menusignin(),
              menusignup(),
            ],
          ),
          boildlogo(),
          menulogout(),
        ],
      ),
    );
  }

  Widget menusignin() {
    return ListTile(
      leading: SizedBox(
          height: 40.0,
          width: 40.0,
          child: CircleAvatar(
            backgroundColor: Color(Myconstant().iconcolor),
            child:
                const Icon(Icons.exit_to_app, size: 25.0, color: Colors.white),
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

  Widget menusignup() {
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
}
