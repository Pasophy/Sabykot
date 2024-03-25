import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterwedding/Myconstant/myconstant.dart';
import 'package:flutterwedding/Mymodel/eventmodel.dart';
import 'package:flutterwedding/Mymodel/usermodel.dart';
import 'package:flutterwedding/Mystyle/mystyle.dart';
import 'package:flutterwedding/Myutilities/mydialog.dart';
import 'package:image_picker/image_picker.dart';

class Addcustomer extends StatefulWidget {
  final Usermodel usermodel;
  final String idevent;
  const Addcustomer({
    Key? key,
    required this.usermodel,
    this.idevent = '',
  }) : super(key: key);

  @override
  State<Addcustomer> createState() => _AddcustomerState();
}

class _AddcustomerState extends State<Addcustomer> {
  Usermodel? usermodel;
  late double widths, heights;
  bool eyes = true;
  String? iduser,
      idevent,
      nameuser,
      namecustomer,
      usercustomer,
      password,
      phone,
      address;
  File? file;
  String? urlpicture;

  @override
  void initState() {
    super.initState();
    //finduser();
    usermodel = widget.usermodel;
    iduser = usermodel!.iduser;
    nameuser = usermodel!.nameuser;
    idevent = widget.idevent;
  }

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
        print("iduser==>$iduser====idevent===>$idevent");
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
          uploadphototoserver();
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
        uploadphototoserver();
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
        "${Myconstant().domain}/projectsabaykot/insertcustomer.php?isAdd=true&iduser=$iduser&idevent=$idevent&picture=$urlpicture&namecustomer=$namecustomer&usercustomer=$usercustomer&password=$password&phone=$phone&address=$address&status=customer";

    try {
      Response response = await Dio().get(url);
      var result = json.decode(response.data); //chang unicode8
      if (result.toString() == 'true') {
        Mystyle().showalertmessage();
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
      } else {
        // ignore: use_build_context_synchronously
        mydialog(context, 'insert user fail');
      }
    } catch (e) {}
  }

  Future<void> chooseimagecutomer(ImageSource imageSource) async {
    var object = await ImagePicker().pickImage(
      source: imageSource,
      maxHeight: 800.0,
      maxWidth: 700.0,
    );

    setState(() {
      file = File(object!.path);
    });
  }

  Future<void> uploadphototoserver() async {
    Random random = Random();
    int i = random.nextInt(10000000);
    String nameimage = "customer$i.jpg";
    String urlimage =
        "${Myconstant().domain}/projectsabaykot/uploadPhotocustomerToserver.php";
    try {
      if (file == null) {
        urlpicture = "/projectsabaykot/PhotoCustomer/logo.jpg";
        insertcustomer();
      } else {
        Map<String, dynamic> map = {};
        map["file"] =
            await MultipartFile.fromFile(file!.path, filename: nameimage);
        FormData formData = FormData.fromMap(map);

        Dio().post(urlimage, data: formData).then((value) {
          urlpicture = "/projectsabaykot/PhotoCustomer/$nameimage";
          insertcustomer();
        });
      }
    } catch (e) {}
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
              onPressed: () =>chooseimagecutomer(ImageSource.camera),
              icon: Image.asset("images/image3.png"),
            ),
          ),
          Container(
            width: widths * 0.5,
            height: widths * 0.46,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 3.0, color: Color(Myconstant().appbar)),
              image: file==null? const DecorationImage(
                image: AssetImage("images/logo.jpg"),
              ): DecorationImage(
                image:FileImage(file!),
              ),
            ),
          ),
          SizedBox(
            width: widths * 0.15,
            child: IconButton(
              onPressed: ()=>chooseimagecutomer(ImageSource.gallery),
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
