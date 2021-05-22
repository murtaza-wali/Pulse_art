import 'package:art/HexCodeConverter/Hexcode.dart';
import 'package:flutter/material.dart';

class ReuseGradient {
  @override
  getgradient() {
    Color color2 = HexColor("#055e8e");
    return BoxDecoration(
      gradient: LinearGradient(
        begin: Alignment(-0.6, -1),
        end: Alignment(-1, -0),
        colors: [Colors.black, color2],
      ),
      color: Colors.white,
      borderRadius: BorderRadius.circular(17.0),
      boxShadow: <BoxShadow>[
        BoxShadow(
          color: Colors.grey,
          offset: Offset(1.0, 15.0),
          blurRadius: 20.0,
        ),
      ],
    );
  }
}
