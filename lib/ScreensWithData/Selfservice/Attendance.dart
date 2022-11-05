import 'dart:io';

import 'package:art/Error/Error.dart';
import 'package:art/HexCodeConverter/Hexcode.dart';
import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/Model/AttendenceModel.dart';
import 'package:art/Model/attendencetotal.dart';
import 'package:art/Model/e_s_s_model.dart';
import 'package:art/ParsingJSON/GetJSONMethod.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/CustomAppbarWidget.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:art/ScreensWithData/Menu/MainMenuPopup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class EmployeeAttendance extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmployeeAttendance();
}

List<DateTime> presentDates = [];
List<DateTime> absentDates = [];
List<DateTime> OFFDates = [];
List<DateTime> HalfdayDates = [];
List<DateTime> leavesDate = [];
List<DateTime> SHDates = [];
List<DateTime> GHDates = [];

class _EmployeeAttendance extends State<EmployeeAttendance> {
  List<AttendenceTotalitem> attendenceTotalList = [];
  List<Attendenceitem> attendenceItems = [];
  List<Attendenceitem> attendence_selected_date_list = [];
  List<Essitems> profilelist;
  String employeeCode;
  static String noEventText = "No event here";
  String calendarText = noEventText;
  bool container_visibility = false;

  @override
  void initState() {
    super.initState();
    addMarkedEvent();
  }

  Color color2 = HexColor("#055e8e");

  addMarkedEvent() {
    MySharedPreferences.instance
        .getIntValue("UserId")
        .then((value) => setState(() {
              getID = value;
              GetJSON().getProfileData(context,getID).then((users) {
                if (this.mounted) {
                  setState(() {
                    profilelist = users;

                    employeeCode = profilelist[0].employeecode;
                    print('employee code : ${employeeCode}');
                    GetJSON().getTotalattendence(employeeCode).then((users) {
                      setState(() {
                        attendenceTotalList = users;
                      });
                    });
                    GetJSON().getattendenceData(employeeCode).then((users) {
                      setState(() {
                        attendenceItems = users;
                        for (int i = 0; i < attendenceItems.length; i++) {
                          if (attendenceItems[i].status == 'P') {
                            presentDates.add(DateTime(
                                attendenceItems[i].attendanceDate.year,
                                attendenceItems[i].attendanceDate.month,
                                attendenceItems[i].attendanceDate.day));
                          }
                          if (attendenceItems[i].status == 'A') {
                            absentDates.add(DateTime(
                                attendenceItems[i].attendanceDate.year,
                                attendenceItems[i].attendanceDate.month,
                                attendenceItems[i].attendanceDate.day));
                          }
                          if (attendenceItems[i].status == 'O') {
                            OFFDates.add(DateTime(
                                attendenceItems[i].attendanceDate.year,
                                attendenceItems[i].attendanceDate.month,
                                attendenceItems[i].attendanceDate.day));
                          }
                          if (attendenceItems[i].status == 'X') {
                            HalfdayDates.add(DateTime(
                                attendenceItems[i].attendanceDate.year,
                                attendenceItems[i].attendanceDate.month,
                                attendenceItems[i].attendanceDate.day));
                          }
                          if (attendenceItems[i].status == 'S') {
                            SHDates.add(DateTime(
                                attendenceItems[i].attendanceDate.year,
                                attendenceItems[i].attendanceDate.month,
                                attendenceItems[i].attendanceDate.day));
                          }
                          if (attendenceItems[i].status == 'G') {
                            GHDates.add(DateTime(
                                attendenceItems[i].attendanceDate.year,
                                attendenceItems[i].attendanceDate.month,
                                attendenceItems[i].attendanceDate.day));
                          }
                          if (attendenceItems[i].status == 'C/L' ||
                              attendenceItems[i].status == 'C/L(X)' ||
                              attendenceItems[i].status == 'S/L') {
                            leavesDate.add(DateTime(
                                attendenceItems[i].attendanceDate.year,
                                attendenceItems[i].attendanceDate.month,
                                attendenceItems[i].attendanceDate.day));
                          }
                        }
                      });
                    });
                  });
                }
              });
            }));
  }

