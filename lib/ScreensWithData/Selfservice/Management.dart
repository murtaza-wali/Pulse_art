import 'package:art/ReuseableWidget/CustomAppbarWidget.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:art/ScreensWithData/Menu/MainMenuPopup.dart';
import 'package:flutter/material.dart';

class Management extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ManagementState();
}

class _ManagementState extends State<Management> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Willpopwidget().getWillScope(
      Scaffold(
        appBar: new CustomAppBar(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => MainMenuPopUp()),
            );
          },
          Title: 'Management',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(5),

          ),
        ),
      ),
    );
  }
}

