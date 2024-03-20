import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterwedding/Myconstant/myconstant.dart';
import 'package:flutterwedding/Mystyle/mystyle.dart';
import 'package:flutterwedding/Myutilities/mydialog.dart';

class Mysignup extends StatefulWidget {
  const Mysignup({super.key});

  @override
  State<Mysignup> createState() => _MysignupState();
}

class _MysignupState extends State<Mysignup> {
  late double widths, heights;
  bool eyes = true;
  String? nameuser, username, password, phone, address;
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
          margin: const EdgeInsets.only(left: 80.0),
          child: Mystyle().showtitle1("SIGN UP", Colors.white),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(
          FocusNode(),
        ),
        child: Center(
          child: Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(
                colors: [
                  Colors.white,
                  Colors.yellowAccent,
                  Colors.amber,
                  //Color(Myconstant().titlecolor),
                  //Color(Myconstant().appbar)
                ],
                center: Alignment(-0.02, -0.6),
                radius: 1.2,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    buildpicture(),
                    Mystyle().showtitle1("SABAY KOT", Colors.red.shade700),
                    textfieldname(),
                    textfieldusername(),
                    textfieldpassword(),
                    textfieldphone(),
                    textfieldaddress(),
                    const SizedBox(height: 20.0),
                    buildcreatebuttom(),
                    const SizedBox(height: 80.0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  FilledButton buildcreatebuttom() {
    return FilledButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStatePropertyAll(Color(Myconstant().buttomcolor)),
        minimumSize: const MaterialStatePropertyAll(
          Size(200.0, 45.0),
        ),
      ),
      onPressed: () {
        if (nameuser == null ||
            nameuser == "" ||
            username == null ||
            username == "" ||
            password == null ||
            password == "" ||
            phone == null ||
            phone == "" ||
            address == null ||
            address == "") {
          mydialog(context, 'pleasinputdata...!');
        } else {
          checkuseradmin();
          //insertuser();
        }
      },
      child: Mystyle().showtitle1("Create", Colors.white),
    );
  }

  Future<void> checkuseradmin() async {
    String url1 =
        "${Myconstant().domain}/projectsabaykot/getadminWhereUseradmin.php?isAdd=true&username=$username";
    String url2 =
        "${Myconstant().domain}/projectsabaykot/getcustomerWhereUsercustomer.php?isAdd=true&usercustomer=$username";
    try {
      Response response1 = await Dio().get(url1);
      Response response2 = await Dio().get(url2);
      if (response1.toString() == 'null' && response2.toString() == 'null') {
        insertadmin();
      } else {
        // ignore: use_build_context_synchronously
        mydialog(context, 'plaese chang username...!');
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      mydialog(context, 'error==>ok');
    }
  }

  Future<void> insertadmin() async {
    String url =
        "${Myconstant().domain}/projectsabaykot/insertadmin.php?isAdd=true&nameuser=$nameuser&username=$username&password=$password&phone=$phone&address=$address&status=admin";

    try {
      Response response = await Dio().get(url);
      var result = json.decode(response.data); //chang unicode8
      if (result.toString() == 'true') {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } else {
        // ignore: use_build_context_synchronously
        mydialog(context, 'insert user fail');
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      mydialog(context, "error==>$e");
    }
  }

  Widget buildpicture() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: widths * 0.15,
          child: IconButton(
            onPressed: () {},
            icon: Image.asset("images/image3.png"),
          ),
        ),
        Container(
          margin: const EdgeInsets.all(15.0),
          width: widths * 0.42,
          height: widths * 0.42,
          decoration: BoxDecoration(
            border: Border.all(width: 3.0, color: Color(Myconstant().appbar)),
            shape: BoxShape.circle,
            image: const DecorationImage(
              image: AssetImage("images/logo.jpg"),
            ),
          ),
        ),
        SizedBox(
          width: widths * 0.15,
          child: IconButton(
            onPressed: () {},
            icon: Image.asset("images/image2.png"),
          ),
        ),
      ],
    );
  }

  Widget textfieldname() {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white54,
      ),
      height: 50.0,
      width: widths * 0.65,
      child: TextField(
        onChanged: (value) => nameuser = value.toString(),
        decoration: InputDecoration(
          labelText: 'Fname:',
          labelStyle: TextStyle(
            height: -0.5,
            color: Color(Myconstant().reds),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: Icon(
            Icons.perm_identity,
            color: Color(Myconstant().reds),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Color(Myconstant().reds),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
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

  Widget textfieldusername() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white54,
      ),
      height: 50.0,
      width: widths * 0.65,
      child: TextField(
        onChanged: (value) => username = value.toString(),
        decoration: InputDecoration(
          labelText: 'Username:',
          labelStyle: TextStyle(
            height: -0.5,
            color: Color(Myconstant().reds),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: Icon(
            Icons.perm_identity,
            color: Color(Myconstant().reds),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Color(Myconstant().reds),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
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

  Widget textfieldpassword() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white54,
      ),
      height: 50.0,
      width: widths * 0.65,
      child: TextField(
        onChanged: (value) => password = value.toString(),
        obscureText: eyes,
        decoration: InputDecoration(
          labelText: 'Password:',
          labelStyle: TextStyle(
            height: -0.5,
            color: Color(Myconstant().reds),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: Icon(Icons.lock_open, color: Color(Myconstant().reds)),
          suffixIcon: IconButton(
            icon: eyes
                ? const Icon(Icons.remove_red_eye)
                : const Icon(Icons.remove_red_eye_outlined),
            onPressed: () {
              setState(() {
                eyes = !eyes;
              });
            },
            color: Color(Myconstant().reds),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Color(Myconstant().reds),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
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

  Widget textfieldphone() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white54,
      ),
      height: 50.0,
      width: widths * 0.65,
      child: TextField(
        keyboardType: TextInputType.phone,
        onChanged: (value) => phone = value.toString(),
        decoration: InputDecoration(
          labelText: 'Phone:',
          labelStyle: TextStyle(
            height: -0.5,
            color: Color(Myconstant().reds),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: Icon(
            Icons.phone,
            color: Color(Myconstant().reds),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Color(Myconstant().reds),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
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

  Widget textfieldaddress() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white54,
      ),
      height: 100.0,
      width: widths * 0.65,
      child: TextField(
        maxLines: 3,
        onChanged: (value) => address = value.toString(),
        decoration: InputDecoration(
          labelText: 'Address:',
          labelStyle: TextStyle(
            height: -0.5,
            color: Color(Myconstant().reds),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: Icon(
            Icons.home,
            color: Color(Myconstant().reds),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Color(Myconstant().reds),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
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
}
