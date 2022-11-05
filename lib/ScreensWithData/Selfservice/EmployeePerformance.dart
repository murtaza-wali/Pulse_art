import 'dart:convert';

import 'package:art/APIUri/BaseUrl.dart';
import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/ParsingJSON/GetJSONMethod.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/CustomAppbarWidget.dart';
import 'package:art/ScreensWithData/Menu/MainMenuPopup.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_html/flutter_html.dart';

class EmployeePerformance extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EmployeePerformanceState();
}

class _EmployeePerformanceState extends State<EmployeePerformance> {
  String EMPLOYEEcODE;
  String saveData;
  double head_count, worked_hours, absenteeism, early_count, late_count;

  @override
  void initState() {
    super.initState();
    MySharedPreferences.instance.getStringValue("employeecode").then((value) {
      if (mounted == true) {
        setState(() {
          EMPLOYEEcODE = value;
          print('Employee: ${EMPLOYEEcODE}');
          GetJSON().getAttendancePerfomance(EMPLOYEEcODE, 1).then((value) {
            Map<String, dynamic> device = jsonDecode(value.body);
            head_count = device['type_counts'];
            print('head_count: ${head_count}');
          });
          GetJSON().getAttendancePerfomance(EMPLOYEEcODE, 2).then((value) {
            Map<String, dynamic> device = jsonDecode(value.body);
            worked_hours = device['type_counts'];
            print('worked_hours: ${worked_hours}');
          });
          GetJSON().getAttendancePerfomance(EMPLOYEEcODE, 3).then((value) {
            Map<String, dynamic> device = jsonDecode(value.body);
            absenteeism = device['type_counts'];
            print('absenteeism: ${absenteeism}');
          });
          GetJSON().getAttendancePerfomance(EMPLOYEEcODE, 4).then((value) {
            Map<String, dynamic> device = jsonDecode(value.body);
            early_count = device['early_count'];
            late_count = device['late_count'];
            print('early_count: ${early_count}');
            print('late_count: ${late_count}');
          });
        });
      }
    });
  }

  Future<String> fetchHTML(String url) async {
    print('employee performance ${url}');
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200)
      return response.body;
    else
      throw Exception('Failed');
  }

  String _temp;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new CustomAppBar(
        onPressed: () {
          Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) => MainMenuPopUp()),
          );
        },
        Title: 'Performance',
      ),
      body: new Center(
          child: FutureBuilder<String>(
        future: fetchHTML(BaseURL().Auth +
            'getEmpPerformance' +
            '/' +
            EMPLOYEEcODE.toString()),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _temp = snapshot.data;
            debugPrint(_temp);
            return Column(
              children: [
                Performance_Dashboard(),
                Expanded(
                    child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Html(data: '$_temp', style: {
                    "table": Style(
                      backgroundColor: Color.fromARGB(0x50, 0xee, 0xee, 0xee),
                    ),
                    "tr": Style(
                      border: Border(bottom: BorderSide(color: Colors.grey)),
                    ),
                    "th": Style(
                      padding: EdgeInsets.all(6),
                      backgroundColor: Colors.grey,
                    ),
                    "td": Style(
                      padding: EdgeInsets.all(6),
                      alignment: Alignment.topLeft,
                    ),
                    'h5':
                        Style(maxLines: 2, textOverflow: TextOverflow.ellipsis),
                  }, customRender: {
                    "table": (context, child) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: (context.tree as TableLayoutElement)
                            .toWidget(context),
                      );
                    }
                  }),
                )),
              ],
            );
          } else if (snapshot.hasError) return Text('ERROR');
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      )),
    );
  }

  Widget Performance_Dashboard() {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Card(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 3, color: Colors.black)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Center(
                          child: Text(
                        "Head Count",
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'headerfont',
                            color: ReColors().appTextBlackColor),
                      )),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.people_alt_outlined,
                            color: ReColors().appTextBlackColor,
                            size: 25,
                          ),
                          Expanded(
                              child: Text(
                            '${head_count == null ? 'loading...' : head_count}',
                            style: TextStyle(
                              color: ReColors().appTextBlackColor,
                              fontSize: 16.0,
                              fontFamily: 'headingfont',
                            ),
                            textAlign: TextAlign.center,
                          )),
                        ],
                      ),
                    )
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
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        width: 3, color: ReColors().workedhour_outline)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Center(
                          child: Text(
                        "Worked Hours",
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'headerfont',
                            color: ReColors().appTextBlackColor),
                      )),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.hourglass_bottom,
                            color: ReColors().appTextBlackColor,
                            size: 25,
                          ),
                          Expanded(
                              child: Text(
                            '${worked_hours == null ? 'loading...' : worked_hours}%',
                            style: TextStyle(
                              color: ReColors().appTextBlackColor,
                              fontSize: 16.0,
                              fontFamily: 'headingfont',
                            ),
                            textAlign: TextAlign.center,
                          )),
                        ],
                      ),
                    )
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
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        width: 3, color: ReColors().absenteenism_outline)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Center(
                          child: Text(
                        "Absenteeism",
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'headerfont',
                            color: ReColors().appTextBlackColor),
                      )),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.calendarTimes,
                            color: ReColors().appTextBlackColor,
                            size: 25,
                          ),
                          Expanded(
                              child: Text(
                            '${absenteeism == null ? 'loading...' : absenteeism}%',
                            style: TextStyle(
                              color: ReColors().appTextBlackColor,
                              fontSize: 16.0,
                              fontFamily: 'headingfont',
                            ),
                            textAlign: TextAlign.center,
                          )),
                        ],
                      ),
                    )
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
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                        width: 3, color: ReColors().eit_pending_color)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      child: Center(
                          child: Text(
                        "Late In / Early Out",
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15,
                            fontFamily: 'headerfont',
                            color: ReColors().appTextBlackColor),
                      )),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                    Padding(
                      padding: EdgeInsets.all(5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          FaIcon(
                            FontAwesomeIcons.clock,
                            color: ReColors().appTextBlackColor,
                            size: 25,
                          ),
                          Expanded(
                              child: Text(
                            '${early_count == null ? 'loading...' : early_count}% /${late_count == null ? '' : late_count}%',
                            style: TextStyle(
                              color: ReColors().appTextBlackColor,
                              fontSize: 16.0,
                              fontFamily: 'headingfont',
                            ),
                            textAlign: TextAlign.center,
                          )),
                        ],
                      ),
                    )
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
      ],
    );
  }
}
