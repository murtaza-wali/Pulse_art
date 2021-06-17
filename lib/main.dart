import 'dart:async';
import 'dart:io';
import 'package:art/LocalStorage/DatabaseHandler.dart';
import 'package:art/ScreensWithData/IntroScreen/intro_slider.dart';
import 'package:art/ReuseableWidget/GradientBG.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LocalStorage/MySharedPref.dart';
import 'Model/LoginUser.dart';
import 'ScreensWithData/LoginScreen/Login.dart';
import 'ScreensWithData/Menu/MainMenuPopup.dart';

int initScreen;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

Future<void> main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  print('initScreen ${initScreen}');
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
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool remember;
  user userLogin;

  @override
  void initState() {
    super.initState();
    MySharedPreferences.instance
        .getBoolValue("remember")
        .then((name) => setState(() {
              remember = name;
              print(remember);

              if (remember == true) {
                print(remember);
                new Future.delayed(const Duration(seconds: 3), () {
                  //
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MainMenuPopUp()),
                      (Route<dynamic> route) => false);
                });
              }
              else if (remember == false) {
                print('USER NAME 1 : ${name}');
                if (initScreen == null) {
                  new Future.delayed(const Duration(seconds: 3), () {
                    //
                    // Navigator.pop(context,true);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => IntroApp()),
                        (Route<dynamic> route) => false);
                  });
                }
                else if (initScreen == 1) {
                  new Future.delayed(const Duration(seconds: 3), () {
                    //
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Login()),
                        (Route<dynamic> route) => false);
                  });
                }
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: Container(
        decoration: Gradientbg().getbg(),
        child: Center(
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
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
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
                        ),
                        Text(
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
      ),
    );
  }
}
