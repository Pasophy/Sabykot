import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterwedding/Myconstant/myconstant.dart';
import 'package:flutterwedding/Mystyle/mystyle.dart';
import 'package:flutterwedding/Myutilities/mydialog.dart';
import 'package:image_picker/image_picker.dart';

class Mysignup extends StatefulWidget {
  const Mysignup({super.key});

  @override
  State<Mysignup> createState() => _MysignupState();
}

class _MysignupState extends State<Mysignup> {
  late double widths, heights;
  bool eyes = true;
  String? nameuser, username, password, phone, address, urlpicture;

  File? file;
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
          child: Mystyle().showtitle1("បង្កើតគណនី", Colors.white),
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
                center: const Alignment(-0.02, -0.35),
                radius: 0.9,
              ),
            ),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    buildpicture(),
                    Mystyle()
                        .showtitle1("SABAY KOT", Color(Myconstant().appbar)),
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
        backgroundColor: MaterialStatePropertyAll(Color(Myconstant().appbar)),
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
          mydialog(context, 'សូមបញ្ចូលទិន្នន័យឱ្យគ្រប់...!');
        } else {
          checkuseradmin();
          //insertuser();
        }
      },
      child: Mystyle().showtitle1("បង្កើត", Colors.white),
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
        uploadphotoaddim();
      } else {
        // ignore: use_build_context_synchronously
        mydialog(context, 'plaese chang username...!');
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      mydialog(context, 'no connection');
    }
  }

  Future<void> insertadmin() async {
    String url =
        "${Myconstant().domain}/projectsabaykot/insertadmin.php?isAdd=true&picture=$urlpicture&nameuser=$nameuser&username=$username&password=$password&phone=$phone&address=$address&status=admin";

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

  Future<void> chooseimages(ImageSource imageSource) async {
    try {
      var object = await ImagePicker().pickImage(
        source: imageSource,
        maxHeight: 800.0,
        maxWidth: 700.0,
      );
      setState(() {
        file = File(object!.path);
      });
    } catch (e) {}
  }

  Future<void> uploadphotoaddim() async {
    Random random = Random();
    int i = random.nextInt(100000000);
    String nameimage = "addmin$i.jpg";

    String urlphoto =
        "${Myconstant().domain}/projectsabaykot/uploadPhotoToserver.php";

    try {
      if (file == null) {
        urlpicture = "/projectsabaykot/PhotoAddim/logo.jpg";
        insertadmin();
      } else {
        Map<String, dynamic> map = {};
        map["file"] =
            await MultipartFile.fromFile(file!.path, filename: nameimage);
        FormData formData = FormData.fromMap(map);
        await Dio().post(urlphoto, data: formData).then((value) {
          urlpicture = "/projectsabaykot/PhotoAddim/$nameimage";
          insertadmin();
        });
      }
    } catch (e) {}
  }

  Widget buildpicture() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: widths * 0.15,
          child: IconButton(
            onPressed: () => chooseimages(ImageSource.camera),
            icon: Image.asset("images/image3.png"),
          ),
        ),
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(50.0)),
          child: Container(
              margin: const EdgeInsets.all(15.0),
              width: widths * 0.46,
              height: widths * 0.47,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: Colors.amber.shade900,
                    width: 4.0,
                    style: BorderStyle.solid),
                image: file == null
                    ? const DecorationImage(
                        image: AssetImage("images/logo.jpg"), fit: BoxFit.fill)
                    : DecorationImage(
                        image: FileImage(file!), fit: BoxFit.fill),
              )),
        ),
        SizedBox(
          width: widths * 0.15,
          child: IconButton(
            onPressed: () => chooseimages(ImageSource.gallery),
            icon: Image.asset("images/image2.png"),
          ),
        ),
      ],
    );
  }

  Widget textfieldname() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white54,
      ),
      height: 50.0,
      width: widths * 0.65,
      child: TextField(
        onChanged: (value) => nameuser = value.toString(),
        decoration: InputDecoration(
          labelText: 'ឈ្មោះពេញ:',
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
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Color(Myconstant().appbar),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
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
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Color(Myconstant().appbar),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
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
        borderRadius: BorderRadius.circular(10.0),
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
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Color(Myconstant().appbar),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
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
          labelText: 'លេខទូរស័ព្ទ:',
          labelStyle: TextStyle(
            height: -0.5,
            color: Color(Myconstant().appbar),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: Icon(
            Icons.phone,
            color: Color(Myconstant().appbar),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Color(Myconstant().appbar),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
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
          labelText: 'អាស័យដ្ឋាន:',
          labelStyle: TextStyle(
            height: -0.5,
            color: Color(Myconstant().appbar),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: Icon(
            Icons.home,
            color: Color(Myconstant().appbar),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: Color(Myconstant().appbar),
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
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
