import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterwedding/Myconstant/myconstant.dart';
import 'package:flutterwedding/Mymodel/usermodel.dart';
import 'package:flutterwedding/Mystyle/mystyle.dart';
import 'package:flutterwedding/Myutilities/mydialog.dart';
import 'package:image_picker/image_picker.dart';

class Addevents extends StatefulWidget {
  final Usermodel usermodel;
  const Addevents({
    Key? key,
    required this.usermodel,
  }) : super(key: key);

  @override
  State<Addevents> createState() => _AddeventsState();
}

class _AddeventsState extends State<Addevents> {
  Usermodel? usermodel;
  late double widths, hieghts;
  File? file;
  String? urlpicture;
  final TextEditingController eventdatecontroller = TextEditingController();
  final TextEditingController eventtimecontroller = TextEditingController();
  String? iduser, nameuser, eventname, eventdetail;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usermodel = widget.usermodel;
    iduser = usermodel!.iduser;
    nameuser = usermodel!.nameuser;
  }

  @override
  Widget build(BuildContext context) {
    widths = MediaQuery.sizeOf(context).width;
    hieghts = MediaQuery.sizeOf(context).height;
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
          child: Mystyle().showtitle1("បញ្ចូលឈ្មោះកម្មវិធី", Colors.white),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(
          FocusNode(),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 25.0),
              buildpicture(),
              const SizedBox(height: 10.0),
              Mystyle().showtitle1("SABAY KOT", Color(Myconstant().appbar)),
              buildeventsname(),
              buildcreatevntdate(),
              buildcreatevnttime(),
              builddetailevents(),
              const SizedBox(height: 30.0),
              buildcreatebuttom(),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> insertevents() async {
    String url =
        "${Myconstant().domain}/projectsabaykot/insertEvents.php?isAdd=true&iduser=$iduser&nameuser=$nameuser&eventname=$eventname&picture=$urlpicture&eventdetail=$eventdetail&eventdate=${eventdatecontroller.text}&eventtime=${eventtimecontroller.text}&status=disable";
    try {
      await Dio().get(url).then((value) {
        var result = json.decode(value.data); //chang unicode8
        if (result.toString() == 'true') {
          // ignore: use_build_context_synchronously
          Navigator.pop(context);
          Mystyle().showalertmessage();
        } else {
          // ignore: use_build_context_synchronously
          mydialog(context, 'insert fail');
        }
      });
    } catch (e) {}
  }

  Future<void> chooseimageevents(ImageSource imageSource) async {
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

  Future<void> uploadeventstoserver() async {
    Random random = Random();
    int i = random.nextInt(100000000);
    String nameimage = "event$i.jpg";
    String urlimage =
        "${Myconstant().domain}/projectsabaykot/uploadPhotoEventsToserver.php";
    try {
      if (file == null) {
        urlpicture = "/projectsabaykot/PhotoEvents/logo.jpg";
        insertevents();
      } else {
        Map<String, dynamic> map = {};
        map["file"] =
            await MultipartFile.fromFile(file!.path, filename: nameimage);
        FormData formData = FormData.fromMap(map);
        await Dio().post(urlimage, data: formData).then((value) {
          urlpicture = "/projectsabaykot/PhotoEvents/$nameimage";
          insertevents();
        });
      }
    } catch (e) {}
  }

  Row buildpicture() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: widths * 0.15,
          child: IconButton(
            onPressed: () => chooseimageevents(ImageSource.camera),
            icon: Image.asset("images/image3.png"),
          ),
        ),
        Container(
          width: widths * 0.42,
          height: widths * 0.42,
          decoration: BoxDecoration(
            border: Border.all(width: 3.0, color: Color(Myconstant().appbar)),
            shape: BoxShape.circle,
            image: file == null
                ? const DecorationImage(
                    image: AssetImage("images/logo.jpg"),
                  )
                : DecorationImage(
                    image: FileImage(file!),
                  ),
          ),
        ),
        SizedBox(
          width: widths * 0.15,
          child: IconButton(
            onPressed: () => chooseimageevents(ImageSource.gallery),
            icon: Image.asset("images/image2.png"),
          ),
        ),
      ],
    );
  }

  Widget buildeventsname() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white54,
      ),
      height: 50.0,
      width: widths * 0.67,
      child: TextField(
        onChanged: (value) => eventname = value.toString(),
        decoration: InputDecoration(
          labelText: 'ឈ្មោះកម្មវិធី:',
          labelStyle: TextStyle(
            height: -0.5,
            color: Color(Myconstant().appbar),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: Icon(
            Icons.event,
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

  Widget builddetailevents() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white54,
      ),
      height: 110.0,
      width: widths * 0.67,
      child: TextField(
        maxLines: 5,
        onChanged: (value) => eventdetail = value.toString(),
        decoration: InputDecoration(
          labelText: 'អធិប្បាយកម្មវិធី:',
          labelStyle: TextStyle(
            height: -0.5,
            color: Color(Myconstant().appbar),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: Icon(
            Icons.details,
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

  Widget buildcreatevntdate() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white54,
      ),
      height: 50.0,
      width: widths * 0.67,
      child: TextField(
        readOnly: true,
        controller: eventdatecontroller,
        //onChanged: (value) => eventdate = value.toString(),
        decoration: InputDecoration(
          labelText: 'ថ្ងៃទីកម្មវិធី:',
          labelStyle: TextStyle(
            height: -0.5,
            color: Color(Myconstant().appbar),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: IconButton(
              color: Color(Myconstant().appbar),
              onPressed: () async {
                final DateTime? dateTime = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2023),
                    lastDate: DateTime(2050).add(const Duration(days: 365)));
                if (dateTime == null) {
                  // ignore: use_build_context_synchronously
                  mydialog(context, "សូមជ្រើសរើសថ្ងៃខែ...!");
                } else {
                  final formatdate =
                      formatDate(dateTime, [dd, '-', mm, '-', yyyy]);
                  setState(() {
                    eventdatecontroller.text = formatdate.toString();
                  });
                }
              },
              icon: const Icon(Icons.date_range)),
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

  Widget buildcreatevnttime() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white54,
      ),
      height: 50.0,
      width: widths * 0.67,
      child: TextField(
        readOnly: true,
        controller: eventtimecontroller,
        decoration: InputDecoration(
          labelText: 'ម៉ោងកម្មវិធី:',
          labelStyle: TextStyle(
            height: -0.5,
            color: Color(Myconstant().appbar),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: IconButton(
              color: Color(Myconstant().appbar),
              onPressed: () async {
                final TimeOfDay? timeOfDay = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                if (timeOfDay == null) {
                  // ignore: use_build_context_synchronously
                  mydialog(context, "សូមជ្រើសរើសម៉ោង...!");
                } else {
                  setState(() {
                    eventtimecontroller.text = timeOfDay.format(context);
                  });
                }
              },
              icon: const Icon(Icons.timer)),
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

  FilledButton buildcreatebuttom() {
    return FilledButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Color(Myconstant().appbar)),
        minimumSize: const MaterialStatePropertyAll(
          Size(200.0, 45.0),
        ),
      ),
      onPressed: () {
        if (eventname == "" ||
            eventname == null ||
            eventdetail == "" ||
            eventdetail == null ||
            eventdatecontroller.text.isEmpty ||
            eventtimecontroller.text.isEmpty) {
          mydialog(context, "Insert fail");
        } else {
          uploadeventstoserver();
        }
      },
      child: Mystyle().showtitle1("បង្កើត", Colors.white),
    );
  }
}
