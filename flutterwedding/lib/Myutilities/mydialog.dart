import 'package:flutter/material.dart';

Future<void> mydialog(BuildContext context, String message) async {
  showDialog(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(
        message,
        style: TextStyle(color: Colors.red.shade700),
      ),
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'OK',
                style: TextStyle(color: Colors.red.shade700, fontSize: 20.0),
              ),
            ),
          ],
        )
      ],
    ),
  );
}
