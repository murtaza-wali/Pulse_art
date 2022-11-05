import 'package:art/InternetConnection/Offline.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/CustomAppbarWithImage.dart';
import 'package:art/ReuseableWidget/StaticDropdown.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:art/ScreensWithData/Menu/MainMenuPopup.dart';
import 'package:dotted_decoration/dotted_decoration.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'eitMain.dart';


class ticketCreate extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ticketCreateState();
}

class _ticketCreateState extends State<ticketCreate> {
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
  bool selfAssignVisibility = true;
  bool selfAssignVisibility1 = false;
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

  @override
  Widget build(BuildContext context) {
    return Willpopwidget().getWillScope(Scaffold(
        appBar:  new CustomAppBarImage(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => eitMain()),
            );
          },
          Title: '',
          image_bar: 'assets/images/EIT_logo.png',
          refreshonPressed: () {
          },
        ),
        body: ReuseOffline().getoffline(profileView())));
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
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                              child: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Expanded(
                                            child: Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 8, 10, 7),
                                            child: Text(
                                              'Complaint By',
                                              style: TextStyle(
                                                  color:
                                                      ReColors().appMainColor,
                                                  fontSize: 18,
                                                  fontFamily: 'headerfont'),
                                            ),
                                          ),
                                        )),
                                      ],
                                    ),
                                    Dropdown(
                                      'Org',
                                      ['CO'],
                                      update: () {},
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Container(
                                        height: 40,
                                        child: Align(
                                            alignment: Alignment.centerRight,
                                            child: Row(
                                              children: [
                                                Checkbox(
                                                  value: inisChecked,
                                                  onChanged: (state) {
                                                    setState(() {
                                                      inisChecked =
                                                          !inisChecked;
                                                      correctionVisibility =
                                                          true;
                                                    });
                                                  },
                                                  activeColor:
                                                      Colors.transparent,
                                                  checkColor: ReColors()
                                                      .appTextBlackColor,
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .padded,
                                                ),
                                                Text(
                                                  'Other Unit',
                                                  style: TextStyle(
                                                      color: ReColors()
                                                          .appMainColor,
                                                      fontFamily:
                                                          'headingfont'),
                                                )
                                              ],
                                            )),
                                      ),
                                    ),
                                    Dropdown('Department',
                                        ['38420980', '3234404', '3423443']),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Dropdown(
                                        'Employee',
                                        ['Casual', 'Sick', 'Annual'],
                                        update: () {},
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
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
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                              child: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 8, 10, 7),
                                            child: Text(
                                              'Ticket Info',
                                              style: TextStyle(
                                                  color:
                                                      ReColors().appMainColor,
                                                  fontSize: 18,
                                                  fontFamily: 'headerfont'),
                                            ),
                                          ),
                                        )
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Container(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextField(
                                            style: TextStyle(
                                                color: ReColors().appMainColor,
                                                fontFamily: 'titlefont'),
                                            controller: descriptionController,
                                            decoration: InputDecoration(
                                              fillColor:
                                                  ReColors().appMainColor,
                                              enabledBorder:
                                                  new OutlineInputBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        5.0),
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
                                              labelText: 'Subject',
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
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Dropdown(
                                        'Severity',
                                        ['Urgent', 'High', 'Medium'],
                                        update: () {},
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Container(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextField(
                                            style: TextStyle(
                                                color: ReColors().appMainColor,
                                                fontFamily: 'titlefont'),
                                            controller: descriptionController,
                                            decoration: InputDecoration(
                                              fillColor:
                                                  ReColors().appMainColor,
                                              enabledBorder:
                                                  new OutlineInputBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        5.0),
                                                borderSide: BorderSide(
                                                    color: ReColors()
                                                        .appMainColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0xff055e8e),
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              labelText: 'Description',
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
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
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
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                              child: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 8, 10, 7),
                                            child: Text(
                                              'Assign To',
                                              style: TextStyle(
                                                  color:
                                                      ReColors().appMainColor,
                                                  fontSize: 18,
                                                  fontFamily: 'headerfont'),
                                            ),
                                          ),
                                        )),
                                      ],
                                    ),
                                    Dropdown('Complaint Type',
                                        ['38420980', '3234404', '3423443']),
                                    Column(
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(5),
                                          child: Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              'Date',
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
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Container(
                                        height: 40,
                                        child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Row(
                                              children: [
                                                Checkbox(
                                                  value: inisChecked,
                                                  onChanged: (state) {
                                                    setState(() {
                                                      inisChecked =
                                                          !inisChecked;
                                                      correctionVisibility =
                                                          true;
                                                      _toggleSelfAssign();
                                                      _toggleSelfAssign1();
                                                    });
                                                  },
                                                  activeColor:
                                                      Colors.transparent,
                                                  checkColor: ReColors()
                                                      .appTextBlackColor,
                                                  materialTapTargetSize:
                                                      MaterialTapTargetSize
                                                          .padded,
                                                ),
                                                Text(
                                                  'Self Assign',
                                                  style: TextStyle(
                                                      color: ReColors()
                                                          .appMainColor,
                                                      fontFamily:
                                                          'headingfont'),
                                                )
                                              ],
                                            )),
                                      ),
                                    ),
                                    Visibility(
                                        visible: selfAssignVisibility,
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 5, 0, 5),
                                              child: Dropdown(
                                                'To Department',
                                                ['Casual', 'Sick', 'Annual'],
                                                update: () {},
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      0, 5, 0, 5),
                                              child: Dropdown(
                                                'To Employee',
                                                ['Casual', 'Sick', 'Annual'],
                                                update: () {},
                                              ),
                                            ),
                                          ],
                                        )),
                                    Visibility(
                                        visible: selfAssignVisibility1,
                                        child: Align(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.max,
                                            crossAxisAlignment: CrossAxisAlignment.stretch,
                                            children: [
                                              Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 5, 0, 5),
                                                child: Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 10, 10, 10),
                                                  decoration: DottedDecoration(
                                                      shape: Shape.box,
                                                      color: Colors.grey,
                                                      strokeWidth: 2),
                                                  child: Column(
                                                    children: [
                                                      Text('To Employee',
                                                          style: TextStyle(
                                                              color: ReColors()
                                                                  .appMainColor,
                                                              fontFamily:
                                                                  'headerfont')),
                                                      Text('',
                                                          style: TextStyle(
                                                              color: ReColors()
                                                                  .appMainColor,
                                                              fontFamily:
                                                                  'headingfont')),
                                                      Text('Taha Siddiqui',
                                                          style: TextStyle(
                                                              color: ReColors()
                                                                  .appMainColor,
                                                              fontFamily:
                                                                  'headingfont')),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          alignment: Alignment.topLeft,
                                        ))
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
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

  void _toggleSelfAssign() {
    setState(() {
      selfAssignVisibility = !selfAssignVisibility;
    });
  }

  void _toggleSelfAssign1() {
    setState(() {
      selfAssignVisibility1 = !selfAssignVisibility1;
    });
  }
}
