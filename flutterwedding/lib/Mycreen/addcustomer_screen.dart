import 'dart:convert';

import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterwedding/Myconstant/myconstant.dart';
import 'package:flutterwedding/Mystyle/mystyle.dart';
import 'package:flutterwedding/Myutilities/mydialog.dart';

class Addcustomer extends StatefulWidget {
  final String? iduser;
  final String? nameuser;
  const Addcustomer({
    Key? key,
    this.iduser,
    this.nameuser,
  }) : super(key: key);

  @override
  State<Addcustomer> createState() => _AddcustomerState();
}

class _AddcustomerState extends State<Addcustomer> {
  late double widths, heights;
  bool eyes = true;
  String? iduser,
      nameuser,
      namecustomer,
      usercustomer,
      password,
      phone,
      address;

  @override
  void initState() {
    super.initState();
    //finduser();
    iduser = widget.iduser;
    nameuser = widget.nameuser;
  }

  // Future<void> finduser() async {
  //   SharedPreferences preferences = await SharedPreferences.getInstance();
  //   setState(() {
  //     username = preferences.getString('username');
  //   });
  // }

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
          child: Mystyle().showtitle1("ADD CUSTOMER", Colors.white),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(
          FocusNode(),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              buildpicture(),
              Mystyle().showtitle1("SABAY KOT", Colors.red.shade700),
              customername(),
              customerusername(),
              passwordcustomer(),
              phonecustomer(),
              addresscustomer(),
              const SizedBox(height: 15.0),
              buildcreatebuttom(),

              // const SizedBox(height: 100.0),
            ],
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
        if (namecustomer == null ||
            namecustomer == "" ||
            usercustomer == null ||
            usercustomer == "" ||
            password == null ||
            password == "" ||
            phone == null ||
            phone == "" ||
            address == null ||
            address == "") {
          mydialog(context, 'pleasinputdata...!');
        } else {
          checkusercustomer();
          //insertuser();
        }
      },
      child: Mystyle().showtitle1("Create", Colors.white),
    );
  }

  Future<void> checkusercustomer() async {
    String url1 =
        "${Myconstant().domain}/projectsabaykot/getcustomerWhereUsercustomer.php?isAdd=true&usercustomer=$usercustomer";
    String url2 =
        "${Myconstant().domain}/projectsabaykot/getadminWhereUseradmin.php?isAdd=true&username=$usercustomer";
    try {
      Response response1 = await Dio().get(url1);
      Response response2 = await Dio().get(url2);
      if (response1.toString() == 'null' && response2.toString() == 'null') {
        insertcustomer();
      } else {
        // ignore: use_build_context_synchronously
        mydialog(context, 'plaese chang username...!');
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      mydialog(context, 'error==>ok');
    }
  }

  Future<void> insertcustomer() async {
    String url =
        "${Myconstant().domain}/projectsabaykot/insertcustomer.php?isAdd=true&iduser=$iduser&nameuser=$nameuser&namecustomer=$namecustomer&usercustomer=$usercustomer&password=$password&phone=$phone&address=$address&status=customer";

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
    return Container(
      margin: const EdgeInsets.all(15.0),
      child: Row(
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
            width: widths * 0.5,
            height: widths * 0.46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 3.0, color: Color(Myconstant().appbar)),
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
      ),
    );
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

  Widget customername() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white54,
      ),
      height: 50.0,
      width: widths * 0.65,
      child: TextField(
        onChanged: (value) => namecustomer = value.toString(),
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

  Widget customerusername() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white54,
      ),
      height: 50.0,
      width: widths * 0.65,
      child: TextField(
        onChanged: (value) => usercustomer = value.toString(),
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

  Widget passwordcustomer() {
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

  Widget phonecustomer() {
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

  Widget addresscustomer() {
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
