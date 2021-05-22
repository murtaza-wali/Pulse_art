import 'package:art/HexCodeConverter/Hexcode.dart';
import 'package:flutter/material.dart';
import 'dart:ui';

class ReusableWidgets {
  Color color2 = HexColor("#055e8e");
  getAppBar(String title) {

    return AppBar(
      title: Text(title),
      automaticallyImplyLeading: true, // hides default back button
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [color2, Colors.black],
          ),
        ),
      ),
    );
  }
}