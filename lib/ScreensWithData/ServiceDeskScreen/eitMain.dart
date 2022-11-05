import 'dart:convert';
import 'dart:io';

import 'package:art/Error/Error.dart';
import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/Model/DAM/DAMunitlist.dart';
import 'package:art/ParsingJSON/GetJSONMethod.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/CustomAppbarWithImage.dart';
import 'package:art/ReuseableWidget/CustomDropdown.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:art/ScreensWithData/Menu/MainMenuPopup.dart';
import 'package:art/ScreensWithData/ServiceDeskScreen/ticketCreate.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unicorndial/unicorndial.dart';

import 'Report.dart';
import 'WorkboardTicketsSearch.dart';

class eitMain extends StatefulWidget {
  _eitMainState createState() => _eitMainState();
}

Widget showError(String message, key) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Center(
        child: Icon(
          key,
          size: 70,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      )
    ],
  );
}

class _eitMainState extends State<eitMain> {
  List<DamUnitListitem> dam_unit_list = [];
  int selected_unit_id;
  int getID;
  int InProcess, UserFeedback, closed, pending;
  String employeCode;
  String selectedSpinnerItem;
  bool visible = false;
  bool boxesvisible = false;

  @override
  void initState() {
    super.initState();
    MySharedPreferences.instance
        .getIntValue("UserId")
        .then((value) => setState(() {
              getID = value;
              print(getID);
              GetJSON().getDAMUnitList(getID).then((DAMData) {
                setState(() {
                  dam_unit_list = DAMData;
                  if (dam_unit_list.length == 0) {
                    visible = false;
                    return showError(
                        'No data found', Icons.assignment_late_outlined);
                  } else {
                    selected_unit_id = dam_unit_list.first.orgId;
                    visible = true;
                  }
                });
              });
            }));
    MySharedPreferences.instance
        .getStringValue("employeecode")
        .then((name) => setState(() {
              employeCode = name;
            }));
  }

  Future<dynamic> _refreshMenu() async {
    return await GetJSON().getDAMUnitList(getID);
  }

