import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter/material.dart';
import 'package:flutterwedding/Myconstant/myconstant.dart';
import 'package:flutterwedding/Mycreen/mainusers_screen.dart';
import 'package:flutterwedding/Mymodel/usermodel.dart';
import 'package:flutterwedding/Mystyle/mystyle.dart';
import 'package:flutterwedding/Myutilities/drawer_homescreen.dart';
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
  String? username;
  @override
  void initState() {
    super.initState();
    checkuserloging();
  }

  Future<void> checkuserloging() async {
    try {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      setState(() {
        username = preferences.getString('username');
        if (username != null) {
          getuserwhereulogin();
        }
      });
    } catch (e) {
      // ignore: use_build_context_synchronously
      mydialog(context, 'Error');
    }
  }

  Future<void> getuserwhereulogin() async {
    String url =
        "${Myconstant().domain}/projectsabaykot/getadminWhereUseradmin.php?isAdd=true&username=$username";

    try {
      await Dio().get(url).then((value) {
        var result = json.decode(value.data);
        if (result.toString() != 'null') {
          for (var map in result) {
           setState(() {
              usermodel = Usermodel.fromJson(map);
           });
          }
          routrtoservice(Mymainusers(usermodel: usermodel!));
        } else {
          mydialog(context, 'មិនទាន់មានអ្នកប្រើ ...!');
        }
      });
    } catch (e) {}
  }

  void routrtoservice(Widget widget) {
    MaterialPageRoute route = MaterialPageRoute(
      builder: (context) => widget,
    );
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          leading: opendrawer(),
          backgroundColor: Colors.blue.shade600,
          title: Mystyle().showtitle1(
            "WELCOME SABAY KOT",
            Color(Myconstant().titlecolor),
          )),
      drawer: drawerhomescrenc(context),
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [
              Colors.yellow,
              Colors.amber,
              Colors.yellow,
            ],
            center: Alignment(-0.01, -0.09),
            radius: 0.7,
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
      indicatorColor: Colors.blue,

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
}
