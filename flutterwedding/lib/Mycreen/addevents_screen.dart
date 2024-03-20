import 'package:date_format/date_format.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterwedding/Myconstant/myconstant.dart';
import 'package:flutterwedding/Mystyle/mystyle.dart';
import 'package:flutterwedding/Myutilities/mydialog.dart';

class Addevents extends StatefulWidget {
  const Addevents({super.key});

  @override
  State<Addevents> createState() => _AddeventsState();
}

class _AddeventsState extends State<Addevents> {
  late double widths, hieghts;
  TextEditingController datecontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();

  String? eventdate;
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
          child: Mystyle().showtitle1("ADD EVENTS", Colors.white),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(
          FocusNode(),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              buildpicture(),
              const SizedBox(height: 10.0),
              Mystyle().showtitle1("SABAY KOT", Colors.red.shade700),
              buildeventsname(),
              buildcreatevntdate(),
              buildcreatevnttime(),
              evntexpridatedate(),
              builddetailevents(),
              const SizedBox(height: 30.0),
              buildcreatebuttom(),
            ],
          ),
        ),
      ),
    );
  }

  Row buildpicture() {
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
        //onChanged: (value) => namecustomer = value.toString(),
        decoration: InputDecoration(
          labelText: 'Eventname:',
          labelStyle: TextStyle(
            height: -0.5,
            color: Color(Myconstant().reds),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: Icon(
            Icons.event,
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
        //onChanged: (value) => namecustomer = value.toString(),
        decoration: InputDecoration(
          labelText: 'Eventdetail:',
          labelStyle: TextStyle(
            height: -0.5,
            color: Color(Myconstant().reds),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: Icon(
            Icons.details,
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
        controller: datecontroller,
        onChanged: (value) => eventdate = value.toString(),
        decoration: InputDecoration(
          labelText: 'Eventdate:',
          labelStyle: TextStyle(
            height: -0.5,
            color: Color(Myconstant().reds),
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
                    datecontroller.text = formatdate.toString();
                    eventdate = datecontroller.toString();
                  });
                }
              },
              icon: const Icon(Icons.date_range)),
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

  Widget evntexpridatedate() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white54,
      ),
      height: 50.0,
      width: widths * 0.67,
      child: TextField(
        controller: datecontroller,
        onChanged: (value) => eventdate = value.toString(),
        decoration: InputDecoration(
          labelText: 'Expridate:',
          labelStyle: TextStyle(
            height: -0.5,
            color: Color(Myconstant().reds),
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
                    datecontroller.text = formatdate.toString();
                    eventdate = datecontroller.toString();
                  });
                }
              },
              icon: const Icon(Icons.date_range)),
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
        controller: timecontroller,
        onChanged: (value) => eventdate,
        decoration: InputDecoration(
          labelText: 'Eventtime:',
          labelStyle: TextStyle(
            height: -0.5,
            color: Color(Myconstant().reds),
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
                setState(() {
                  timecontroller.text = timeOfDay!.format(context);
                });
              },
              icon: const Icon(Icons.timer)),
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
        print("date=========>${datecontroller.value}");
        print("eate=========>$eventdate");
      },
      child: Mystyle().showtitle1("Create", Colors.white),
    );
  }
}
