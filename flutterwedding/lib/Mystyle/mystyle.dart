import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutterwedding/Myconstant/myconstant.dart';

class Mystyle {
  Widget showtitle1(String string, Color color) {
    return Text(
      string,
      style: TextStyle(
        color: color,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget showtitle2(String string, Color color) {
    return Text(
      string,
      style: TextStyle(
        color: color,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget showtitle3(String string, Color color) {
    return Text(
      string,
      style: TextStyle(
        color: color,
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget showtitle4(String string, Color color) {
    return Text(
      string,
      style: TextStyle(
        color: color,
        fontSize: 14,
        fontWeight: FontWeight.bold,
      ),
    );
  }

   Widget showinformation(String text) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,
                style: TextStyle(
                  fontSize: 28.0,
                  fontWeight: FontWeight.bold,
                  color: Color(Myconstant().iconcolor),
                )),
          ],
        ),
      );

  Widget showprogress() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  showalertmessage() {
    Fluttertoast.showToast(
        msg: "successful",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

    Widget showeventdetail(text, color) => Text(
        text,
        style: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.bold, color: color),
      );

      Widget showtitleevent(text, color) => Text(
        text,
        style: TextStyle(
            fontSize: 30.0, fontWeight: FontWeight.bold, color: color),
      );


  Mystyle();
}
