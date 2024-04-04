import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterwedding/Myconstant/myconstant.dart';
import 'package:flutterwedding/Mystyle/mystyle.dart';
import 'package:flutterwedding/Myutilities/mydialog.dart';

class Addyourguest extends StatefulWidget {
  final String? idvent;
  final String? idcustomer;
  const Addyourguest({
    Key? key,
    this.idvent,
    this.idcustomer,
  }) : super(key: key);

  @override
  State<Addyourguest> createState() => _AddyourguestState();
}

class _AddyourguestState extends State<Addyourguest> {
  late double widths, heights;
  String? idevents,
      idcustomers,
      currency,
      paymenttype,
      paymentstatus,
      guestname,
      amount,
      address;

  final TextEditingController _namecontroller = TextEditingController();
  final TextEditingController _amountcontroller = TextEditingController();
  final TextEditingController _addresscontroller = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    idevents = widget.idvent;
    idcustomers = widget.idcustomer;
  }

  @override
  Widget build(BuildContext context) {
    widths = MediaQuery.sizeOf(context).width;
    heights = MediaQuery.sizeOf(context).height;
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(
        FocusNode(),
      ),
      child: Scaffold(
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
            title: Mystyle().showtitle1("បញ្ចូលឈ្មោះភ្ញៀវ", Colors.white),
          ),
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const SizedBox(height: 20.0),
                  buildguestname(),
                  const SizedBox(height: 15.0),
                  buildcurrency(),
                  const SizedBox(height: 15.0),
                  buildamount(),
                  const SizedBox(height: 15.0),
                  buildpaymenttype(),
                  const SizedBox(height: 15.0),
                  buildpaymentstatus(),
                  const SizedBox(height: 15.0),
                  addressguest(),
                  const SizedBox(height: 20.0),
                  buildsavebuttom(),
                ],
              ),
            ),
          )),
    );
  }

  Widget buildguestname() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white54,
      ),
      height: 50.0,
      width: widths * 0.7,
      child: TextField(
        controller: _namecontroller,
        onChanged: (value) => guestname = value.toString(),
        decoration: InputDecoration(
          labelText: 'ឈ្មោះភ្ញៀវ:',
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

  Widget buildcurrency() {
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Color(Myconstant().appbar))),
      width: widths * 0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          radiorail(),
          radiodollar(),
        ],
      ),
    );
  }

  Row radiorail() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Radio(
          value: 'រៀល',
          groupValue: currency,
          onChanged: (value) {
            setState(() {
              currency = value;
            });
          },
          fillColor: MaterialStatePropertyAll(Color(Myconstant().appbar)),
        ),
        Text(
          'រៀល',
          style: TextStyle(
            color: Color(Myconstant().appbar),
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        const SizedBox(
          width: 25.0,
        ),
      ],
    );
  }

  Row radiodollar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Radio(
          value: 'ដុល្លារ',
          groupValue: currency,
          onChanged: (value) {
            setState(() {
              currency = value;
            });
          },
          fillColor: MaterialStatePropertyAll(Color(Myconstant().appbar)),
        ),
        Text(
          'ដុល្លារ',
          style: TextStyle(
            color: Color(Myconstant().appbar),
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        const SizedBox(
          width: 25.0,
        ),
      ],
    );
  }

  Widget buildamount() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white54,
      ),
      height: 50.0,
      width: widths * 0.7,
      child: TextField(
        controller: _amountcontroller,
        keyboardType: TextInputType.number,
        onChanged: (value) => amount = value.toString(),
        decoration: InputDecoration(
          labelText: 'ចំនួនទឹកប្រាក់:',
          labelStyle: TextStyle(
            height: -0.5,
            color: Color(Myconstant().appbar),
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: Icon(
            Icons.currency_exchange,
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

  Widget buildpaymenttype() {
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Color(Myconstant().appbar))),
      width: widths * 0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          //buildpayment(),
          radiopaymentsot(),
          radiopaymentsend(),
        ],
      ),
    );
  }

  Row radiopaymentsot() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Radio(
          value: 'លុយសុទ្ធ',
          groupValue: paymenttype,
          onChanged: (value) {
            setState(() {
              paymenttype = value;
            });
          },
          fillColor: MaterialStatePropertyAll(Color(Myconstant().appbar)),
        ),
        Text(
          'លុយសុទ្ធ',
          style: TextStyle(
            color: Color(Myconstant().appbar),
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        const SizedBox(
          width: 25.0,
        ),
      ],
    );
  }

  Row radiopaymentsend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Radio(
          value: 'លុយវេ',
          groupValue: paymenttype,
          onChanged: (value) {
            setState(() {
              paymenttype = value;
            });
          },
          fillColor: MaterialStatePropertyAll(Color(Myconstant().appbar)),
        ),
        Text(
          'លុយវេ',
          style: TextStyle(
            color: Color(Myconstant().appbar),
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
      ],
    );
  }

  Widget buildpaymentstatus() {
    return Container(
      margin: const EdgeInsets.only(top: 15.0),
      decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(color: Color(Myconstant().appbar))),
      width: widths * 0.7,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          radioguestyokdia(),
          SizedBox(width: widths * 0.03),
          radioguestsongdia(),
        ],
      ),
    );
  }

  Row radioguestyokdia() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Radio(
          value: 'យកដៃ',
          groupValue: paymentstatus,
          onChanged: (value) {
            setState(() {
              paymentstatus = value;
            });
          },
          fillColor: MaterialStatePropertyAll(Color(Myconstant().appbar)),
        ),
        Text(
          'យកដៃ',
          style: TextStyle(
            color: Color(Myconstant().appbar),
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        const SizedBox(
          width: 15.0,
        ),
      ],
    );
  }

  Row radioguestsongdia() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Radio(
          value: 'សងដៃ',
          groupValue: paymentstatus,
          onChanged: (value) {
            setState(() {
              paymentstatus = value;
            });
          },
          fillColor: MaterialStatePropertyAll(Color(Myconstant().appbar)),
        ),
        Text(
          'សងដៃ',
          style: TextStyle(
            color: Color(Myconstant().appbar),
            fontWeight: FontWeight.bold,
            fontSize: 20.0,
          ),
        ),
        const SizedBox(
          width: 15.0,
        ),
      ],
    );
  }

  Widget addressguest() {
    return Container(
      margin: const EdgeInsets.only(top: 15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.white54,
      ),
      height: 100.0,
      width: widths * 0.7,
      child: TextField(
        controller: _addresscontroller,
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

  FilledButton buildsavebuttom() {
    return FilledButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Color(Myconstant().appbar)),
        minimumSize: const MaterialStatePropertyAll(
          Size(200.0, 45.0),
        ),
      ),
      onPressed: () {
        if (idevents == null ||
            idcustomers == null ||
            idevents == "" ||
            idcustomers == "") {
          mydialog(context, "សូមមេត្តាចុចថយក្រោយសិន...!");
        } else if (guestname == null ||
            guestname == "" ||
            amount == null ||
            amount == "" ||
            address == null ||
            address == "") {
          mydialog(context, "សូមបញ្ចូលទិន្នន័យឱ្យគ្រប់...!");
        } else if (currency == null ||
            amount == null ||
            paymentstatus == null) {
          mydialog(context, "សូមបំពេញព័ត៌មានឱ្យគ្រប់...!");
        } else {
          insertguests();
        }
      },
      child: Mystyle().showtitle1("រក្សាទុក", Colors.white),
    );
  }

  Future<void> insertguests() async {
    String url =
        "${Myconstant().domain}/projectsabaykot/insertGuest.php?isAdd=true&idevent=$idevents&idcustomer=$idcustomers&nameguest=$guestname&amount=$amount&currency=$currency&paymenttype=$paymenttype&address=$address&status=$paymentstatus";
    try {
      await Dio().get(url).then((value) {
        if (value.toString() == "true") {
          Navigator.pop(context);
          Mystyle().showalertmessage();
          setState(() {
            _namecontroller.clear();
            _amountcontroller.clear();
            _addresscontroller.clear();
          });
        } else {
          mydialog(context, "insert fail");
        }
      });
    } catch (e) {}
  }
}
