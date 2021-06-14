import 'package:art/Model/MaritalStatusModel.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableValues/ReStrings.dart';
import 'package:art/ReuseableWidget/CustomAppbarWidget.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:art/ScreensWithData/Menu/MainMenuPopup.dart';
import 'package:art/ReuseableWidget/CustomDropdown.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _userprofileState();
}

class _userprofileState extends State<UserProfile> {
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
          Title: 'User Profile',
        )
        ,
        body: profileView()));
  }

  Widget profileView() {
    return Container(
      // decoration: Gradientbg().getMenubg(),
      child: Column(
        children: <Widget>[
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(25),
                          bottomRight: Radius.circular(25)),
                      gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            ReColors().appMainColor,
                            Color.fromRGBO(0, 41, 102, 1)
                          ])),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(15),
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: ReColors().appMainColor,
                            child: ClipOval(
                              child: Image.asset(
                                '',
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                          child: Text(
                            'Ammad Grami',
                            style: TextStyle(color: Colors.white, fontSize: 25),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                          child: Text(
                            'Ammad Grami',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                          child: Text(
                            'CIO',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            // border: Border.all(color: Color(0xff940D5A)),
                            /*gradient: LinearGradient(
                          begin: Alignment(-0.6, -1),
                          end: Alignment(-1, -0),
                          colors: [ReColors().darkgreyColor,
                            ReColors().darkgreyColor,],
                        ),*/
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
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 8, 10, 0),
                                    child: Text(
                                      'Company Info',
                                      style: TextStyle(
                                          color: Colors.black, fontSize: 20),
                                    ),
                                  ),
                                )),
                                /*Expanded(
                                    child: Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 8, 10, 0),
                                    child: Icon(
                                      Icons.edit,
                                      size: 28,
                                      color: Colors.black,
                                    ),
                                  ),
                                ))*/
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                              child: Container(
                                height: 40,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Division :',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '-',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                /*decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  border: Border.all(width: 1.0, color: Colors.white70))*/
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
                                          'Branch :',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '-',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /*decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  border: Border.all(width: 1.0, color: Colors.white70)),*/
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
                                          'Unit :',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '-',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /*decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  border: Border.all(width: 1.0, color: Colors.white70)),*/
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
                                          'Department :',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '-',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /*decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  border: Border.all(width: 1.0, color: Colors.white70)),*/
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
                                          'Date of joining',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '-',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /*decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  border: Border.all(width: 1.0, color: Colors.white70)),*/
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
                                          'Duration :',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '-',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /*decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  border: Border.all(width: 1.0, color: Colors.white70)),*/
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
                                          'Designation :',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '-',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /*decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(20)),
                                  border: Border.all(width: 1.0, color: Colors.white70)),*/
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
                            // border: Border.all(color: Color(0xff940D5A)),
                            /*gradient: LinearGradient(
                          begin: Alignment(-0.6, -1),
                          end: Alignment(-1, -0),
                          colors: [ReColors().darkgreyColor,
                            ReColors().darkgreyColor,],
                        ),*/
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
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 8, 10, 0),
                                    child: Text('Personal Data',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20)),
                                  ),
                                )),
                                Expanded(
                                    child: Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 8, 10, 0),
                                    child: IconButton(
                                      color: Colors.black,
                                      icon: new Icon(Icons.edit),
                                      onPressed: () {
                                        _displayPersonalDataDialog(context,
                                            'marital_status', 'CNICExpiry');
                                      },
                                    ),
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
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Birth Day',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '-',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /*   decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  width: 1.0, color: Colors.white70)),*/
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
                                          'CNIC# ',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '-',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /* decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  width: 1.0, color: Colors.white70)),*/
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
                                          'Nationality',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '-',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /*decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  width: 1.0, color: Colors.white70)),*/
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
                                          'Marital Status',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '-',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /*decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  width: 1.0, color: Colors.white70)),*/
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
                                          'Gender',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '-',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /*decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  width: 1.0, color: Colors.white70)),*/
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
                                          'CNIC Expiry',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '-',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /*decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  width: 1.0, color: Colors.white70)),*/
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
                                          'Religion :',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '-',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /*decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  width: 1.0, color: Colors.white70)),*/
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
                            // border: Border.all(color: Color(0xff940D5A)),
                            /*gradient: LinearGradient(
                          begin: Alignment(-0.6, -1),
                          end: Alignment(-1, -0),
                          colors: [ReColors().darkgreyColor,
                            ReColors().darkgreyColor,],
                        ),*/
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
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 8, 10, 0),
                                    child: Text('Communication',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20)),
                                  ),
                                )),
                                Expanded(
                                    child: Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 8, 10, 0),
                                    child: IconButton(
                                      color: Colors.black,
                                      icon: new Icon(Icons.edit),
                                      onPressed: () {
                                        _displayCommunicationDialog(context,
                                            'marital_status', 'CNICExpiry', '');
                                      },
                                    ),
                                  ),
                                ))
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
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Email :',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '-',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /* decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  width: 1.0, color: Colors.white70)),*/
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
                                          'Mobile :',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '-',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /*decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  width: 1.0, color: Colors.white70)),*/
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
                                          'Phone :',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '-',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /* decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  width: 1.0, color: Colors.white70)),*/
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
                            // border: Border.all(color: Color(0xff940D5A)),
                            /*gradient: LinearGradient(
                          begin: Alignment(-0.6, -1),
                          end: Alignment(-1, -0),
                          colors: [ReColors().darkgreyColor,
                            ReColors().darkgreyColor,],
                        ),*/
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
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 8, 10, 0),
                                    child: Text('Address',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20)),
                                  ),
                                )),
                                Expanded(
                                    child: Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 8, 10, 0),
                                    child: IconButton(
                                      color: Colors.black,
                                      icon: new Icon(Icons.edit),
                                      onPressed: () {
                                        _displayAddressDialog(
                                            context, 'marital_status');
                                      },
                                    ),
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
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Residence :',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '-',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /* decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  width: 1.0, color: Colors.white70)),*/
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
                            // border: Border.all(color: Color(0xff940D5A)),
                            /*gradient: LinearGradient(
                          begin: Alignment(-0.6, -1),
                          end: Alignment(-1, -0),
                          colors: [ReColors().darkgreyColor,
                            ReColors().darkgreyColor,],
                        ),*/
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
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 8, 10, 0),
                                    child: Text('Education',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20)),
                                  ),
                                )),
                                Expanded(
                                    child: Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 8, 10, 0),
                                    child: IconButton(
                                      color: Colors.black,
                                      icon: new Icon(Icons.edit),
                                      onPressed: () {
                                        _displayEducationDialog(
                                            context, 'marital_status');
                                      },
                                    ),
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
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Qualification :',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'B.S',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /* decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  width: 1.0, color: Colors.white70)),*/
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
                            // border: Border.all(color: Color(0xff940D5A)),
                            /*gradient: LinearGradient(
                          begin: Alignment(-0.6, -1),
                          end: Alignment(-1, -0),
                          colors: [ReColors().darkgreyColor,
                            ReColors().darkgreyColor,],
                        ),*/
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
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 8, 10, 0),
                                    child: Text('Benefits',
                                        style: TextStyle(
                                            color: Colors.black, fontSize: 20)),
                                  ),
                                )),
                                /*Expanded(
                                    child: Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 8, 10, 0),
                                    child: Icon(
                                      Icons.edit,
                                      size: 28,
                                      color: Colors.black,
                                    ),
                                  ),
                                )),*/
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
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'EOBI#',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '-',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /* decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  width: 1.0, color: Colors.white70)),*/
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
                                          'EOBI Date#',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '-',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /* decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  width: 1.0, color: Colors.white70)),*/
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
                                          'SESSI#',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '-',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /* decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  width: 1.0, color: Colors.white70)),*/
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
                                          'SESSI Date#',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '-',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                /* decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20)),
                              border: Border.all(
                                  width: 1.0, color: Colors.white70)),*/
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

  String codeDialog;
  String valueText;
  TextEditingController emailController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController adressController = TextEditingController();
  MaritalStatus _worklistnameModel = MaritalStatus();
  final List<MaritalStatus> _worklistnameModelList = [
    MaritalStatus(status: 'Single'),
    MaritalStatus(status: 'Divorced'),
    MaritalStatus(status: 'Married'),
  ];
  List<DropdownMenuItem<MaritalStatus>> _worklistnameModelDropdownList;

  List<DropdownMenuItem<MaritalStatus>> _buildworklistnameModelDropdown(
      List worklistnameModelList) {
    List<DropdownMenuItem<MaritalStatus>> items = List();
    for (MaritalStatus WorklistnameModel in worklistnameModelList) {
      items.add(DropdownMenuItem(
        value: WorklistnameModel,
        child: Text(WorklistnameModel.status),
      ));
    }
    return items;
  }

  _onChangeworklistnameModelDropdown(MaritalStatus worklistnameModel) {
    setState(() {
      _worklistnameModel = worklistnameModel;
    });
  }

  double _width;

  String _setendDate, _setDate;

  String _hour, _minute, _time;

  String dateTime;

  DateTime selectedDate = DateTime.now();
  DateTime endselectedDate = DateTime.now();

  TextEditingController _dateController = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: ReColors().appMainColor,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: ReColors().appMainColor,
              ),
              dialogBackgroundColor: ReColors().appTextWhiteColor,
            ),
            child: child,
          );
        },
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<void> _displayCommunicationDialog(
      BuildContext context, email, phone, mobile) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Communication',
              textAlign: TextAlign.center,
            ),
            content: SingleChildScrollView(
              child: Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.all(2),
                          child: TextField(
                            controller: emailController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                            ),
                            onChanged: (emailtext) {
                              setState(() {
                                email = emailtext;
                                //you can access nameController in its scope to get
                                // the value of text entered as shown below
                                //UserName = nameController.text;
                              });
                            },
                          )),
                      Container(
                          margin: EdgeInsets.all(2),
                          child: TextField(
                            controller: mobileController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Mobile',
                            ),
                            onChanged: (mobiletext) {
                              setState(() {
                                mobile = mobiletext;
                                //you can access nameController in its scope to get
                                // the value of text entered as shown below
                                //UserName = nameController.text;
                              });
                            },
                          )),
                      Container(
                          margin: EdgeInsets.all(2),
                          child: TextField(
                            controller: phoneController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Phone',
                            ),
                            onChanged: (phonetext) {
                              setState(() {
                                phone = phonetext;
                                //you can access nameController in its scope to get
                                // the value of text entered as shown below
                                //UserName = nameController.text;
                              });
                            },
                          )),
                    ],
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              Container(
                child: Center(
                  child: FlatButton(
                    color: ReColors().appMainColor,
                    textColor: Colors.white,
                    child: Text('Update'),
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                  ),
                ),
              ),
            ],
          );
        });
  }

  Future<void> _displayPersonalDataDialog(BuildContext context, String marital_status, String CNICExpiry) async {
    _worklistnameModelDropdownList =
        _buildworklistnameModelDropdown(_worklistnameModelList);
    _worklistnameModel = _worklistnameModelList[0];
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Personal Data',
              textAlign: TextAlign.center,
            ),
            content: SingleChildScrollView(
              child: Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.all(2),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20.0, vertical: 10.0),
                            child: CustomDropdown(
                              dropdownMenuItemList:
                                  _worklistnameModelDropdownList,
                              onChanged: _onChangeworklistnameModelDropdown,
                              value: _worklistnameModel,
                              isEnabled: true,
                              color: ReColors().appMainColor,
                            ),
                          )),
                      InkWell(
                        onTap: () {
                          _selectDate(context);
                        },
                        child: Container(
                            width: 320,
                            padding: EdgeInsets.all(10.0),
                            child: TextFormField(
                              textAlign: TextAlign.center,
                              enabled: false,
                              keyboardType: TextInputType.text,
                              controller: _dateController,
                              onSaved: (String val) {
                                _setDate = val;
                              },
                              autocorrect: true,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.calendar_today_sharp,
                                  color: ReColors().appMainColor,
                                ),
                                hintText: appstring().startdate,
                                hintStyle:
                                    TextStyle(color: ReColors().appMainColor),
                                fillColor: Colors.white70,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              Container(
                child: Center(
                  child: FlatButton(
                    color: ReColors().appMainColor,
                    textColor: Colors.white,
                    child: Text('Update'),
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                  ),
                ),
              ),
            ],
          );
        });
  }

  Future<void> _displayAddressDialog(BuildContext context, address) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Address',
              textAlign: TextAlign.center,
            ),
            content: SingleChildScrollView(
              child: Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.all(2),
                          child: TextField(
                            controller: adressController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                            ),
                            onChanged: (addresstext) {
                              setState(() {
                                address = addresstext;
                                //you can access nameController in its scope to get
                                // the value of text entered as shown below
                                //UserName = nameController.text;
                              });
                            },
                          )),
                    ],
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              Container(
                child: Center(
                  child: FlatButton(
                    color: ReColors().appMainColor,
                    textColor: Colors.white,
                    child: Text('Update'),
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                  ),
                ),
              ),
            ],
          );
        });
  }

  Future<void> _displayEducationDialog(BuildContext context, education) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Education',
              textAlign: TextAlign.center,
            ),
            content: SingleChildScrollView(
              child: Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.all(2),
                          child: TextField(
                            controller: educationController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Email',
                            ),
                            onChanged: (educatiotext) {
                              setState(() {
                                education = educatiotext;
                                //you can access nameController in its scope to get
                                // the value of text entered as shown below
                                //UserName = nameController.text;
                              });
                            },
                          )),
                    ],
                  ),
                ),
              ),
            ),
            actions: <Widget>[
              Container(
                child: Center(
                  child: FlatButton(
                    color: ReColors().appMainColor,
                    textColor: Colors.white,
                    child: Text('Update'),
                    onPressed: () {
                      setState(() {
                        Navigator.pop(context);
                      });
                    },
                  ),
                ),
              ),
            ],
          );
        });
  }
}

/**/
