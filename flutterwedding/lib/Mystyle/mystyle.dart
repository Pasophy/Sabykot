import 'package:flutter/material.dart';
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

  Mystyle();
}
