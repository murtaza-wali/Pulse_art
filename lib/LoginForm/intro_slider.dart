import 'package:flutter/material.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../main.dart';
import 'Login.dart';

/// This is the main method of app, from here execution starts.
// void main() => runApp(App());

class IntroApp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => IntroAppState();

}
/// App widget class.
class IntroAppState extends State<IntroApp> {
  int initScreen;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  // Making list of pages needed to pass in IntroViewsFlutter constructor.
  final pages = [
    PageViewModel(
      pageBackground: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  // stops: [0.0, 1.0],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  // tileMode: TileMode.repeated,
                  colors: [
                    Colors.black,
                    Color(0xff055e8e),
                    Color(0xff055e8e),
                    Colors.black
                  ]))),
      // iconImageAssetPath: 'assets/air-hostess.png',
      bubble: Image.asset('assets/images/eapprovals.png'),
      body: const Text(
        'E-Approval',
      ),
      title: const Text(
        'E-Approval',
      ),
      titleTextStyle:
          const TextStyle(fontFamily: 'MyFont', color: Colors.white),
      bodyTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white),
      mainImage: Image.asset(
        'assets/images/eapprovals.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
    ),
    PageViewModel(
      pageBackground: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  // stops: [0.0, 1.0],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  // tileMode: TileMode.repeated,
                  colors: [
                    Colors.black,
                    Color(0xff055e8e),
                    Color(0xff055e8e),
                    Colors.black
                  ]))),
      iconImageAssetPath: 'assets/images/denim.png',
      body: const Text(
        'Denim',
      ),
      title: const Text('Denim'),
      mainImage: Image.asset(
        'assets/images/denim.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      titleTextStyle:
          const TextStyle(fontFamily: 'MyFont', color: Colors.white),
      bodyTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
    PageViewModel(
      pageBackground: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  // stops: [0.0, 1.0],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  // tileMode: TileMode.repeated,
                  colors: [
                    Colors.black,
                    Color(0xff055e8e),
                    Color(0xff055e8e),
                    Colors.black
                  ]))),
      iconImageAssetPath: 'assets/images/jarvis.png',
      body: const Text(
        'J.A.R.V.I.S',
      ),
      title: const Text('J.A.R.V.I.S'),
      mainImage: Image.asset(
        'assets/images/jarvis.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      titleTextStyle:
          const TextStyle(fontFamily: 'MyFont', color: Colors.white),
      bodyTextStyle: const TextStyle(fontFamily: 'MyFont', color: Colors.white),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'IntroViews Flutter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Builder(
        builder: (context) => IntroViewsFlutter(
          pages,
          showNextButton: true,
          showBackButton: true,
          onTapSkipButton:() {
            // Use Navigator.push if you want the user to be able to slide across and back to the Intro Views.
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => Login()),
            );
          } ,
          onTapDoneButton: () {
            // Use Navigator.push if you want the user to be able to slide across and back to the Intro Views.
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => Login()),
            );
          },
          pageButtonTextStyles: const TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}

