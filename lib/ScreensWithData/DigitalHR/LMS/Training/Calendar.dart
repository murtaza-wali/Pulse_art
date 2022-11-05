import 'dart:convert';

import 'package:art/APIUri/BaseUrl.dart';
import 'package:art/Model/calendar_model.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:http/http.dart' as http;

class TabScreen2 extends StatelessWidget {
  TabScreen2(this.listType);

  final String listType;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: CalendarPage());
  }
}

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  List<LectureTime> _times;
  Future<List<Calendaritems>> _future;
  List<Calendaritems> lectures;
  List<Calendaritems> lectures1;
  DateTime _selectedDate = new DateTime.now();
  CalendarController _controller = CalendarController();

  @override
  void initState() {
    super.initState();
    _selectedDate = new DateTime(
        _selectedDate.year,
        _selectedDate.month,
        15,
        _selectedDate.hour,
        _selectedDate.minute,
        _selectedDate.second,
        _selectedDate.millisecond,
        _selectedDate.microsecond);
    _future = getHRCalendar();
  }

  @override
  Widget build(BuildContext context) {
    return Willpopwidget().getWillScope(Scaffold(
        body: SfCalendar(
      view: CalendarView.month,
      showNavigationArrow: true,
      onTap: (CalendarTapDetails details) {
        DateTime date =
            DateTime(details.date.year, details.date.month, details.date.day);

        for (int i = 0; i < lectures.length; i++) {
          print('DateTime : ${date}');
          print(
              'DateTime124 : ${DateTime(DateTime.parse(lectures[i].trainingDate).year, DateTime.parse(lectures[i].trainingDate).month, DateTime.parse(lectures[i].trainingDate).day)}');
          print(
              'DateTime234 : ${DateTime(DateTime.parse(lectures[i].trainingDate).year, DateTime.parse(lectures[i].trainingDate).month, DateTime.parse(lectures[i].trainingDate).day) == date}');
          if (DateTime(
                  DateTime.parse(lectures[i].trainingDate).year,
                  DateTime.parse(lectures[i].trainingDate).month,
                  DateTime.parse(lectures[i].trainingDate).day) ==
              date) {
            print('datatitle ${lectures[i].trainingTitle}');
            print('datadtate ${lectures[i].trainingDate}');
            print('dataloca ${lectures[i].locationId}');
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text('Training Details',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'headerfont',
                            fontSize: 18.0,
                            color: ReColors().appMainColor)),
                    content: SingleChildScrollView(
                      child: Container(
                        child: Center(
                          child: Column(
                            children: <Widget>[
                              Center(
                                child: Text('${lectures[i].trainingTitle}',
                                    maxLines: 3,
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        fontFamily: 'headerfont',
                                        fontSize: 17.0,
                                        color: ReColors().appMainColor)),
                              ),
                              Divider(
                                height: 1,
                                thickness: 1,
                                color: Colors.grey,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Training Date: ',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: 'headingfont',
                                            fontSize: 15.0,
                                            color: ReColors().appMainColor)),
                                    Text(
                                        '${DateTime(DateTime.parse(lectures[i].trainingDate).year, DateTime.parse(lectures[i].trainingDate).month, DateTime.parse(lectures[i].trainingDate).day)}'
                                            .replaceAll('00:00:00.000', ''),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            fontFamily: 'headingfont',
                                            fontSize: 15.0,
                                            color: ReColors().appMainColor)),
                                  ]),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Training Duration: ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontFamily: 'headingfont',
                                          fontSize: 15.0,
                                          color: ReColors().appMainColor)),
                                  Text('${lectures[i].trainingDuration}',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontFamily: 'headingfont',
                                          fontSize: 15.0,
                                          color: ReColors().appMainColor)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Location: ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontFamily: 'headingfont',
                                          fontSize: 15.0,
                                          color: ReColors().appMainColor)),
                                  Text('${lectures[i].companycode}',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontFamily: 'headingfont',
                                          fontSize: 15.0,
                                          color: ReColors().appMainColor)),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Participants: ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontFamily: 'headingfont',
                                          fontSize: 15.0,
                                          color: ReColors().appMainColor)),
                                  Text('${lectures[i].trainingParticipants}',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          fontFamily: 'headingfont',
                                          fontSize: 15.0,
                                          color: ReColors().appMainColor))
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    actions: <Widget>[
                      new TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: new Text('close',
                              style: TextStyle(
                                  fontFamily: 'headingfont',
                                  fontSize: 18.0,
                                  color: ReColors().appMainColor)))
                    ],
                  );
                });
          }
        }
        print('len kdksjkfj');
      },
      cellBorderColor: Colors.black,
          headerStyle: CalendarHeaderStyle(
          textStyle: TextStyle(color: ReColors().appMainColor, fontSize: 20),
          textAlign: TextAlign.center,
          backgroundColor: Colors.white),
      viewHeaderStyle: ViewHeaderStyle(
          backgroundColor: Colors.white,
          dayTextStyle: TextStyle(color: Colors.black, fontSize: 20),
          dateTextStyle: TextStyle(color: Colors.black, fontSize: 25)),
      onViewChanged: (ViewChangedDetails details) {
        if (_selectedDate.month != details.visibleDates[15].month) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _selectedDate = details.visibleDates[15];
            setState(() {
              getHRCalendar();
            });
          });
        }
      },
      dataSource: LectureTimeDataSource(_times),
      monthViewSettings: const MonthViewSettings(
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
    )));
  }

  void _getDataSource(List<Calendaritems> lectures) {
    var lectureTimes = <LectureTime>[];
    lectures.forEach((element) {
      lectureTimes.add(LectureTime(
          (element.trainingTitle),
          DateTime.parse(element.trainingDate),
          DateTime.parse(element.trainingDate),
          Colors.green,
          false));
    });

    setState(() {
      _times = lectureTimes;
    });
  }

  Future<List<Calendaritems>> getHRCalendar() async {
    var loginURL = Uri.parse(BaseURL().Auth + 'dhr/calendar');
    print('HR Calndar url: ${loginURL}');
    final result = await http.get(loginURL);
    var parse = json.decode(result.body);
    var data = parse['items'] as List;
    if (lectures != null) lectures.clear();

    try {
      lectures =
          List<Calendaritems>.from(data.map((x) => Calendaritems.fromJson(x)));
      _getDataSource(lectures);
    } catch (e) {
      print(e.toString());
    }

    return Future.value(lectures);
  }

}

class LectureTimeDataSource extends CalendarDataSource {
  LectureTimeDataSource(List<LectureTime> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }

}

class LectureTime {
  LectureTime(
      this.eventName, this.from, this.to, this.background, this.isAllDay);

  String eventName;

  DateTime from;

  DateTime to;

  Color background;

  bool isAllDay;
}
