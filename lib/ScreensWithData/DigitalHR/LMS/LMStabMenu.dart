import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ScreensWithData/Menu/MainMenuPopup.dart';
import 'package:flutter/material.dart';

import 'Attendance.dart';
import 'LMSDashboard.dart';
import 'Training/Calendar.dart';

class LMSHomeScreen extends StatefulWidget {
  const LMSHomeScreen();

  @override
  _LMSHomeScreenState createState() => new _LMSHomeScreenState();
}

class _LMSHomeScreenState extends State<LMSHomeScreen>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      new GlobalKey<ScaffoldState>();

  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      key: scaffoldKey,
      appBar: new AppBar(
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
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/hrms_logo2.png',
              fit: BoxFit.contain,
              height: 40,
            ),
            Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'HR Digital',
                  style: TextStyle(fontFamily: 'headerfont', fontSize: 16),
                ))
          ],
        ),
        automaticallyImplyLeading: false,
        leading: BackButton(
          color: ReColors().appTextWhiteColor,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => MainMenuPopUp()),
            );
          },
        ),
        bottom: new TabBar(
          controller: _controller,
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Color(0xFFFFFFFF),
          tabs: const <Tab>[
            const Tab(text: 'Attendance'),
            const Tab(text: 'Calendar'),
            const Tab(text: 'Dashboard'),
          ],
        ),
      ),
      body: new TabBarView(
        controller: _controller,
        children: <Widget>[
          new TabScreen("Attendance"),
          new TabScreen2("Calendar"),
          new TabScreen3("Dashboard"),
        ],
      ),
    );
  }
}
