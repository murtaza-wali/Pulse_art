import 'package:art/HexCodeConverter/Hexcode.dart';
import 'package:art/ReuseableWidget/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VacationRules extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VacationRulesState();
}

class _VacationRulesState extends State<VacationRules> {
  Color color2 = HexColor("#055e8e");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color2,
      appBar: new ReusableWidgets().getAppBar('Vacation Rules'),
      body: Center(),
    );
  }
}
