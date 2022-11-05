import 'package:art/InternetConnection/Offline.dart';
import 'package:art/ParsingJSON/GetJSONMethod.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/CustomAppbarWidget.dart';
import 'package:art/ReuseableWidget/StaticDropdown.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:art/ScreensWithData/Menu/MainMenuPopup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:intl/intl.dart';

import '../EApprovalScreens/NoUse/LeaveRequest.dart';

class ShortRequest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ShortRequestState();
}

class _ShortRequestState extends State<ShortRequest> {
  int getID;
  var hexDeocde;
  String _tosetDate;
  String _fromsetDate;
  TextEditingController descriptionController = TextEditingController();

  String todateTime;
  String fromdateTime;

  DateTime toselectedDate = DateTime.now();
  DateTime fromselectedDate = DateTime.now();

  TextEditingController _todateController = TextEditingController();
  TextEditingController _fromdateController = TextEditingController();
  bool inisChecked = false;
  bool outisChecked = false;
  bool otisChecked = true;
  bool correctionVisibility = false;
  bool outcorrectionVisibility = false;

  @override
  void initState() {
    _todateController.text = DateFormat.yMd().format(DateTime.now());
    _fromdateController.text = DateFormat.yMd().format(DateTime.now());
    super.initState();
  }

  Future<Null> _toselectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: toselectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        toselectedDate = picked;
        _todateController.text = DateFormat.yMd().format(toselectedDate);
      });
  }

  Future<dynamic> _refreshMenu() async {
    return await GetJSON().getProfileData(context,getID);
  }

  @override
  Widget build(BuildContext context) {
    return Willpopwidget().getWillScope(Scaffold(
        appBar: new CustomAppBar(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => MainMenuPopUp()),
            );
          },
          Title: 'Short Leaves',
          refreshonPressed: () {},
        ),
        body: ReuseOffline().getoffline(profileView()
        )));
  }
  Widget profileView() {
    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: RaisedButton.icon(
                              onPressed: () {
                                Navigator.pushNamed(context, '/leave');
                              },
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10.0))),
                              label: Text(
                                'Request Leaves',
                                style: TextStyle(color: Colors.white),
                              ),
                              icon: Icon(
                                Icons.arrow_back,
                                color: Colors.white,
                              ),
                              textColor: Colors.white,
                              splashColor: ReColors().appMainColor,
                              color: ReColors().appMainColor,
                            ),
                          ),
                          Align(
                            alignment: Alignment.topRight,
                            child: Container(
                                child: RaisedButton(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0))),
                                    onPressed: () {
                                      print('Button Clicked.');
                                    },
                                    textColor: Colors.white,
                                    color: Colors.transparent,
                                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                                    child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 0, 0, 0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: <Widget>[
                                            Container(
                                              color: Colors.transparent,
                                              padding: EdgeInsets.fromLTRB(
                                                  10, 4, 4, 4),
                                              child: Text(
                                                'Short Leaves',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.fromLTRB(
                                                  4, 0, 10, 0),
                                              child: Icon(
                                                Icons.arrow_forward,
                                                color: Colors.white,
                                                size: 30,
                                              ),
                                            ),
                                          ],
                                        )))),
                          ),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(17.0),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                color: Colors.grey,
                                offset: Offset(1.0, 15.0),
                                blurRadius: 20.0,
                              ),
                            ]),
                        child: Column(
                          children: <Widget>[
                            Padding(
                              padding:
                              const EdgeInsets.fromLTRB(15.0, 5, 15, 5),
                              child: Dropdown(
                                  'Employee', ['Uroosa Ali', 'Taha', 'Hamza']),
                            ),

                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                              child: Dropdown('Short Leave Type',
                                  ['8:30 to 17:30', '9:00 to 18:00']),
                            ),

                            Divider(
                              height: 1,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                              child: Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: EdgeInsets.all(5),
                                            child: Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                'Out Time',
                                                style: TextStyle(
                                                  color:
                                                      ReColors().appMainColor,
                                                  fontFamily: 'titlefont',
                                                ),
                                              ),
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              _toselectDate(context);
                                            },
                                            child: Container(
                                                padding: EdgeInsets.all(5.0),
                                                child: TextFormField(
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontFamily: 'titlefont',
                                                      fontSize: 15.0,
                                                      color: Colors.white),
                                                  enabled: false,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  controller: _todateController,
                                                  onSaved: (String val) {
                                                    _tosetDate = val;
                                                  },
                                                  autocorrect: true,
                                                  decoration: InputDecoration(
                                                    prefixIcon: Icon(
                                                      Icons
                                                          .calendar_today_rounded,
                                                      color: ReColors()
                                                          .appTextWhiteColor,
                                                    ),
                                                    hintStyle: TextStyle(
                                                        color: Colors.grey),
                                                    filled: true,
                                                    fillColor:
                                                        ReColors().appMainColor,
                                                    enabledBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12.0)),
                                                      borderSide: BorderSide(
                                                          color: Colors.green,
                                                          width: 2),
                                                    ),
                                                    focusedBorder:
                                                        OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.all(
                                                              Radius.circular(
                                                                  12.0)),
                                                      borderSide: BorderSide(
                                                          color: Colors.green,
                                                          width: 2),
                                                    ),
                                                  ),
                                                )),
                                          )
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                        child: Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'Return Time',
                                              style: TextStyle(
                                                color: ReColors().appMainColor,
                                                fontFamily: 'titlefont',
                                              ),
                                            ),
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            _toselectDate(context);
                                          },
                                          child: Container(
                                              padding: EdgeInsets.all(5.0),
                                              child: TextFormField(
                                                textAlign: TextAlign.center,
                                                enabled: false,
                                                keyboardType:
                                                    TextInputType.text,
                                                style: TextStyle(
                                                    fontFamily: 'titlefont',
                                                    fontSize: 15.0,
                                                    color: Colors.white),
                                                controller: _fromdateController,
                                                onSaved: (String val) {
                                                  _fromsetDate = val;
                                                },
                                                autocorrect: true,
                                                decoration: InputDecoration(
                                                  prefixIcon: Icon(
                                                      Icons
                                                          .calendar_today_rounded,
                                                      color: ReColors()
                                                          .appTextWhiteColor),
                                                  hintStyle: TextStyle(
                                                      color: Colors.grey),
                                                  filled: true,
                                                  fillColor:
                                                      ReColors().appMainColor,
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                12.0)),
                                                    borderSide: BorderSide(
                                                        color: Colors.green,
                                                        width: 2),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                10.0)),
                                                    borderSide: BorderSide(
                                                        color: Colors.green,
                                                        width: 2),
                                                  ),
                                                ),
                                              )),
                                        )
                                      ],
                                    )),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 10),
                              child: Container(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: TextField(
                                    style: TextStyle(
                                        color: ReColors().appMainColor,
                                        fontFamily: 'titlefont'),
                                    controller: descriptionController,
                                    decoration: InputDecoration(
                                      fillColor: ReColors().appMainColor,
                                      enabledBorder: new OutlineInputBorder(
                                        borderRadius:
                                            new BorderRadius.circular(5.0),
                                        borderSide: BorderSide(
                                            color: ReColors().appMainColor),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Color(0xff055e8e),
                                            width: 2.0),
                                        borderRadius:
                                            BorderRadius.circular(5.0),
                                      ),
                                      labelText: 'Remarks',
                                      labelStyle: TextStyle(
                                          color: Color(0xff055e8e),
                                          fontFamily: 'titlefont'),
                                    ),
                                    onChanged: (addresstext) {
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          child: Row(children: <Widget>[
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 20),
                          child: RaisedButton(
                              onPressed: () {},
                              color: ReColors().greenColor,
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.thumb_up,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "Save",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'headerfont'),
                                    )
                                  ],
                                ),
                              )),
                        )),
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 20),
                          child: RaisedButton(
                              onPressed: () {},
                              color: ReColors().blueColor,
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.thumb_down,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "Delete",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'headerfont'),
                                    )
                                  ],
                                ),
                              )),
                        )),
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 20),
                          child: RaisedButton(
                              onPressed: () {},
                              color: Colors.red,
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  children: [
                                    Icon(
                                      Icons.cancel,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "Cancel",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'headerfont'),
                                    )
                                  ],
                                ),
                              )),
                        )),
                      ])),
                    ],
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}

