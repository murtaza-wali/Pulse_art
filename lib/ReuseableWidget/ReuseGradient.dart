import 'package:art/HexCodeConverter/Hexcode.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:flutter/material.dart';

class ReuseGradient {
  @override
  getgradient() {
    return BoxDecoration(
      gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Colors.black, ReColors().appMainColor,ReColors().appMainColor, Colors.black]),
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
