import 'package:art/HexCodeConverter/Hexcode.dart';
import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/CustomAppbarWithImage.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:flutter/material.dart';

import 'Workboard.dart';

class ticketDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ticketDetailsState();
}

class _ticketDetailsState extends State<ticketDetails> {
  int getID;
  String employeCode;
  Color color2 = HexColor("#055e8e");
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    MySharedPreferences.instance
        .getIntValue("UserId")
        .then((value) => setState(() {
      getID = value;
    }));

    MySharedPreferences.instance
        .getStringValue("employeecode")
        .then((name) => setState(() {
      employeCode = name;
    }));
  }

  List<DataRow> _rowList = [
    DataRow(cells: <DataCell>[
      DataCell(Text('Open',
          style: TextStyle(
              color: ReColors().appMainColor,
              fontSize: 14.0,
              fontFamily: 'titlefont'))),
      DataCell(Text('Test',
          style: TextStyle(
              color: ReColors().appMainColor,
              fontSize: 14.0,
              fontFamily: 'titlefont'))),
      DataCell(Text('07-JUL-2021 10:38AM',
          style: TextStyle(
              color: ReColors().appMainColor,
              fontSize: 14.0,
              fontFamily: 'titlefont'))),
    ]),
  ];

  @override
  Widget build(BuildContext context) {
    return Willpopwidget().getWillScope(
      Scaffold(
          appBar: new CustomAppBarImage(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => WorkboardEIT()),
              );
            },
            Title: 'SERVICE DESK',
            image_bar: 'assets/images/EIT_logo.png',
          ),
          body: SingleChildScrollView(
            child: Container(
              padding: EdgeInsets.all(2),
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Ticket Details',
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: ReColors().appMainColor,
                          fontSize: 18,
                          fontFamily: 'headerfont'
                      ),
                    ),
                  ),
                  Card(
                    child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(-0.6, -1),
                            end: Alignment(-1, -0),
                            colors: [Colors.white24, Colors.white],
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Complaint ID: ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: ReColors().appMainColor,
                                          fontSize: 14.0,
                                          fontFamily: 'headingfont')),
                                      Text('6',
                                        style: TextStyle(
                                          color: ReColors().appMainColor,
                                          fontSize: 14.0,
                                          fontFamily: 'titlefont'))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('To: ',
                                      textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: ReColors().appMainColor,
                                          fontSize: 14.0,
                                          fontFamily: 'headingfont')),
                                  Text('I.T(E.R.P)',
                                      style: TextStyle(
                                          color: ReColors().appMainColor,
                                          fontSize: 14.0,
                                          fontFamily: 'titlefont'))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('From: ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: ReColors().appMainColor,
                                          fontSize: 14.0,
                                          fontFamily: 'headingfont')),
                                  Text('I.T(E.R.P)',
                                      style: TextStyle(
                                          color: ReColors().appMainColor,
                                          fontSize: 14.0,
                                          fontFamily: 'titlefont'))
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Assigned To: ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: ReColors().appMainColor,
                                          fontSize: 14.0,
                                          fontFamily: 'headingfont')),
                                  Text('Hamza Hanif',
                                      style: TextStyle(
                                          color: ReColors().appMainColor,
                                          fontSize: 14.0,
                                          fontFamily: 'titlefont'))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Complaint Date:	',
                                      textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: ReColors().appMainColor,
                                          fontSize: 14.0,
                                          fontFamily: 'headingfont')),
                                  Text('7/7/2021',
                                        style: TextStyle(
                                          color: ReColors().appMainColor,
                                          fontSize: 14.0,
                                          fontFamily: 'titlefont'))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Complaint Type:	',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: ReColors().appMainColor,
                                          fontSize: 14.0,
                                          fontFamily: 'headingfont')),
                                  Text(' ',
                                      style: TextStyle(
                                          color: ReColors().appMainColor,
                                          fontSize: 14.0,
                                          fontFamily: 'titlefont'))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Status: ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: ReColors().appMainColor,
                                          fontSize: 14.0,
                                          fontFamily: 'headingfont')),
                                  Text('In Process',
                                      style: TextStyle(
                                          color: ReColors().appMainColor,
                                          fontSize: 14.0,
                                          fontFamily: 'titlefont'))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Severity: ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: ReColors().appMainColor,
                                          fontSize: 14.0,
                                          fontFamily: 'headingfont')),
                                  Text('High',
                                      style: TextStyle(
                                          color: ReColors().appMainColor,
                                          fontSize: 14.0,
                                          fontFamily: 'titlefont'))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Complaint By: ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: ReColors().appMainColor,
                                          fontSize: 14.0,
                                          fontFamily: 'headingfont')),
                                  Text('Taha Siddiqui',
                                      style: TextStyle(
                                          color: ReColors().appMainColor,
                                          fontSize: 14.0,
                                          fontFamily: 'titlefont'))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Last Update By:	',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: ReColors().appMainColor,
                                          fontSize: 14.0,
                                          fontFamily: 'headingfont')),
                                  Text('ERPDEV5',
                                      style: TextStyle(
                                          color: ReColors().appMainColor,
                                          fontSize: 14.0,
                                          fontFamily: 'titlefont'))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Subject: ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: ReColors().appMainColor,
                                          fontSize: 14.0,
                                          fontFamily: 'headingfont')),
                                  Text('Complete Task',
                                      style: TextStyle(
                                          color: ReColors().appMainColor,
                                          fontSize: 14.0,
                                          fontFamily: 'titlefont'))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Last Updated Date: ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: ReColors().appMainColor,
                                          fontSize: 14.0,
                                          fontFamily: 'headingfont')),
                                  Text('7/7/2021',
                                      style: TextStyle(
                                          color: ReColors().appMainColor,
                                          fontSize: 14.0,
                                          fontFamily: 'titlefont'))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Description: ',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          color: ReColors().appMainColor,
                                          fontSize: 14.0,
                                          fontFamily: 'headingfont')),
                                  Text('Test',
                                      style: TextStyle(
                                          color: ReColors().appMainColor,
                                          fontSize: 14.0,
                                          fontFamily: 'titlefont'))
                                ],
                              )
                            ],
                          ),
                        )),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(5),
                  ),
                  Card(

                    child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(-0.6, -1),
                            end: Alignment(-1, -0),
                            colors: [Colors.white24, Colors.white],
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(4),
                          child: Column(
                            children: <Widget>[
                              Text('Manage Tickets',
                                  style: TextStyle(
                                      color: ReColors().appMainColor,
                                      fontSize: 17,
                                      fontFamily: 'headerfont')),
                              TextField(
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
                                        color: Color(0xff055e8e), width: 2.0),
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  labelText: 'Comments',
                                  labelStyle: TextStyle(
                                      color: Color(0xff055e8e),
                                      fontFamily: 'headingfont'),
                                ),
                                onChanged: (addresstext) {
                                  setState(() {});
                                },
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                                height: 50.0,
                                margin: EdgeInsets.all(10),
                                child: RaisedButton(
                                  onPressed: () {},
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(80.0)),
                                  padding: EdgeInsets.all(0.0),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            ReColors().appMainColor,
                                            ReColors().appMainColor
                                          ],
                                          begin: Alignment.centerLeft,
                                          end: Alignment.centerRight,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(30.0)),
                                    child: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 0.05 *
                                              MediaQuery.of(context)
                                                  .size
                                                  .width),
                                      constraints: BoxConstraints(
                                          maxWidth:
                                          MediaQuery.of(context).size.width,
                                          minHeight: 50.0),
                                      alignment: Alignment.center,
                                      child: Text(
                                        'Complete',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: ReColors().appTextWhiteColor,
                                            fontSize: 15,
                                            fontFamily: 'headerfont'),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        )),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(5),
                  ),
                  Card(

                    child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(-0.6, -1),
                            end: Alignment(-1, -0),
                            colors: [Colors.white24, Colors.white],
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(7.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(4),
                          child: Column(
                            children: <Widget>[
                              Text('Ticket History',
                                  style: TextStyle(
                                      color: ReColors().appMainColor,
                                      fontSize: 17,
                                      fontFamily: 'headerfont')),
                              Center(
                                child: DataTable(
                                  columns: [
                                    DataColumn(
                                        label: Text('Status',
                                            style: TextStyle(
                                                color: ReColors().appMainColor,
                                                fontSize: 14.0,
                                                fontFamily: 'headingfont'))),
                                    DataColumn(
                                        label: Text('Comments',
                                            style: TextStyle(
                                                color: ReColors().appMainColor,
                                                fontSize: 14.0,
                                                fontFamily: 'headingfont'))),
                                    DataColumn(
                                        label: Text('Date',
                                            style: TextStyle(
                                                color: ReColors().appMainColor,
                                                fontSize: 14.0,
                                                fontFamily: 'headingfont'))),
                                  ],
                                  rows: _rowList,
                                ),
                              ),
                            ],
                          ),
                        )),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(7.0),
                    ),
                    elevation: 5,
                    margin: EdgeInsets.all(5),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
