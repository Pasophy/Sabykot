
import 'package:flutter/material.dart';
import 'package:flutterwedding/Mystyle/mystyle.dart';

class Guestevents extends StatefulWidget {
  const Guestevents({super.key});

  @override
  State<Guestevents> createState() => _GuesteventsState();
}

class _GuesteventsState extends State<Guestevents> {

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Mystyle().showinformation("មិនទាន់មានភ្ញៀវ...!"),
    );
  }
}