  Widget chip(String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: ReColors().appMainColor,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var childButtons = List<UnicornButton>();

    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Workboard",
        labelColor: ReColors().appMainColor,
        currentButton: FloatingActionButton(
          heroTag: "Workboard",
          backgroundColor: ReColors().appMainColor,
          mini: true,
          child: Icon(Icons.assignment_outlined),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => WorkboardEIT()),
                (Route<dynamic> route) => false);
          },
        )));
    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Report",
        labelColor: ReColors().appMainColor,
        currentButton: FloatingActionButton(
          heroTag: "Report",
          backgroundColor: ReColors().appMainColor,
          mini: true,
          child: Icon(Icons.analytics_outlined),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (BuildContext context) => Report()),
                (Route<dynamic> route) => false);
          },
        )));
    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Create Ticket",
        labelColor: ReColors().appMainColor,
        currentButton: FloatingActionButton(
          heroTag: "Create Ticket",
          backgroundColor: ReColors().appMainColor,
          mini: true,
          child: Icon(Icons.support),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (BuildContext context) => ticketCreate()),
                (Route<dynamic> route) => false);
          },
        )));
    return Scaffold(
        floatingActionButton: UnicornDialer(
            backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
            parentButtonBackground: ReColors().appMainColor,
            orientation: UnicornOrientation.VERTICAL,
            parentButton: Icon(Icons.menu),
            childButtons: childButtons),
        appBar: new CustomAppBarImage(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => MainMenuPopUp()),
            );
          },
          Title: '',
          image_bar: 'assets/images/EIT_logo.png',
          refreshonPressed: () {
            _refreshMenu().then((list) {
              setState(() {
                dam_unit_list = list;
                if (dam_unit_list.length == 0) {
                  visible = false;
                  return showError(
                      'No data found', Icons.assignment_late_outlined);
                }
                else {
                  selected_unit_id = dam_unit_list.first.orgId;
                  visible = true;
                }
              });
            });
          },
        ),
        body: Willpopwidget().getWillScope(SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Visibility(
              visible: visible,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                            child: Align(
                          alignment: Alignment.center,
                          child: Text(
                            'Support Status',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                                color: ReColors().appMainColor,
                                fontSize: 18,
                                fontFamily: 'headerfont'
                            ),
                          ),
                        )
                        )
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(5),
                      child: FutureBuilder<List<DamUnitListitem>>(
                        future: GetJSON().getDAMUnitList(getID),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return CustomDropdown(
                              dropdownMenuItemList: dam_unit_list.map((item) {
                                    return DropdownMenuItem(
                                      child: chip(item.companycode),
                                      value: item.companycode,
                                      onTap: () {
                                        selected_unit_id = item.orgId;
                                        print(
                                            'Selected UNit ID: ${selected_unit_id}');
                                        print(
                                            'selectedSpinnerItem3293: ${selectedSpinnerItem.toString()}');
                                      },
                                    );
                                  }).toList() ??
                                  [],
                              onChanged: (newVal) {
                                setState(() {
                                  selectedSpinnerItem = newVal;
                                  boxesvisible = true;
                                  print(
                                      'selected_unit_id test: ${selected_unit_id.toString()}');
                                  print(
                                      'selectedSpinnerItem test: ${selectedSpinnerItem.toString()}');
                                  GetJSON()
                                      .PostEitdashboardvalue(
                                          selected_unit_id, 2)
                                      .then((value) {
                                    Map<String, dynamic> device =
                                    jsonDecode(value.body);
                                    InProcess = device['type_counts'];
                                    print('InProcess: ${InProcess}');
                                    _refreshMenu().then((list) {
                                      setState(() {
                                        dam_unit_list = list;
                                        if (dam_unit_list.length == 0) {
                                          visible = false;
                                          return showError('No data found',
                                              Icons.assignment_late_outlined);
                                        } else {
                                          selected_unit_id =
                                              dam_unit_list.first.orgId;
                                          visible = true;
                                        }
                                      });
                                    });
                                  });
                                  GetJSON()
                                      .PostEitdashboardvalue(
                                          selected_unit_id, 5)
                                      .then((value) {
                                    Map<String, dynamic> device =
                                    jsonDecode(value.body);
                                    UserFeedback = device['type_counts'];
                                    print('UserFeedback: ${UserFeedback}');
                                    _refreshMenu().then((list) {
                                      setState(() {
                                        dam_unit_list = list;
                                        if (dam_unit_list.length == 0) {
                                          visible = false;
                                          return showError('No data found',
                                              Icons.assignment_late_outlined);
                                        } else {
                                          selected_unit_id =
                                              dam_unit_list.first.orgId;
                                          visible = true;
                                        }
                                      });
                                    });
                                  });
                                  GetJSON()
                                      .PostEitdashboardvalue(selected_unit_id, 7)
                                      .then((value) {
                                    Map<String, dynamic> device =
                                    jsonDecode(value.body);
                                    closed = device['type_counts'];
                                    print('closed: ${closed}');
                                    _refreshMenu().then((list) {
                                      setState(() {
                                        dam_unit_list = list;
                                        if (dam_unit_list.length == 0) {
                                          visible = false;
                                          return showError('No data found',
                                              Icons.assignment_late_outlined);
                                        }
                                        else {
                                          selected_unit_id =
                                              dam_unit_list.first.orgId;
                                          visible = true;
                                        }
                                      });
                                    });
                                  });
                                  GetJSON()
                                      .PostEitdashboardvalue(
                                          selected_unit_id, 0)
                                      .then((value) {
                                    Map<String, dynamic> device =
                                    jsonDecode(value.body);
                                    pending = device['type_counts'];
                                    print('pending: ${pending}');
                                    _refreshMenu().then((list) {
                                      setState(() {
                                        dam_unit_list = list;
                                        if (dam_unit_list.length == 0) {
                                          visible = false;
                                          return showError('No data found',
                                              Icons.assignment_late_outlined);
                                        }
                                        else {
                                          selected_unit_id =
                                              dam_unit_list.first.orgId;
                                          visible = true;
                                        }
                                      });
                                    });
                                  });
                                });
                              },
                              value: selectedSpinnerItem,
                              isEnabled: true,
                              color: ReColors().appMainColor,
                              hint: 'Unit',
                            );
                          }
                          else if (snapshot.hasError) {
                            if (snapshot.error is HttpException) {
                              HttpException httpException =
                                  snapshot.error as HttpException;
                              return showError(
                                  'An http error occurred.Page not found. Please try again.',
                                  Icons.error);
                            }
                            if (snapshot.error is NoInternetException) {
                              NoInternetException noInternetException =
                                  snapshot.error as NoInternetException;
                              return showError(
                                  'Please check your internet connection',
                                  Icons
                                      .signal_wifi_connected_no_internet_4_sharp);
                            }
                            if (snapshot.error is NoServiceFoundException) {
                              NoServiceFoundException noServiceFoundException = snapshot.error as NoServiceFoundException;
                              return showError('Server Error.', Icons.error);
                            }
                            if (snapshot.error is InvalidFormatException) {
                              InvalidFormatException invalidFormatException =
                                  snapshot.error as InvalidFormatException;
                              return showError('There is a problem with your request.', Icons.error);
                            }
                            if (snapshot.error is SocketException) {
                              SocketException socketException =
                                  snapshot.error as SocketException;
                              print(
                                  'Socket checking: ${socketException.message}');
                              return showError(
                                  'Please check your internet connection',
                                  Icons
                                      .signal_wifi_connected_no_internet_4_sharp);
                            }
                            else {
                              UnknownException unknownException =
                                  snapshot.error as UnknownException;
                              return showError(
                                  'An Unknown error occurred.', Icons.error);
                            }
                          }
                          return Center(
                              child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                ReColors().appMainColor),
                          ));
                        },
                      )),
                  Container(
                      child: chlidDAMain(
                    in_process: InProcess,
                    user_feedback: UserFeedback,
                    closed: closed,
                    pending: pending,
                    boxesvisible: boxesvisible,
                  ))
                ],
              ),
            ),
          ),
        )));
  }
}

