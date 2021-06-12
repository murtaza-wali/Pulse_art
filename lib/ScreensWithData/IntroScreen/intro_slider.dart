import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import '../LoginScreen/Login.dart';

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
  // Making list of pages needed to pass in IntroViewsFlutter ructor.
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
      body:  Text('Artistic Milliners has accelerated its digitization through new interface was introduced, titled "ART".This PULSE software application redefined the way enterprise users work. With a new visual design and appearance, we are making next-generation workforce and drive employee engagement to ensure maximum utilization of the apps offering by enabling them through technology.',
      ),
      title:  Text('PULSE'
      ),
      titleTextStyle:
           TextStyle(fontFamily: 'MyFont', color: Colors.white),
      bodyTextStyle:  TextStyle(fontFamily: 'MyFont', color: Colors.white,fontSize: 18),
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
      body:  Text(
        "Digital Rocket is a team initiative which is harmonizing business processes with next-generation automation-based technology.",
      ),
      title:  Text('Digital Rocket'),
      mainImage: Image.asset(
        'assets/images/denim.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      titleTextStyle:
           TextStyle(fontFamily: 'MyFont', color: Colors.white),
      bodyTextStyle:  TextStyle(fontFamily: 'MyFont', color: Colors.white,fontSize: 18),
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
      body:  Text(
        "     Whatever platform you choose for your cloud-enabled business applications, including custom code in just about any framework, we’ve got you covered.",
      ),
      title:  Text('KODERS FARM'),
      mainImage: Image.asset(
        'assets/images/jarvis.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      titleTextStyle:
           TextStyle(fontFamily: 'MyFont', color: Colors.white),
      bodyTextStyle:  TextStyle(fontFamily: 'MyFont', color: Colors.white,fontSize: 18),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body:  Builder(
        builder: (context) => IntroViewsFlutter(
          pages,
          showNextButton: true,
          showBackButton: true,
          onTapSkipButton:() {
            // Use Navigator.push if you want the user to be able to slide across and back to the Intro Views.
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (BuildContext context) => Login()),
                    (Route<dynamic> route) => false
            );
          } ,
          onTapDoneButton: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (BuildContext context) => Login()),
                    (Route<dynamic> route) => false
            );
          },
          pageButtonTextStyles:  TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}

