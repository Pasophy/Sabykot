import 'package:flutter/material.dart';

Builder opendrawer() {
  return Builder(
    builder: (context) => IconButton(
      onPressed: () => Scaffold.of(context).openDrawer(),
      icon: const Icon(
        Icons.menu,
        size: 30.0,
      ),
      color: Colors.white,
      hoverColor: Colors.red,
      highlightColor: Colors.red,
    ),
  );
}
