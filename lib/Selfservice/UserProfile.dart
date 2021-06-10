import 'package:art/Menu/MainMenuPopup.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/GradientBG.dart';
import 'package:art/ReuseableWidget/appbar.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _userprofileState();
}

class _userprofileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: new ReusableWidgets().getAppBar('User Profile'),
        body: profileView());
  }

  Widget profileView() {
    return Container(
      // decoration: Gradientbg().getMenubg(),
      child: Column(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                  ReColors().appMainColor,
                  Color.fromRGBO(0, 41, 102, 1)
                ])),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      MainMenuPopUp()),
                            );
                          },
                          child: Container(
                              height: 50,
                              width: 50,
                              child: Icon(
                                Icons.arrow_back,
                                size: 28,
                                color: Colors.white,
                              )),
                        ),
                      ),
                      Text(
                        'User Profile',
                        style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Container(height: 24, width: 24)
                    ],
                  ),
                ),
              ],
            ),
          ),
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
                                Expanded(
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
                                )),
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
                                    child: Icon(
                                      Icons.edit,
                                      size: 28,
                                      color: Colors.black,
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
                                    child: Icon(
                                      Icons.edit,
                                      size: 28,
                                      color: Colors.black,
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
                                    child: Icon(
                                      Icons.edit,
                                      size: 28,
                                      color: Colors.black,
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
                                    child: Icon(
                                      Icons.edit,
                                      size: 28,
                                      color: Colors.black,
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
                                Expanded(
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
}

/**/
