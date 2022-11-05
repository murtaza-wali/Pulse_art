import 'package:art/ReuseableValues/ReColors.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'LMS/Attendance.dart';
import 'LMS/LMStabMenu.dart';
import 'LMS/Training/Calendar.dart';
import 'PMS/ProjectManagement.dart';

class HRBottomNavBar extends StatefulWidget {
  @override
  _HRBottomNavBarState createState() => _HRBottomNavBarState();
}

class _HRBottomNavBarState extends State<HRBottomNavBar> {
  GlobalKey _bottomNavigationKey = GlobalKey();

  final pms = new ProjectManagement();
  final lms = new LMSHomeScreen();
  Widget homeShow = LMSHomeScreen();

  @override
  void initState() {
    super.initState();
  }

  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return lms;
        break;
      case 1:
        return pms;
        break;
      default:
        return lms;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 50.0,
          items: <Widget>[
            FaIcon(
              FontAwesomeIcons.bookOpen,
              color: Colors.white,
              size: 25,
            ),
            Icon(
              Icons.people_alt_outlined,
              size: 25,
              color: Colors.white,
            ),
          ],
          color: ReColors().appMainColor,
          buttonBackgroundColor: ReColors().appMainColor,
          backgroundColor: ReColors().appTextWhiteColor,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              homeShow = _pageChooser(index);
            });
          },
          letIndexChange: (index) => true,
        ),
        body: Container(
          color: Colors.transparent,
          child: Center(
            child: homeShow,
          ),
        ));
  }
}
