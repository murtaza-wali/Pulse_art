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
            color: Colors.white, fontSize: 25.0, fontFamily: 'headingfont'),
        description:
            'Artistic Milliners has accelerated its digitization through new interface was introduced, titled "ART".This PULSE software application redefined the way enterprise users work. With a new visual design and appearance, we are making next-generation workforce and drive employee engagement to ensure maximum utilization of the apps offering by enabling them through technology.',
        styleDescription: TextStyle(
            color: Colors.white, fontSize: 16.0, fontFamily: 'titlefont'),
        marginDescription:
            EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0, bottom: 70.0),
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
            color: Colors.white, fontSize: 25.0, fontFamily: 'headingfont'
        ),
        description:
            "Digital Rocket is a team initiative which is harmonizing business processes with next-generation automation-based technology.",
        styleDescription: TextStyle(
            color: Colors.white, fontSize: 16.0, fontFamily: 'titlefont'
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
        maxLineTitle: 3,        styleTitle: TextStyle(
            color: Colors.white, fontSize: 25.0, fontFamily: 'headingfont'
        ),
        description:
            "Whatever platform you choose for your cloud-enabled business applications, including custom code in just about any framework, we’ve got you covered.",
        styleDescription: TextStyle(
            color: Colors.white, fontSize: 16.0, fontFamily: 'titlefont'
        ),
        backgroundImage: "",
        directionColorBegin: Alignment.topCenter,
        directionColorEnd: Alignment.bottomCenter,
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
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
              colors: [
            Colors.black,
            Color(0xff055e8e),
            Color(0xff055e8e),
            Colors.black
          ])),
      child: IntroSlider(
        slides: this.slides,

        renderSkipBtn: this.renderSkipBtn(),
        skipButtonStyle: myButtonStyle(),

        renderNextBtn: this.renderNextBtn(),
        nextButtonStyle: myButtonStyle(),

        renderDoneBtn: this.renderDoneBtn(),
        onDonePress: this.onDonePress,
        doneButtonStyle: myButtonStyle(),

        colorDot: Colors.white,
        colorActiveDot: Colors.grey,
        sizeDot: 13.0,

        hideStatusBar: true,
        backgroundColorAllSlides: ReColors().appMainColor,

        verticalScrollbarBehavior: scrollbarBehavior.SHOW_ALWAYS,
      ),
    );
  }
}

