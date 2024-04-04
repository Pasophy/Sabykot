import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutterwedding/Myconstant/myconstant.dart';
import 'package:flutterwedding/Mymodel/guestmodel.dart';
import 'package:flutterwedding/Mystyle/mystyle.dart';
import 'package:flutterwedding/Myutilities/mydialog.dart';

class Editmyguest extends StatefulWidget {
  final List<Guestmodel> listguest;
  final int? index;
  const Editmyguest({
    Key? key,
    this.listguest = const [],
    this.index,
  }) : super(key: key);

  @override
  State<Editmyguest> createState() => _EditmyguestState();
}

class _EditmyguestState extends State<Editmyguest> {
  List<Guestmodel> listguest = [];
  int? index;

  late double widths, heights;
  String? idguest,
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
    setState(() {
      listguest = widget.listguest;
      index = widget.index;
      currency = listguest[index!].currency;
      paymenttype = listguest[index!].paymenttype;
      paymentstatus = listguest[index!].status;
      idguest = listguest[index!].idguest;
     guestname= _namecontroller.text = listguest[index!].nameguest.toString();
     amount= _amountcontroller.text = listguest[index!].amount.toString();
     address= _addresscontroller.text = listguest[index!].address.toString();
    });
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
          title: Container(
              margin: const EdgeInsets.only(left: 40.0),
              child: Mystyle().showtitle1("កែប្រែទិន្នន័យ", Colors.white)),
        ),
        body: listguest.isEmpty
            ? Mystyle().showprogress()
            : SingleChildScrollView(
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
                      buildeditbuttom(),
                    ],
                  ),
                ),
              ),
      ),
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
      child: TextFormField(
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
      child: TextFormField(
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
      child: TextFormField(
        maxLines: 3,
        controller: _addresscontroller,
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

  FilledButton buildeditbuttom() {
    return FilledButton(
      style: ButtonStyle(
        backgroundColor: MaterialStatePropertyAll(Color(Myconstant().appbar)),
        minimumSize: const MaterialStatePropertyAll(
          Size(200.0, 45.0),
        ),
      ),
      onPressed: () {
        if (_amountcontroller.text.isEmpty ||
            _amountcontroller.text == "" ||
            _addresscontroller.text == "" ||
            _addresscontroller.text.isEmpty ||
            _namecontroller.text.isEmpty ||
            _namecontroller.text == "") {
          mydialog(context, "សូមបញ្ចូលទិន្នន័យឱ្យគ្រប់...!");
        } else {
          editguests();
        }
      },
      child: Mystyle().showtitle1("កែប្រែ", Colors.white),
    );
  }

  Future<void> editguests() async {
    String url =
        "${Myconstant().domain}/projectsabaykot/EditGuesstWhereidGuest.php?isAdd=true&idguest=$idguest&nameguest=$guestname&amount=$amount&currency=$currency&paymenttype=$paymenttype&address=$address&status=$paymentstatus";
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
          mydialog(context, "no connection");
        }
      });
    } catch (e) {}
  }
}
