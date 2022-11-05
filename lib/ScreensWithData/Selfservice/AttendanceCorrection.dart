import 'package:art/InternetConnection/Offline.dart';
import 'package:art/ParsingJSON/GetJSONMethod.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/CustomAppbarWidget.dart';
import 'package:art/ReuseableWidget/StaticDropdown.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:art/ScreensWithData/Menu/MainMenuPopup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AttendanceCorrection extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AttendanceCorrectionState();
}

class _AttendanceCorrectionState extends State<AttendanceCorrection> {
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
          Title: 'Correction',
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 8, 10, 0),
                                    child: Text(
                                      'Search',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontFamily: 'headerfont'),
                                    ),
                                  ),
                                )),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(15.0,5,15,5),
                              child: Dropdown(
                                  'Employee', ['Uroosa Ali', 'Taha', 'Hamza']),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: InkWell(
                                onTap: () {
                                  _toselectDate(context);
                                },
                                child: Container(
                                    padding: EdgeInsets.all(5.0),
                                    child: TextFormField(
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontFamily: 'headingfont',
                                          fontSize: 15.0,
                                          color: Colors.white),
                                      enabled: false,
                                      keyboardType: TextInputType.text,
                                      controller: _todateController,
                                      onSaved: (String val) {
                                        _tosetDate = val;
                                      },
                                      autocorrect: true,
                                      decoration: InputDecoration(
                                        prefixIcon: Icon(
                                          Icons.calendar_today_rounded,
                                          color: ReColors().appTextWhiteColor,
                                        ),
                                        hintStyle:
                                            TextStyle(color: Colors.grey),
                                        filled: true,
                                        fillColor: ReColors().appMainColor,
                                        enabledBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide: BorderSide(
                                              color: Colors.green, width: 2),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12.0)),
                                          borderSide: BorderSide(
                                              color: Colors.green, width: 2),
                                        ),
                                      ),
                                    )),
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: FlatButton(
                                color: ReColors().appMainColor,
                                textColor: Colors.white,
                                child: Text('Search'),
                                onPressed: () {
                                  setState(() {
                                    Navigator.pop(context);
                                  });
                                },
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
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    flex: 7,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 8, 10, 0),
                                        child: Text('Result',
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontFamily: 'headerfont')),
                                      ),
                                    )),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                              child: Container(
                                height: 40,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                'Time In:',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'headingfont'),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                '',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'titlefont'),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                'Time Out:',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'headingfont'),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                '',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'titlefont'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                              child: Container(
                                height: 40,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                'Worked Hours:',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'headingfont'),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                '',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'titlefont'),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                'OT hours:',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'headingfont'),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                '',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'titlefont'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                              child: Container(
                                height: 40,
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                'Day Status:',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'headingfont'),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                '',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'titlefont'),
                                              ),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                'Early Coming:',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'headingfont'),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                '',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'titlefont'),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                              child: Container(
                                height: 40,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Early Going:',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'headingfont'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'titlefont'),
                                        ),
                                      ),
                                    ],
                                  ),
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
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    flex: 7,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 8, 10, 0),
                                        child: Text('Attendance Correction',
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontFamily: 'headerfont')),
                                      ),
                                    )),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
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
                                              inisChecked = !inisChecked;
                                              correctionVisibility = true;
                                            });
                                          },
                                          activeColor: Colors.transparent,
                                          checkColor:
                                              ReColors().appTextBlackColor,
                                          materialTapTargetSize:
                                              MaterialTapTargetSize.padded,
                                        ),
                                        Text(
                                          'Time Correction',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'headingfont'),
                                        )
                                      ],
                                    )),
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                              child: Container(
                                height: 40,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: outisChecked,
                                        onChanged: (state) => setState(() {
                                          outisChecked = !outisChecked;
                                          print('inisChecked: ${inisChecked}');
                                          if (inisChecked == false) {
                                            outcorrectionVisibility = true;
                                          } else {
                                            outcorrectionVisibility = true;
                                            correctionVisibility = true;
                                          }
                                        }),
                                        activeColor: Colors.transparent,
                                        checkColor:
                                            ReColors().appTextBlackColor,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.padded,
                                      ),
                                      Text(
                                        'OverTime Time Correction',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'headingfont'),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                              child: Container(
                                height: 40,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Checkbox(
                                        value: otisChecked,
                                        onChanged: (state) {
                                          setState(() {
                                            otisChecked = !otisChecked;
                                            print(
                                                'inisChecked: ${inisChecked}');
                                          });
                                        },
                                        activeColor: Colors.transparent,
                                        checkColor:
                                            ReColors().appTextBlackColor,
                                        materialTapTargetSize:
                                            MaterialTapTargetSize.padded,
                                      ),
                                      Text(
                                        'Request for No Late Deduction',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontFamily: 'headingfont'),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Divider(
                              height: 1,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                              child: Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      inisChecked == false
                                          ? Container()
                                          : Visibility(
                                              visible: correctionVisibility,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'IN    ',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily:
                                                            'headingfont'),
                                                  ),
                                                  Expanded(
                                                      child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        _toselectDate(context);
                                                      },
                                                      child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  5.0),
                                                          child: TextFormField(
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'headingfont',
                                                                fontSize: 15.0,
                                                                color: Colors
                                                                    .white),
                                                            enabled: false,
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            controller:
                                                                _todateController,
                                                            onSaved:
                                                                (String val) {
                                                              _tosetDate = val;
                                                            },
                                                            autocorrect: true,
                                                            decoration:
                                                                InputDecoration(
                                                              prefixIcon: Icon(
                                                                Icons
                                                                    .calendar_today_rounded,
                                                                color: ReColors()
                                                                    .appTextWhiteColor,
                                                              ),
                                                              hintStyle: TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                              filled: true,
                                                              fillColor: ReColors()
                                                                  .appMainColor,
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            12.0)),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .green,
                                                                    width: 2),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            12.0)),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .green,
                                                                    width: 2),
                                                              ),
                                                            ),
                                                          )),
                                                    ),
                                                  )),
                                                ],
                                              )),
                                      inisChecked == false
                                          ? Container()
                                          : Visibility(
                                              visible: correctionVisibility,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    'OUT',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily:
                                                            'headingfont'),
                                                  ),
                                                  Expanded(
                                                      child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: InkWell(
                                                      onTap: () {
                                                        _toselectDate(context);
                                                      },
                                                      child: Container(
                                                          padding:
                                                              EdgeInsets.all(
                                                                  5.0),
                                                          child: TextFormField(
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontFamily:
                                                                    'headingfont',
                                                                fontSize: 15.0,
                                                                color: Colors
                                                                    .white),
                                                            enabled: false,
                                                            keyboardType:
                                                                TextInputType
                                                                    .text,
                                                            controller:
                                                                _todateController,
                                                            onSaved:
                                                                (String val) {
                                                              _tosetDate = val;
                                                            },
                                                            autocorrect: true,
                                                            decoration:
                                                                InputDecoration(
                                                              prefixIcon: Icon(
                                                                Icons
                                                                    .calendar_today_rounded,
                                                                color: ReColors()
                                                                    .appTextWhiteColor,
                                                              ),
                                                              hintStyle: TextStyle(
                                                                  color: Colors
                                                                      .grey),
                                                              filled: true,
                                                              fillColor: ReColors()
                                                                  .appMainColor,
                                                              enabledBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            12.0)),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .green,
                                                                    width: 2),
                                                              ),
                                                              focusedBorder:
                                                                  OutlineInputBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            12.0)),
                                                                borderSide: BorderSide(
                                                                    color: Colors
                                                                        .green,
                                                                    width: 2),
                                                              ),
                                                            ),
                                                          )),
                                                    ),
                                                  )),
                                                ],
                                              )),
                                      outisChecked == false
                                          ? Container()
                                          : Visibility(
                                              visible: outcorrectionVisibility,
                                              child: Row(
                                                children: [
                                                  Text(
                                                    '         ',
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily:
                                                        'headingfont'),
                                                  ),
                                                  Expanded(
                                                      child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: TextField(
                                                      style: TextStyle(
                                                          color: ReColors()
                                                              .appMainColor,
                                                          fontFamily:
                                                              'headingfont'),
                                                      controller:
                                                          descriptionController,
                                                      decoration:
                                                          InputDecoration(
                                                        fillColor: ReColors()
                                                            .appMainColor,
                                                        enabledBorder:
                                                            new OutlineInputBorder(
                                                          borderRadius:
                                                              new BorderRadius
                                                                      .circular(
                                                                  5.0),
                                                          borderSide: BorderSide(
                                                              color: ReColors()
                                                                  .appMainColor),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: Color(
                                                                      0xff055e8e),
                                                                  width: 2.0),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                      5.0),
                                                        ),
                                                        labelText: 'OT Hours',
                                                        labelStyle: TextStyle(
                                                            color: Color(
                                                                0xff055e8e),
                                                            fontFamily:
                                                                'headingfont'),
                                                      ),
                                                      onChanged: (addresstext) {
                                                        setState(() {});
                                                      },
                                                    ),
                                                  )),
                                                ],
                                              ))
                                    ],
                                  ),
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
                                        fontFamily: 'headingfont'),
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
                                          fontFamily: 'headingfont'),
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
                          children: <Widget>[
                            Row(
                              children: [
                                Expanded(
                                    child: Align(
                                  alignment: Alignment.center,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 8, 10, 0),
                                    child: Text('Designated Approver',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontFamily: 'headerfont')),
                                  ),
                                )),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                              child: Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Icon(
                                            Icons.search,
                                            size: 70,
                                            color: ReColors().appMainColor,
                                          )),
                                      Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            'No Approver Found',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'headingfont'),
                                          )),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                              child: Container(
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      FlatButton(
                                        color: ReColors().appMainColor,
                                        textColor: Colors.white,
                                        child: Text('Intial Request'),
                                        onPressed: () {
                                          setState(() {
                                            //Navigator.pop(context);
                                          });
                                        },
                                      )
                                    ],
                                  ),
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
}

