import 'package:art/ReuseableValues/ReColors.dart';
import 'package:flutter/material.dart';

class ReusableWidgets {

  getAppBar(String title) {
    return AppBar(
      title: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/artlogo.png',
            fit: BoxFit.contain,
            height: 20,
          ),
          Container(padding: const EdgeInsets.all(8.0), child: Text(title))
        ],
      ),
      // leading: Image.asset("assets/images/artlogo.png"),
      automaticallyImplyLeading: false, // hides default back button
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [ReColors().appMainColor, Colors.black],
          ),
        ),
      ),
    );
  }
}
