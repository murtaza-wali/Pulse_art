import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ScreensWithData/AttendanceApproval/AttendanceApprovalScreen.dart';
import 'package:art/ScreensWithData/DigitalHR/LMS/Attendance.dart';
import 'package:art/ScreensWithData/Selfservice/Attendance.dart';
import 'package:art/ScreensWithData/Selfservice/LeaveApplication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'Selfservice/AttendanceCorrection.dart';
import 'Selfservice/EmployeePerformance.dart';
import 'EApprovalScreens/NoUse/LeaveRequest.dart';
import 'Selfservice/Management.dart';
import 'Selfservice/OrganoGramScreen.dart';
import 'Selfservice/UnderdevelopmentScreen/underdevelopmentScreen.dart';
import 'Selfservice/UserProfile.dart';
import 'Selfservice/shortRequest.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  GlobalKey _bottomNavigationKey = GlobalKey();
  final userprofile = new UserProfile();
  final attendanceCorrectionscreen = new AttendanceApprovalScreen();
  final attendence = new EmployeeAttendance();
  final management = new Management();
  final organgram = new Organogram();
  final Employee_performance = new EmployeePerformance();
  // final short_request = new UnderdevelopmentPage();
  final leave_request = new LeaveRequest1();
  // final Employee_attendance_correction = new UnderdevelopmentPage();
  final Employee_attendance_correction = new AttendanceCorrection();
  Widget homeShow = AttendanceApprovalScreen();
  // Widget homeShow = AttendanceApprovalScreen();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  //
  // case 0:
  // return attendanceCorrectionscreen;
  // break;
  //
  // case 1:
  // return userprofile;
  // break;
  // case 2:
  // return attendence;//attendence;
  // break;
  // case 3:
  // return organgram;
  // break;
  // case 4:
  // return Employee_performance;
  // break;
  // case 5:
  // return leave_request;
  // break;
  // case 6:
  // return Employee_attendance_correction;
  // break;
  // default:
  // return homeShow;


  Widget _pageChooser(int page) {
    switch (page) {
    case 0:
    return attendanceCorrectionscreen;
    break;

    case 1:
    return userprofile;
    break;
    case 2:
    return attendence;//attendence;
    break;
    case 3:
    return organgram;
    break;
    case 4:
    return Employee_performance;
    break;
    case 5:
    return leave_request;
    break;
    default:
    return homeShow;
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
              FontAwesomeIcons.edit,
              size: 22,
              color: Colors.white,
            ),
            Icon(
              Icons.perm_identity,
              size: 25,
              color: Colors.white,
            ),
            Icon(
              Icons.inventory_outlined,
              size: 25,
              color: Colors.white,
            ),
            FaIcon(
              Icons.account_tree_outlined,
              color: Colors.white,
              size: 25,
            ),
            FaIcon(
              Icons.local_activity_outlined,
              color: Colors.white,
              size: 25,
            ),
            // FaIcon(
            //   FontAwesomeIcons.book,
            //   color: Colors.white,
            //   size: 25,
            // ),
            // FaIcon(
            //   FontAwesomeIcons.book,
            //   color: Colors.white,
            //   size: 25,
            // ),
          ],
          color: ReColors().appMainColor,
          buttonBackgroundColor: ReColors().appMainColor,
          backgroundColor: ReColors().appTextWhiteColor,
          animationCurve: Curves.easeIn,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              homeShow = _pageChooser(index);
              // _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body:
        Container(
          color: Colors.transparent,
          child: Center(
            child: homeShow,
          ),
        ));
  }
}
