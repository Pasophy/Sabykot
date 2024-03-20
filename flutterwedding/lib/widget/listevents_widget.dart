import 'package:flutter/material.dart';
import 'package:flutterwedding/Myconstant/myconstant.dart';
import 'package:flutterwedding/Mycreen/addevents_screen.dart';
import 'package:flutterwedding/Mystyle/mystyle.dart';

class Myevents extends StatefulWidget {
  const Myevents({super.key});

  @override
  State<Myevents> createState() => _MyeventsState();
}

class _MyeventsState extends State<Myevents> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Mystyle().showinformation("មិនទាន់មានកម្មវិធី...!"),
        buttomaddevents(),
      ],
    );
  }

  Container buttomaddevents() {
    return Container(
      margin: const EdgeInsets.only(bottom: 10.0, right: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                onPressed: () {
                  MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => const Addevents(),
                  );
                  Navigator.push(context, route);
                },
                backgroundColor: Color(Myconstant().appbar),
                shape: CircleBorder(
                    side: BorderSide(color: Color(Myconstant().appbar))),
                child: const Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
