import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterwedding/Myconstant/myconstant.dart';
import 'package:flutterwedding/Mycreen/maincustomer.dart';
import 'package:flutterwedding/Mycreen/mainusers_screen.dart';
import 'package:flutterwedding/Mymodel/customermodel.dart';
import 'package:flutterwedding/Mymodel/usermodel.dart';
import 'package:flutterwedding/Mystyle/mystyle.dart';
import 'package:flutterwedding/Myutilities/mydialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mysignin extends StatefulWidget {
  const Mysignin({super.key});

  @override
  State<Mysignin> createState() => _MysigninState();
}

class _MysigninState extends State<Mysignin> {
  Usermodel? usermodel;
  Customermodel? customermodel;
  bool eyes = true;
  String? username, password;
  String? usercustomer, passcustomer;
  late double widths, heights;

  @override
  Widget build(BuildContext context) {
    widths = MediaQuery.sizeOf(context).width;
    heights = MediaQuery.sizeOf(context).height;

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
        title: Container(
          margin: const EdgeInsets.only(left: 50.0),
          child: Mystyle().showtitle1("ចូលគណនីរបស់អ្នក", Colors.white),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(
          FocusNode(),
        ),
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Colors.blue.shade50,
                  Colors.white,
                  Colors.blue.shade300,
                ],
                center: const Alignment(-0.02, -0.2),
                radius: 0.9,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 30.0),
                    showmylogo(),
                    const SizedBox(height: 15.0),
                    Mystyle()
                        .showtitle1("SABAY KOT", Color(Myconstant().appbar)),
                    textfieldusername(),
                    textfieldpassword(),
                    const SizedBox(height: 15.0),
                    buildsigninbuttom(),
                    const SizedBox(height: 150.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildsigninbuttom() {
    return FilledButton(
      style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll(Color(Myconstant().appbar)),
          minimumSize: const MaterialStatePropertyAll(
            Size(200.0, 45.0),
          )),
      onPressed: () {
        setState(() {
          checkuserlogin();
        });
      },
      child: Mystyle().showtitle1("ចូលគណនី", Colors.white),
    );
  }

  Future<void> checkuserlogin() async {
    try {
      String url1 =
          "${Myconstant().domain}/projectsabaykot/getadminWhereUseradmin.php?isAdd=true&username=$username";
      Response response1 = await Dio().get(url1);
      var result1 = json.decode(response1.data);
      if (response1.toString() == 'null') {
        String url2 =
            "${Myconstant().domain}/projectsabaykot/getcustomerWhereUsercustomer.php?isAdd=true&usercustomer=$username";
        try {
          Response response2 = await Dio().get(url2);
          var result2 = json.decode(response2.data);
          if (response2.toString() == 'null') {
            // ignore: use_build_context_synchronously
            mydialog(context, 'No username ...!');
          } else {
            for (var map in result2) {
              customermodel = Customermodel.fromJson(map);
              if (password == customermodel!.password &&
                  username == customermodel!.usercustomer) {
                routetoservices(const Maincustomer(), customermodel!);
              } else {
                // ignore: use_build_context_synchronously
                mydialog(context, 'please check password uername...!');
              }
            }
          }
        } catch (e) {
          // ignore: use_build_context_synchronously
          mydialog(context, 'no internet');
        }
      } else {
        for (var map in result1) {
          usermodel = Usermodel.fromJson(map);
          if (password == usermodel!.password &&
              username == usermodel!.username) {
            routetoservice(const Mymainusers(), usermodel!);
          } else {
            // ignore: use_build_context_synchronously
            mydialog(context, 'check password uername...!');
          }
        }
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      mydialog(context, 'no internet1');
    }
  }

  Future<void> checkpreferencescustomer(Customermodel customermodel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('idcustomer', customermodel.idcustomer.toString());
    preferences.setString('usertype', customermodel.status.toString());
    preferences.setString(
        'usercustomer', customermodel.usercustomer.toString());
  }

  Future<void> checkpreferenceuser(Usermodel usermodel) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('iduser', usermodel.iduser.toString());
    preferences.setString('username', usermodel.username.toString());
    preferences.setString('usertype', usermodel.status.toString());
  }

  void routetoservices(Widget mywidget, Customermodel customermodel) {
    checkpreferencescustomer(customermodel);
    MaterialPageRoute route = MaterialPageRoute(builder: (context) => mywidget);
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  void routetoservice(Widget mywidget, Usermodel usermodel) {
    checkpreferenceuser(usermodel);
    MaterialPageRoute route = MaterialPageRoute(builder: (context) => mywidget);
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }

  Widget showmylogo() {
    return Container(
      height: 200.0,
      width: 200.0,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Color(Myconstant().appbar),
          style: BorderStyle.solid,
          width: 2.5,
        ),
      ),
      child: const CircleAvatar(
        backgroundImage: AssetImage("images/logo.jpg"),
      ),
    );
  }

  Widget textfieldusername() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white54,
      ),
      height: 50.0,
      width: widths * 0.65,
      child: TextField(
        onChanged: (value) => username = value.toString(),
        decoration: InputDecoration(
          labelText: 'ឈ្មោះគណនី:',
          labelStyle: TextStyle(
            height: -0.5,
            color: Color(Myconstant().appbar),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: Icon(
            Icons.perm_identity,
            color: Color(Myconstant().appbar),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(
              color: Color(Myconstant().appbar),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(
              color: Color(Myconstant().appbar),
              width: 1.0,
            ),
          ),
        ),
        style: TextStyle(
          color: Color(Myconstant().appbar),
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          height: 1.0,
        ),
      ),
    );
  }

  Widget textfieldpassword() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white54,
      ),
      height: 50.0,
      width: widths * 0.65,
      child: TextField(
        onChanged: (value) => password = value.toString(),
        obscureText: eyes,
        decoration: InputDecoration(
          labelText: 'លេខសម្ងាត់:',
          labelStyle: TextStyle(
            height: -0.5,
            color: Color(Myconstant().appbar),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: Icon(Icons.lock_open, color: Color(Myconstant().appbar)),
          suffixIcon: IconButton(
            icon: eyes
                ? const Icon(Icons.remove_red_eye)
                : const Icon(Icons.remove_red_eye_outlined),
            onPressed: () {
              setState(() {
                eyes = !eyes;
              });
            },
            color: Color(Myconstant().appbar),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(
              color: Color(Myconstant().appbar),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            borderSide: BorderSide(
              color: Color(Myconstant().appbar),
              width: 1.0,
            ),
          ),
        ),
        style: TextStyle(
          color: Color(Myconstant().appbar),
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          height: 1.0,
        ),
      ),
    );
  }
}
