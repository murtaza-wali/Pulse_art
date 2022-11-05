import 'dart:convert';
import 'dart:io';

import 'package:art/Error/Error.dart';
import 'package:art/InternetConnection/Offline.dart';
import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/Model/MaritalStatusModel.dart';
import 'package:art/Model/e_s_s_model.dart';
import 'package:art/Notification/NotificationParsingData.dart';
import 'package:art/ParsingJSON/GetJSONMethod.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableValues/ReStrings.dart';
import 'package:art/ReuseableWidget/CustomAppbarWidget.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:art/ScreensWithData/Menu/MainMenuPopup.dart';
import 'package:art/ReuseableWidget/CustomDropdown.dart';
import 'package:convert/convert.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class UserProfile extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserprofileState();
}

class _UserprofileState extends State<UserProfile> {
  List<Essitems> profilelist;
  int getID;
  var hexDeocde;

  @override
  void initState() {
    super.initState();

    MySharedPreferences.instance
        .getIntValue("UserId")
        .then((value) => setState(() {
              getID = value;
              GetJSON().getProfileData(context, getID).then((users) {
                setState(() {
                  profilelist = users;
                  print('employee code user ${profilelist[0].employeecode}');
                  print('employee duration ${profilelist[0].duration}');
                  postNotification()
                      .PostEmployeeImage(profilelist[0].employeecode)
                      .then((value) {
                    Map<String, dynamic> user = jsonDecode(value.body);
                    hexDeocde = hex.decode(user['epic']);
                  });
                });
              });
            }));
  }