class chlidDAMain extends StatefulWidget {
  int in_process, user_feedback, closed, pending;
  bool boxesvisible = false;

  chlidDAMain(
      {Key key,
      this.in_process,
      this.user_feedback,
      this.closed,
      this.pending,
      this.boxesvisible})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChildDAMState();
}

class _ChildDAMState extends State<chlidDAMain> {
  @override
  Widget build(BuildContext context) {
    return boxesVisibility(widget.in_process, widget.user_feedback,
        widget.closed, widget.pending, widget.boxesvisible);
  }

  Widget boxesVisibility(
      inprocess, userfeedback, closed, pending, boxesvisible) {
    return Visibility(
        visible: boxesvisible,
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Column(
            children: [
              Card(
                child: Container(
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(-0.6, -1),
                      end: Alignment(-1, -0),
                      colors: [
                        ReColors().eit_in_process_color,
                        ReColors().eit_in_process_color
                      ],
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Center(
                            child: Text(
                          "In Process",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              fontFamily: 'headerfont',
                              color: ReColors().appTextWhiteColor),
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
                              FontAwesomeIcons.sync,
                              color: Colors.white,
                              size: 40,
                            ),
                            Text(
                              '${inprocess == null ? 'loading...' : inprocess}',
                              style: TextStyle(
                                color: ReColors().appTextWhiteColor,
                                fontSize: 30.0,
                                fontFamily: 'headingfont',
                              ),
                              textAlign: TextAlign.center,
                            ),
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
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(-0.6, -1),
                      end: Alignment(-1, -0),
                      colors: [
                        ReColors().eit_pending_color,
                        ReColors().eit_pending_color
                      ],
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Center(
                            child: Text(
                          "Pending",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              fontFamily: 'headerfont',
                              color: ReColors().appTextWhiteColor),
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
                              FontAwesomeIcons.hourglass,
                              color: Colors.white,
                              size: 40,
                            ),
                            Text(
                              '${pending == null ? 'loading...' : pending}',
                              style: TextStyle(
                                color: ReColors().appTextWhiteColor,
                                fontSize: 30.0,
                                fontFamily: 'headingfont',
                              ),
                              textAlign: TextAlign.center,
                            ),
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
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(-0.6, -1),
                      end: Alignment(-1, -0),
                      colors: [
                        ReColors().eit_user_feedback_color,
                        ReColors().eit_user_feedback_color
                      ],
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Center(
                            child: Text(
                          "User Feedback",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              fontFamily: 'headerfont',
                              color: ReColors().appTextWhiteColor),
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
                              FontAwesomeIcons.user,
                              color: Colors.white,
                              size: 40,
                            ),
                            Text(
                              '${userfeedback == null ? 'loading...' : userfeedback}',
                              style: TextStyle(
                                color: ReColors().appTextWhiteColor,
                                fontSize: 30.0,
                                fontFamily: 'headingfont',
                              ),
                              textAlign: TextAlign.center,
                            ),
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
              ),
              Card(
                child: Container(
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(-0.6, -1),
                      end: Alignment(-1, -0),
                      colors: [
                        ReColors().eit_closed_color,
                        ReColors().eit_closed_color
                      ],
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Center(
                            child: Text(
                          "Closed",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              fontFamily: 'headerfont',
                              color: ReColors().appTextWhiteColor),
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
                              FontAwesomeIcons.checkCircle,
                              color: Colors.white,
                              size: 40,
                            ),
                            Text(
                              '${closed == null ? 'loading...' : closed}',
                              style: TextStyle(
                                color: ReColors().appTextWhiteColor,
                                fontSize: 30.0,
                                fontFamily: 'headingfont',
                              ),
                              textAlign: TextAlign.center,
                            ),
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
              ),
            ],
          ),
        ));
  }
}
