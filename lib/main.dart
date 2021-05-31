import 'dart:async';

import 'package:art/ReuseableValues/ReColors.dart';
import 'package:flutter/material.dart';

import 'LoginForm/Login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Splash'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => Login())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ReColors().appMainColor,
      body: Center(
        child: Column(
          children: <Widget>[
            Expanded(
              child: Center(
                child: Image.asset('assets/images/artlogo.png',
                    height: 250, width: 260),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(
                    children: [
                      Text(
                        "Powered by Artistic Milliners",
                        style: TextStyle(
                          // remove this if don't have custom font
                          fontSize: 10.0,
                          // text size
                          color: Colors.white, // text color
                        ),
                      ),Text(
                        "Copyright © 2021 All Rights Reserved",
                        style: TextStyle(
                          // remove this if don't have custom font
                          fontSize: 10.0,
                          // text size
                          color: Colors.white, // text color
                        ),

                      )
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
