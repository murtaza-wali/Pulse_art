import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ScreensWithData/LoginScreen/Login.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:intro_slider/scrollbar_behavior_enum.dart';

class IntroApp extends StatefulWidget {
  IntroApp({Key key}) : super(key: key);

  @override
  IntroScreenState createState() => new IntroScreenState();
}

// ------------------ Custom config ------------------
class IntroScreenState extends State<IntroApp> {
  List<Slide> slides = [];

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        pathImage: 'assets/images/pulse_logo.png',
        title: 'A modern UX \nFor every device. \nFor every user.',
        maxLineTitle: 3,
        styleTitle: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        description:
            'Artistic Milliners has accelerated its digitization through new interface was introduced, titled "ART".This PULSE software application redefined the way enterprise users work. With a new visual design and appearance, we are making next-generation workforce and drive employee engagement to ensure maximum utilization of the apps offering by enabling them through technology.',
        styleDescription: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
        ),
        marginDescription:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
        /*centerWidget: Text("Replace this with a custom widget",
            style: TextStyle(color: Colors.white)),*/
        backgroundImage: "",
        directionColorBegin: Alignment.topLeft,
        directionColorEnd: Alignment.bottomRight,
        onCenterItemPress: () {},
      ),
    );
    slides.add(
      new Slide(
        pathImage: 'assets/images/digital_rocket_logo.png',
        title: "Building bridges with the future",
        maxLineTitle: 2,
        styleTitle: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
          /*fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'*/
        ),
        description:
            "Digital Rocket is a team initiative which is harmonizing business processes with next-generation automation-based technology.",
        styleDescription: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          /*fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'*/
        ),
        backgroundImage: "",
        directionColorBegin: Alignment.topRight,
        directionColorEnd: Alignment.bottomLeft,
      ),
    );
    slides.add(
      new Slide(
        pathImage: 'assets/images/Koder_farm_logo.png',
        title: "All the functionality you need on the platform of your choice",
        maxLineTitle: 3,
        styleTitle: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
          /*fontWeight: FontWeight.bold,
            fontFamily: 'RobotoMono'*/
        ),
        description:
            "Whatever platform you choose for your cloud-enabled business applications, including custom code in just about any framework, we’ve got you covered.",
        styleDescription: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          /*fontStyle: FontStyle.italic,
            fontFamily: 'Raleway'*/
        ),
        backgroundImage: "",
        directionColorBegin: Alignment.topCenter,
        directionColorEnd: Alignment.bottomCenter,
        // maxLineTextDescription: 3,
      ),
    );
  }

  void onDonePress() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => Login()),
        (Route<dynamic> route) => false);
  }

  Widget renderNextBtn() {
    return Icon(
      Icons.navigate_next,
      color: Colors.black,
    );
  }

  Widget renderDoneBtn() {
    return Icon(
      Icons.done,
      color: Colors.black,
    );
  }

  Widget renderSkipBtn() {
    return InkWell(
        onTap: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (BuildContext context) => Login()),
              (Route<dynamic> route) => false);
        },
        child: Icon(
          Icons.skip_next,
          color: Colors.black,
        ));
  }

  ButtonStyle myButtonStyle() {
    return ButtonStyle(
      shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
      backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
      overlayColor: MaterialStateProperty.all<Color>(Colors.white),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
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
          ])),
      child: IntroSlider(
        // List slides
        slides: this.slides,

        // Skip button
        renderSkipBtn: this.renderSkipBtn(),
        skipButtonStyle: myButtonStyle(),

        // Next button
        renderNextBtn: this.renderNextBtn(),
        nextButtonStyle: myButtonStyle(),

        // Done button
        renderDoneBtn: this.renderDoneBtn(),
        onDonePress: this.onDonePress,
        doneButtonStyle: myButtonStyle(),

        // Dot indicator
        colorDot: Colors.white,
        colorActiveDot: Colors.grey,
        sizeDot: 13.0,

        // Show or hide status bar
        hideStatusBar: true,
        backgroundColorAllSlides: ReColors().appMainColor,

        // Scrollbar
        verticalScrollbarBehavior: scrollbarBehavior.SHOW_ALWAYS,
      ),
    );
  }
}

/*
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intro_views_flutter/intro_views_flutter.dart';
import '../LoginScreen/Login.dart';

/// This is the main method of app, from here execution starts.
// void main() => runApp(App());

class IntroApp extends StatefulWidget {
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
      iconImageAssetPath: 'assets/images/pulse_logo.png',

      // bubble: Image.asset('assets/images/eapprovals.png'),
      body: Text(
        'Artistic Milliners has accelerated its digitization through new interface was introduced, titled "ART".This PULSE software application redefined the way enterprise users work. With a new visual design and appearance, we are making next-generation workforce and drive employee engagement to ensure maximum utilization of the apps offering by enabling them through technology.',
      ),
      title: Text('A modern UX \nFor every device. \nFor every user.'),
      titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white,fontSize: 20),
      bodyTextStyle:
          TextStyle(fontFamily: 'MyFont', color: Colors.white, fontSize: 18),
      mainImage: Image.asset(
        'assets/images/pulse_logo.png',
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
      iconImageAssetPath: 'assets/images/digital_rocket_logo.png',
      body: Text(
        "Digital Rocket is a team initiative which is harmonizing business processes with next-generation automation-based technology.",
      ),
      title: Text('Building bridges with the future'),
      mainImage: Image.asset(
        'assets/images/digital_rocket_logo.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white,fontSize: 20),
      bodyTextStyle:
          TextStyle(fontFamily: 'MyFont', color: Colors.white, fontSize: 18),
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
      iconImageAssetPath: 'assets/images/Koder_farm_logo.png',
      body: Text(
        "Whatever platform you choose for your cloud-enabled business applications, including custom code in just about any framework, we’ve got you covered.",
      ),
      title:
          Text('All the functionality you need on the platform of your choice'),
      mainImage: Image.asset(
        'assets/images/Koder_farm_logo.png',
        height: 285.0,
        width: 285.0,
        alignment: Alignment.center,
      ),
      titleTextStyle: TextStyle(fontFamily: 'MyFont', color: Colors.white,fontSize: 20),
      bodyTextStyle:
          TextStyle(fontFamily: 'MyFont', color: Colors.white, fontSize: 18),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return Scaffold(
      body: Builder(
        builder: (context) => IntroViewsFlutter(
          pages,
          showNextButton: true,
          showBackButton: true,
          onTapSkipButton: () {
            // Use Navigator.push if you want the user to be able to slide across and back to the Intro Views.
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (BuildContext context) => Login()),
                (Route<dynamic> route) => false);
          },
          onTapDoneButton: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (BuildContext context) => Login()),
                (Route<dynamic> route) => false);
          },
          pageButtonTextStyles: TextStyle(
            color: Colors.white,
            fontSize: 18.0,
          ),
        ),
      ),
    );
  }
}
*/
