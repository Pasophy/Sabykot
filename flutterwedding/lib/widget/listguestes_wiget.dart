import 'package:flutter/material.dart';
import 'package:flutterwedding/Myconstant/myconstant.dart';
import 'package:flutterwedding/Mystyle/mystyle.dart';

class Myguestes extends StatefulWidget {
  const Myguestes({super.key});

  @override
  State<Myguestes> createState() => _MyguestesState();
}

class _MyguestesState extends State<Myguestes> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    body: Mystyle().showinformation("មិនទាន់មានចំនួនភ្ញៀវ...!"),
    );
  }
}
