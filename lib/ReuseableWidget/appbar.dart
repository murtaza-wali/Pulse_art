import 'package:art/ReuseableValues/ReColors.dart';
import 'package:flutter/material.dart';

class ReusableWidgets {
  getAppBar(context, String title) {
    return AppBar(
      automaticallyImplyLeading: false,
      leading: BackButton(
          color: ReColors().appTextWhiteColor,
      ),
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
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      // leading: Image.asset("assets/images/artlogo.png"),// hides default back button
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

  getLoginAppBar(String title) {
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
      automaticallyImplyLeading: true, // hides default back button
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
