import 'package:art/ReuseableValues/ReColors.dart';
import 'package:flutter/material.dart';

class Gradientbg {
  getbg() {
    return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
          Colors.black,
          ReColors().appMainColor,
          ReColors().appMainColor,
          Colors.black
        ]));
  }

  getMenubg() {
    return BoxDecoration(
        gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomLeft,
            colors: [
          ReColors().menubgdarkgreyColor,
          ReColors().menubgdarkgreyColor,
          ReColors().menubglightgreyColor,
        ]));
  }
}