  Future<dynamic> _refreshMenu() async {
    return await GetJSON().getProfileData(context, getID);
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
          Title: 'User Profile',
          refreshonPressed: () {
            _refreshMenu().then((list) => setState(() {
                  profilelist = list;
                }));
          },
        ),
        body: ReuseOffline().getoffline(FutureBuilder<List<Essitems>>(
          future: GetJSON().getProfileData(context, getID),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              profilelist = snapshot.data;
              return profileView(profilelist);
            } else if (snapshot.hasError) {
              if (snapshot.error is HttpException) {
                HttpException httpException = snapshot.error as HttpException;
                return showError(
                    'An http error occurred.Page not found. Please try again.',
                    Icons.error);
              }
              if (snapshot.error is NoInternetException) {
                NoInternetException noInternetException =
                    snapshot.error as NoInternetException;
                return showError('Please check your internet connection',
                    Icons.signal_wifi_connected_no_internet_4_sharp);
              }
              if (snapshot.error is NoServiceFoundException) {
                NoServiceFoundException noServiceFoundException =
                    snapshot.error as NoServiceFoundException;
                return showError('Server Error.', Icons.error);
              }
              if (snapshot.error is InvalidFormatException) {
                InvalidFormatException invalidFormatException =
                    snapshot.error as InvalidFormatException;
                return showError(
                    'There is a problem with your request.', Icons.error);
              }
              if (snapshot.error is SocketException) {
                SocketException socketException =
                    snapshot.error as SocketException;
                print('Socket checking: ${socketException.message}');
                return showError('Please check your internet connection',
                    Icons.signal_wifi_connected_no_internet_4_sharp);
              } else {
                UnknownException unknownException =
                    snapshot.error as UnknownException;
                return showError('An Unknown error occurred.', Icons.error);
              }
            }
            return Center(
                child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(ReColors().appMainColor),
            ));
          },
        ))));
  }

  Widget profileView(profilelist) {
    return Container(
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
                              child: hexDeocde == null
                                  ? Center(
                                      child: CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          ReColors().darkgreyColor),
                                    ))
                                  : Image.memory(
                                      hexDeocde,
                                      height: 120,
                                      width: 120,
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
                            '${profilelist[0].employeename}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontFamily: 'headerfont'),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
                          child: Text(
                            '${profilelist[0].relation == null ? '' : profilelist[0].relation} ${profilelist[0].fathername == null ? '' : profilelist[0].fathername}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'headingfont'),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
                          child: Text(
                            '${profilelist[0].employeecode == null ? '' : profilelist[0].employeecode}',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontFamily: 'headingfont'),
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
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 8, 10, 0),
                                    child: Text(
                                      'Company Info',
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
                              padding: const EdgeInsets.fromLTRB(20, 25, 20, 4),
                              child: Container(
                                height: 40,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Division :',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'headingfont'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '${profilelist[0].division == null ? '' : profilelist[0].division}',
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
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Branch :',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'headingfont'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '${profilelist[0].branchname == null ? '' : profilelist[0].branchname}',
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
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Unit :',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'headingfont'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '${profilelist[0].companyname == null ? '' : profilelist[0].companyname}',
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
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Department :',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'headingfont'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '${profilelist[0].departmentName == null ? '' : profilelist[0].departmentName}',
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
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Date of joining',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'headingfont'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '${(profilelist[0].dateofjoining) == null ? '' : (profilelist[0].dateofjoining)}',
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
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Duration :',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'headingfont'),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            '${profilelist[0].duration == null ? '' : profilelist[0].duration}',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontFamily: 'titlefont'),
                                          ),
                                        ),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Designation :',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'headingfont'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '${profilelist[0].designationName == null ? '' : profilelist[0].designationName}',
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
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 8, 10, 0),
                                        child: Text('Personal Data',
                                            textAlign: TextAlign.left,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontFamily: 'headerfont')),
                                      ),
                                    )),
                                Expanded(
                                    flex: 3,
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 8, 10, 0),
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
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Birth Day',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'headingfont'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '${(profilelist[0].dateofbirth) == null ? '' : (profilelist[0].dateofbirth)}',
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
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'CNIC# ',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'headingfont'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '${profilelist[0].nic == null ? '' : profilelist[0].nic}',
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
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Nationality',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'headingfont'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '${profilelist[0].nationality == null ? '' : profilelist[0].nationality}',
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
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Marital Status',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'headingfont'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '${profilelist[0].meritalstatus == null ? '' : profilelist[0].meritalstatus}',
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
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Gender',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'headingfont'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '${profilelist[0].gender == null ? '' : profilelist[0].gender}',
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
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'CNIC Expiry',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'headingfont'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '${(profilelist[0].cnicexpire) == null ? '' : (profilelist[0].cnicexpire)}',
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
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Religion :',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'headingfont'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '${profilelist[0].religion == null ? '' : profilelist[0].religion}',
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
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 8, 10, 0),
                                        child: Text('Communication',
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontFamily: 'headerfont')),
                                      ),
                                    )),
                                Expanded(
                                    flex: 3,
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            10, 8, 10, 0),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Email :',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'headingfont'),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              '${profilelist[0].email == null ? '' : profilelist[0].email}',
                                              maxLines: 2,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'titlefont'),
                                            )),
                                      ),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Mobile :',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'headingfont'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '${profilelist[0].mobile == null ? '' : profilelist[0].mobile}',
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
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Phone :',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'headingfont'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '${profilelist[0].phone == null ? '' : profilelist[0].phone}',
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
                                    child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 8, 10, 0),
                                    child: Text('Address',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontFamily: 'headerfont')),
                                  ),
                                )),
                                Expanded(
                                    child: Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 8, 10, 0),
                                  ),
                                )),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                              child: Container(
                                height: 70,
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Residence :',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'headingfont'),
                                        ),
                                      ),
                                      Expanded(
                                          child: Text(
                                              '${profilelist[0].address == null ? '' : profilelist[0].address}',
                                              maxLines: 6,
                                              textAlign: TextAlign.right,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'titlefont'))),
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
                                    child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 8, 10, 0),
                                    child: Text('Education',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontFamily: 'headerfont')),
                                  ),
                                )),
                                Expanded(
                                    child: Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 8, 10, 0),
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
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Qualification :',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'headingfont'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '${profilelist[0].qualification == null ? '' : profilelist[0].qualification}',
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
                      /* SizedBox(
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
                                    child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 8, 10, 0),
                                    child: Text('Benefits',
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
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'EOBI#',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'headingfont'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '${profilelist[0].eobino == null ? '' : profilelist[0].eobino}',
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
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'EOBI Date#',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'headingfont'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '${profilelist[0].eobidate == null ? '' : (profilelist[0].eobidate)}',
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
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'SESSI#',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'headingfont'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '${profilelist[0].sessino == null ? '' : profilelist[0].sessino}',
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
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'SESSI Date#',
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'headingfont'),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '${profilelist[0].sessidate == null ? '' : (profilelist[0].sessidate)}',
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
                      ),*/
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

  String getmonthName(var mon) {
    List months = [
      'Jan',
      'Feb',
      'Mar',
      'April',
      'May',
      'Jun',
      'July',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec'
    ];
    /*  var someDateTime = new DateTime.now();
    mon = someDateTime.month;*/
    return months[mon - 1];
  }

  Future<void> _displayPersonalDataDialog(
      BuildContext context, String maritalstatus, String cnicexpiry) async {
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
                              hint: '',
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

Widget showError(String message, key) {
  return Column(
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
              style: TextStyle(fontSize: 18),
            )
          ],
        ),
      ),
    ],
  );
}
