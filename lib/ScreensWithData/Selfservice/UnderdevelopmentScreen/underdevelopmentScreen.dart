import 'package:art/ReuseableWidget/CustomAppbarWidget.dart';
import 'package:art/ReuseableWidget/GradientBG.dart';
import 'package:art/ScreensWithData/Menu/MainMenuPopup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UnderdevelopmentPage extends StatefulWidget {
  UnderdevelopmentPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _UnderdevelopmentPageState createState() => _UnderdevelopmentPageState();
}

class _UnderdevelopmentPageState extends State<UnderdevelopmentPage> {
  @override
  Widget build(BuildContext context) {
    /*SystemChrome.setEnabledSystemUIOverlays([]);*/
    return Scaffold(
      appBar: new CustomAppBar(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MainMenuPopUp()),
          );
        },
        Title: 'Self Service',
        refreshonPressed: () {},
      ),
      body: Container(
        color: Colors.white,
        child: Center(
          child: Padding(padding: EdgeInsets.all(30),child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Image.asset('assets/images/underdevelopment.jpg',
                    height: 250, width: 260),
              ),
              Text(
                "Under Development",
                style: TextStyle(
                  // remove this if don't have custom font
                    fontSize: 20.0,
                    // text size
                    color: Colors.red,
                    fontFamily: 'headerfont' // text color
                ),
              )
            ],
          ),),
        ),
      ),
    );
  }
}