  bool containervisible = false;

  static Widget _leavesDateIcon(String day) {
    return Container(
      width: 100,
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.white,
        child: Text(
          day,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        border: new Border.all(
          color: Colors.orange,
          width: 2.0,
        ),
      ),
    );
  }

  static Widget _presentIcon(String day) {
    return Container(
      width: 100,
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.white,
        child: Text(
          day,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        border: new Border.all(
          color: ReColors().presentColor,
          width: 2.0,
        ),
      ),
    );
  }

  static Widget _lateIcon(String day) {
    return Container(
      width: 100,
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.transparent,
        child: Text(
          day,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          colors: [ReColors().lateFirstColor, ReColors().latesecondColor],
        ),
      ),
    );
  }

  static Widget _gazatted_holiday_Icon(String day) {
    return Container(
      width: 100,
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.transparent,
        child: Text(
          day,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [ReColors().ghFirstColor, ReColors().ghsecondColor],
        ),
      ),
    );
  }

  static Widget _half_short_Icon(String day) {
    return Container(
      width: 100,
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.transparent,
        child: Text(
          day,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          colors: [ReColors().hslFirstColor, ReColors().hslsecondColor],
        ),
      ),
    );
  }

  static Widget _oFFIcon(String day) {
    return Container(
      width: 100,
      child: CircleAvatar(
        radius: 50,
        backgroundColor: Colors.transparent,
        child: Text(
          day,
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      decoration: new BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.topRight,
          colors: [ReColors().offFirstColor, ReColors().offsecondColor],
        ),
      ),
    );
  }

  static Widget _absentIcon(String day) => CircleAvatar(
        backgroundColor: ReColors().absentColor,
        child: Text(
          day,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      );

  EventList<Event> _markedDateMap = new EventList<Event>(
    events: {},
  );

  CalendarCarousel _calendarCarouselNoHeader;
  DateTime _targetDateTime = new DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(new DateTime.now());

  double cHeight;

  @override
  Widget build(BuildContext context) {
    cHeight = MediaQuery.of(context).size.height;
    for (int i = 0; i < presentDates.length; i++) {
      _markedDateMap.add(
        presentDates[i],
        Event(
          date: presentDates[i],
          title: 'Event 5',
          icon: _presentIcon(
            presentDates[i].day.toString(),
          ),
        ),
      );
    }
    for (int i = 0; i < OFFDates.length; i++) {
      _markedDateMap.add(
        OFFDates[i],
        new Event(
          date: OFFDates[i],
          title: 'Event 5',
          icon: _oFFIcon(
            OFFDates[i].day.toString(),
          ),
        ),
      );
    }
    for (int i = 0; i < HalfdayDates.length; i++) {
      _markedDateMap.add(
        HalfdayDates[i],
        new Event(
          date: HalfdayDates[i],
          title: 'Event 5',
          icon: _half_short_Icon(
            HalfdayDates[i].day.toString(),
          ),
        ),
      );
    }
    for (int i = 0; i < SHDates.length; i++) {
      _markedDateMap.add(
        SHDates[i],
        new Event(
          date: SHDates[i],
          title: 'Event 5',
          icon: _half_short_Icon(
            SHDates[i].day.toString(),
          ),
        ),
      );
    }
    for (int i = 0; i < GHDates.length; i++) {
      _markedDateMap.add(
        GHDates[i],
        new Event(
          date: GHDates[i],
          title: 'Event 5',
          icon: _gazatted_holiday_Icon(
            GHDates[i].day.toString(),
          ),
        ),
      );
    }
    for (int i = 0; i < leavesDate.length; i++) {
      _markedDateMap.add(
        leavesDate[i],
        new Event(
          date: leavesDate[i],
          title: 'Event 5',
          icon: _leavesDateIcon(
            leavesDate[i].day.toString(),
          ),
        ),
      );
    }
    for (int i = 0; i < absentDates.length; i++) {
      _markedDateMap.add(
        absentDates[i],
        new Event(
          date: absentDates[i],
          title: '',
          icon: _absentIcon(
            absentDates[i].day.toString(),
          ),
        ),
      );
    }
    _calendarCarouselNoHeader = CalendarCarousel<Event>(
      height: cHeight * 0.38,
      showOnlyCurrentMonthDate: true,
      markedDatesMap: _markedDateMap,
      markedDateShowIcon: true,
      markedDateIconMaxShown: 1,
      markedDateMoreShowTotal: null,
      pageSnapping: false,
      pageScrollPhysics: NeverScrollableScrollPhysics(),
      targetDateTime: _targetDateTime,
      showHeader: false,
      daysTextStyle: TextStyle(
        color: Colors.black,
      ),

      onDayPressed: (DateTime date, List<Event> events) {
        this.setState(() {
          for (Attendenceitem event in attendenceItems) {
            String attendence_date =
                '${event.attendanceDate.day}-${event.attendanceDate.month}-${event.attendanceDate.year}';
            String selected_date = '${date.day}-${date.month}-${date.year}';
            if (selected_date == attendence_date) {
              if (event.timeIn == null || event.timeOut == null) {
                container_visibility = false;
                if (event.status == 'A') {
                  confirmationnodetails(context, 'Absent', 'No data to display',
                      "OK", ReColors().absentColor);
                } else if (event.status == 'G') {
                  confirmationnodetails(context, 'Gazetted Holiday',
                      'No data to display', "OK", ReColors().absentColor);
                } else if (event.status == 'O') {
                  confirmationnodetails(context, 'Off', 'No data to display',
                      "OK", ReColors().absentColor);
                }
              } else {
                attendence_selected_date_list.clear();
                container_visibility = true;
                attendence_selected_date_list.add(event);
                confirmationPopup(context, 'Attendance Details', "OK");
              }
            }
          }
        });
      },
      todayTextStyle: TextStyle(
        color: Colors.white,
      ),
      todayButtonColor: Colors.white24,
      todayBorderColor: null,

      selectedDayTextStyle: TextStyle(
        color: Colors.white,
      ),
      selectedDayButtonColor: Colors.white,
      prevDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.white38,
      ),
      nextDaysTextStyle: TextStyle(
        fontSize: 16,
        color: Colors.white38,
      ),
      inactiveDaysTextStyle: TextStyle(
        color: Colors.white38,
        fontSize: 16,
      ),
      markedDateIconBuilder: (event) {
        return event.icon;
      },
    );
    return Willpopwidget().getWillScope(
      Scaffold(
        appBar: new CustomAppBar(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => MainMenuPopUp()),
            );
          },
          Title: 'Attendance',
        ),
        backgroundColor: Colors.white,
        body: FutureBuilder<List<Attendenceitem>>(
          future: GetJSON().getattendenceData(employeeCode),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.hasData &&
                snapshot.data != null) {
              attendenceItems = snapshot.data;
              return snapshot.hasData && _markedDateMap.events.length > 0
                  ? SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              _currentMonth,
                              style: TextStyle(
                                fontFamily: 'headerfont',
                                fontSize: 24.0,
                                color: ReColors().appMainColor,
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Card(
                                      child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment(-0.6, -1),
                                        end: Alignment(-1, -0),
                                        colors: [
                                          Colors.black12,
                                          Colors.black12
                                        ],
                                      ),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(17.0),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          child: Center(
                                              child: Text(
                                            "Total Present",
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'headerfont',
                                                color: ReColors().appMainColor),
                                          )),
                                        ),
                                        Text(
                                          '${attendenceTotalList?.length == 0 ? 'Loading...' : attendenceTotalList[0].presents}',
                                          style: TextStyle(
                                            color: ReColors().appMainColor,
                                            fontSize: 14.0,
                                            fontFamily: 'headingfont',
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(17.0),
                                  ),
                                  elevation: 0,
                                  margin: EdgeInsets.all(10),
                                )),
                                Expanded(
                                    child: Card(

                                      child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment(-0.6, -1),
                                        end: Alignment(-1, -0),
                                        colors: [
                                          Colors.black12,
                                          Colors.black12
                                        ],
                                      ),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(17.0),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          child: Center(
                                              child: Text(
                                            "Total Absent",
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'headerfont',
                                                color: ReColors().appMainColor),
                                          )),
                                        ),
                                        Text(
                                          '${attendenceTotalList?.length == 0 ? 'Loading...' : attendenceTotalList[0].absents}',
                                          style: TextStyle(
                                            color: ReColors().appMainColor,
                                            fontSize: 14.0,
                                            fontFamily: 'headingfont',
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(17.0),
                                  ),
                                  elevation: 5,
                                  margin: EdgeInsets.all(10),
                                )),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                    child: Card(

                                      child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment(-0.6, -1),
                                        end: Alignment(-1, -0),
                                        colors: [
                                          Colors.black12,
                                          Colors.black12
                                        ],
                                      ),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(17.0),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          child: Center(
                                              child: Text(
                                            "Total Short leaves",
                                            textAlign: TextAlign.center,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            style: TextStyle(
                                                fontFamily: 'headerfont',
                                                color: ReColors().appMainColor),
                                          )),
                                        ),
                                        Text(
                                          '${attendenceTotalList?.length == 0 ? 'Loading...' : attendenceTotalList[0].halfDays}',
                                          style: TextStyle(
                                            color: ReColors().appMainColor,
                                            fontSize: 14.0,
                                            fontFamily: 'headingfont',
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(17.0),
                                  ),
                                  elevation: 5,
                                  margin: EdgeInsets.all(10),
                                )),
                                Expanded(
                                    child: Card(

                                      child: Container(
                                    padding: EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        begin: Alignment(-0.6, -1),
                                        end: Alignment(-1, -0),
                                        colors: [
                                          Colors.black12,
                                          Colors.black12
                                        ],
                                      ),
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(17.0),
                                    ),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          child: Center(
                                              child: Text(
                                            "Total Lates",
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                fontFamily: 'headerfont',
                                                color: ReColors().appMainColor),
                                          )),
                                        ),
                                        Text(
                                          '${attendenceTotalList?.length == 0 ? 'Loading...' : attendenceTotalList[0].lates}',
                                          style: TextStyle(
                                            color: ReColors().appMainColor,
                                            fontSize: 14.0,
                                            fontFamily: 'headingfont',
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    ),
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(17.0),
                                  ),
                                  elevation: 5,
                                  margin: EdgeInsets.all(10),
                                )),
                              ],
                            ),
                            _calendarCarouselNoHeader,
                            Column(
                              children: [
                                Row(
                                  children: [
                                    markerRepresent(
                                        ReColors().presentColor, "Present"),
                                    markerRepresent(
                                        ReColors().shortleave_halfday,
                                        "Short Leave"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    markerRepresent(Colors.orange,
                                        "Casual Leaves & Sick leaves"),
                                    markerRepresent(Colors.grey, "Off"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    markerRepresent(ReColors().ghFirstColor,
                                        "Gazetted Holiday"),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    )
                  : Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              if (snapshot.error is HttpException) {
                return showError(
                    'An http error occurred. Page not found. Please try again.',
                    Icons.error);
              }
              if (snapshot.error is NoInternetException) {
                return showError('Please check your internet connection',
                    Icons.signal_wifi_connected_no_internet_4_sharp);
              }
              if (snapshot.error is NoServiceFoundException) {
                return showError('Server Error.', Icons.error);
              }
              if (snapshot.error is InvalidFormatException) {
                return showError(
                    'There is a problem with your request.', Icons.error);
              }
              if (snapshot.error is SocketException) {
                SocketException socketException =
                    snapshot.error as SocketException;
                return showError('Please check your internet connection',
                    Icons.signal_wifi_connected_no_internet_4_sharp);
              } else {
                return showError('An Unknown error occurred.', Icons.error);
              }
            }
            return Center(
                child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(ReColors().appMainColor),
            ));
          },
        ),
      ),
    );
  }

  Widget markerRepresent(Color color, String data) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: new Row(
        children: [
          CircleAvatar(
            backgroundColor: color,
            radius: cHeight * 0.012,
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: new Text(
              data,
              style: TextStyle(
                fontSize: 12,
                fontFamily: 'headingfont',
              ),
            ),
          ),
        ],
      ),
    );
  }

  confirmationnodetails(BuildContext dialogContext, String title, String msg,
      String okbtn, Color color) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      overlayColor: Colors.black87,
      isCloseButton: true,
      isOverlayTapDismiss: true,
      titleStyle: TextStyle(
          color: color,
          fontWeight: FontWeight.bold,
          fontSize: 18,
          fontFamily: 'titlefont'),
      descStyle: TextStyle(
          fontWeight: FontWeight.w500, fontSize: 16, fontFamily: 'titlefont'),
      animationDuration: Duration(milliseconds: 400),
    );

    Alert(
        context: dialogContext,
        style: alertStyle,
        title: title,
        desc: msg,
        buttons: [
          DialogButton(
            child: Text(
              okbtn,
              style: TextStyle(
                  color: Colors.white, fontSize: 18, fontFamily: 'titlefont'),
            ),
            onPressed: () {
              Navigator.of(dialogContext).pop(null);
            },
            color: ReColors().appMainColor,
          ),
        ]).show();
  }

  confirmationPopup(BuildContext dialogContext, String title, String okbtn) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      overlayColor: Colors.black87,
      isCloseButton: true,
      isOverlayTapDismiss: true,
      titleStyle: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 18, fontFamily: 'titlefont'),
      descStyle: TextStyle(
          fontWeight: FontWeight.w500, fontSize: 16, fontFamily: 'titlefont'),
      animationDuration: Duration(milliseconds: 400),
    );

    Alert(
        context: dialogContext,
        style: alertStyle,
        title: title,
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  child: Center(
                      child: Text(
                    'Attendence Date: ${attendence_selected_date_list?.length > 0 ? '${attendence_selected_date_list[0].attendanceDate.day}-${attendence_selected_date_list[0].attendanceDate.month}-${attendence_selected_date_list[0].attendanceDate.year}' : ''}',
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 14.0,
                        fontFamily: 'headingfont',
                        color: ReColors().appMainColor),
                  )),
                ),
                Text(
                  'Time In: ${attendence_selected_date_list?.length > 0 ? '${attendence_selected_date_list[0].timeIn}' : ''}',
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 14.0,
                      fontFamily: 'headingfont',
                      color: ReColors().appMainColor),
                ),
                Text(
                  'Time Out: ${attendence_selected_date_list?.length > 0 ? '${attendence_selected_date_list[0].timeOut}' : ''}',
                  style: TextStyle(
                    color: ReColors().appMainColor,
                    fontSize: 14.0,
                    fontFamily: 'headingfont',
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            )
          ],
        ),
        buttons: [
          DialogButton(
            child: Text(
              okbtn,
              style: TextStyle(
                  color: Colors.white, fontSize: 18, fontFamily: 'titlefont'),
            ),
            onPressed: () {
              Navigator.of(dialogContext).pop(null);
            },
            color: ReColors().appMainColor,
          ),
        ]).show();
  }

  Widget showError(String message, key) {
    return GestureDetector(
      onTap: () {
        setState(() {});
      },
      child: Center(
        child: Container(
          alignment: FractionalOffset(0.5, 0.5),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Icon(
                        key,
                        size: 70,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      message,
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

