import 'dart:io';

import 'package:art/Animation/SlideRoute.dart';
import 'package:art/InternetConnection/Offline.dart';
import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/Model/DetailCards.dart';
import 'package:art/Model/systemAttachedModel.dart';
import 'package:art/ParsingJSON/GetJSONMethod.dart';
import 'package:art/ParsingJSON/PostJSONMethod.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableValues/ReStrings.dart';
import 'package:art/ReuseableWidget/CustomAppbarWithImage.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:art/ScreensWithData/EApprovalScreens/TransactionLineScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_flip_builder/page_flip_builder.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:art/Error/Error.dart';

import 'viewdocuments/viewpdfScreen.dart';
import 'EapprovalFirstScreen.dart';
import 'viewdocuments/viewImageScreen.dart';


//Eapproval second screen
class TransactionDetails extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _TransactionDetailsstate();
}

class _TransactionDetailsstate extends State<TransactionDetails>
    with SingleTickerProviderStateMixin {
  final pageFlipKey = GlobalKey<PageFlipBuilderState>();
  List<Detailcardsitem> notifylist = [];
  TextEditingController _controllers = TextEditingController();
  bool editVisibility = false;
  String dep_name, fromUser, des_name, frd_remarks, toUsername;
  String doc_no;
  int GetnotifyID;
  int getID, typeid;
  int h_id;
  ProgressDialog progressDialog;
  bool _isloading = false;
  List<SystemAttachedModelitem> systemgeneratedList = [];
  List<SystemAttachedModelitem> attachedDocumentList = [];
  int fileId;
  TabController _controller;
  bool visible1 = true;
  bool visible2 = true;
  bool visible3 = true;
  bool visible4 = true;
  bool visible5 = true;
  bool visible6 = true;
  bool visible7 = true;
  bool visible8 = true;
  bool visible9 = true;
  bool visible10 = true;

  //String prompt
  String prompt1,
      prompt2,
      prompt3,
      prompt4,
      prompt5,
      prompt6,
      prompt7,
      prompt8,
      prompt9,
      prompt10;

  //String value
  String value1,
      value2,
      value3,
      value4,
      value5,
      value6,
      value7,
      value8,
      value9,
      value10;

  @override
  void initState() {
    super.initState();
    _controller = TabController(
      length: 2,
      initialIndex: 0,
      vsync: this,
    );
    progressDialog = new ProgressDialog(context);
    MySharedPreferences.instance
        .getStringValue("fromUserName")
        .then((value) => setState(() {
              fromUser = value;
              if (fromUser == null) {
                fromUser = '-';
              }
              print(fromUser);
            }));
    MySharedPreferences.instance
        .getStringValue("toUserName")
        .then((value) => setState(() {
              toUsername = value;
              if (toUsername == null) {
                toUsername = '-';
              }
              print(toUsername);
            }));
    MySharedPreferences.instance
        .getIntValue("notificationID")
        .then((value) => setState(() {
              GetnotifyID = value;
              print('GetnotifyID23423 ${GetnotifyID}');
              GetJSON().getTrasactionByNotifyId(GetnotifyID).then((users) {
                setState(() {
                  notifylist = users;
                  if (notifylist.length == 0) {
                    return showError(
                        'No data found', Icons.assignment_late_outlined);
                  }
                });
              });
              GetJSON()
                  .getsystemgeneratedItem(GetnotifyID, 1)
                  .then((sysGenList) {
                setState(() {
                  systemgeneratedList = sysGenList;
                  if (systemgeneratedList.length == 0) {
                    return showError(
                        'No data found', Icons.assignment_late_outlined);
                  }
                });
              });
            }));
    MySharedPreferences.instance
        .getStringValue("department")
        .then((value) => setState(() {
              dep_name = value;
              if (dep_name == null) {
                dep_name = '-';
              }
              print('dep_name: ${dep_name}');
            }));
    MySharedPreferences.instance
        .getStringValue("description")
        .then((value) => setState(() {
              des_name = value;
              print(des_name);
            }));
    MySharedPreferences.instance
        .getStringValue("forwarder_remarks")
        .then((value) => setState(() {
              frd_remarks = value;
              print(frd_remarks);
            }));
    MySharedPreferences.instance
        .getStringValue("doc_number")
        .then((value) => setState(() {
              doc_no = value;
              print(doc_no);
            }));
    MySharedPreferences.instance
        .getIntValue("UserId")
        .then((value) => setState(() {
              getID = value;
              print(getID);
            }));
    MySharedPreferences.instance
        .getIntValue("typeID")
        .then((value) => setState(() {
              typeid = value;
              print('TYPE ID${typeid}');
            }));
    MySharedPreferences.instance
        .getIntValue("hID")
        .then((value) => setState(() {
              h_id = value;
              print(h_id);
            }));
    // PROMPT
    MySharedPreferences.instance
        .getStringValue("attribute1_prompt")
        .then((value) => setState(() {
              prompt1 = value;
              print(prompt1);
              if (prompt1 == 'null') {
                visible1 = false;
              }
            }));
    MySharedPreferences.instance
        .getStringValue("attribute2_prompt")
        .then((value) => setState(() {
              prompt2 = value;
              print(prompt2);
              if (prompt2 == 'null') {
                visible2 = false;
              }
            }));
    MySharedPreferences.instance
        .getStringValue("attribute3_prompt")
        .then((value) => setState(() {
              prompt3 = value;
              print(prompt3);
              if (prompt3 == 'null') {
                visible3 = false;
              }
            }));
    MySharedPreferences.instance
        .getStringValue("attribute4_prompt")
        .then((value) => setState(() {
              prompt4 = value;
              print(prompt4);
              if (prompt4 == 'null') {
                visible4 = false;
              }
            }));
    MySharedPreferences.instance
        .getStringValue("attribute5_prompt")
        .then((value) => setState(() {
              prompt5 = value;
              print(prompt5);
              if (prompt5 == 'null') {
                visible5 = false;
              }
            }));
    MySharedPreferences.instance
        .getStringValue("attribute6_prompt")
        .then((value) => setState(() {
              prompt6 = value;
              print(prompt6);
              if (prompt6 == 'null') {
                visible6 = false;
              }
            }));
    MySharedPreferences.instance
        .getStringValue("attribute7_prompt")
        .then((value) => setState(() {
              prompt7 = value;
              print(prompt7);
              if (prompt7 == 'null') {
                visible7 = false;
              }
            }));
    MySharedPreferences.instance
        .getStringValue("attribute8_prompt")
        .then((value) => setState(() {
              prompt8 = value;
              print(prompt8);
              if (prompt8 == 'null') {
                visible8 = false;
              }
            }));
    MySharedPreferences.instance
        .getStringValue("attribute9_prompt")
        .then((value) => setState(() {
              prompt9 = value;
              print(prompt9);
              if (prompt9 == 'null') {
                visible9 = false;
              }
            }));
    MySharedPreferences.instance
        .getStringValue("attribute10_prompt")
        .then((value) => setState(() {
              prompt10 = value;
              print(prompt10);
              if (prompt10 == 'null') {
                visible10 = false;
              }
            }));

    //Value
    MySharedPreferences.instance
        .getStringValue("attribute1_Value")
        .then((value) => setState(() {
              value1 = value;
              print(value1);
              if (value1 == 'null') {
                value1 = '-';
              }
            }));
    MySharedPreferences.instance
        .getStringValue("attribute2_Value")
        .then((value) => setState(() {
              value2 = value;
              print(value2);
              if (value2 == 'null') {
                value2 = '-';
              }
            }));
    MySharedPreferences.instance
        .getStringValue("attribute3_Value")
        .then((value) => setState(() {
              value3 = value;
              print(value3);
              if (value3 == 'null') {
                value3 = '-';
              }
            }));
    MySharedPreferences.instance
        .getStringValue("attribute4_Value")
        .then((value) => setState(() {
              value4 = value;
              print(value4);
              if (value4 == 'null') {
                value4 = '-';
              }
            }));
    MySharedPreferences.instance
        .getStringValue("attribute5_Value")
        .then((value) => setState(() {
              value5 = value;
              print(value5);
              if (value5 == 'null') {
                value5 = '-';
              }
            }));
    MySharedPreferences.instance
        .getStringValue("attribute6_Value")
        .then((value) => setState(() {
              value6 = value;
              print(value6);
              if (value6 == 'null') {
                value6 = '-';
              }
            }));
    MySharedPreferences.instance
        .getStringValue("attribute7_Value")
        .then((value) => setState(() {
              value7 = value;
              print(value7);
              if (value7 == 'null') {
                value7 = '-';
              }
            }));
    MySharedPreferences.instance
        .getStringValue("attribute8_Value")
        .then((value) => setState(() {
              value8 = value;
              print(value8);
              if (value8 == 'null') {
                value8 = '-';
              }
            }));
    MySharedPreferences.instance
        .getStringValue("attribute9_Value")
        .then((value) => setState(() {
              value9 = value;
              print(value9);
              if (value9 == 'null') {
                value9 = '-';
              }
            }));
    MySharedPreferences.instance
        .getStringValue("attribute10_Value")
        .then((value) => setState(() {
              value10 = value;
              if (value10 == 'null') {
                value10 = '-';
              }
              print(value10);
            }));
  }

  Future<dynamic> _refreshMenu() async {
    return await GetJSON().getTrasactionByNotifyId(GetnotifyID);
  }

  Widget build(BuildContext context) {
    return Willpopwidget().getWillScope(Scaffold(
        appBar: new CustomAppBarImage(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => EapprovalPage()),
            );
          },
          Title: 'Transaction Details',
          image_bar: 'assets/images/eapprovals.png',
          refreshonPressed: () {
            _refreshMenu().then((list) => setState(() {
                  notifylist = list;
                  print(notifylist.length);
                }));
          },
        ),
        body: ReuseOffline().getoffline(transactionDetails())));
  }

  // transaction details

  Widget transactionDetails() {
    return ListView(
      shrinkWrap: true,
      children: [
        Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.all(10),
                color: ReColors().appMainColor,
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Icon(
                        Icons.folder,
                        color: Colors.white,
                        size: 40,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Expanded(
                          child: Text(
                        '${des_name}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontFamily: 'titlefont',
                        ),
                      ))
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(10),
                child: Container(
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    'From',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontFamily: 'headingfont'),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    '${fromUser}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontFamily: 'headingfont'),
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
                        padding: const EdgeInsets.all(10),
                        child: Container(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    'To',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.grey,
                                        fontFamily: 'headingfont'),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Text(
                                    '${toUsername}',
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Colors.black,
                                        fontFamily: 'headingfont'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      //PROMPT 1
                      Visibility(
                          visible: visible1,
                          child: Column(
                            children: [
                              Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            '${prompt1}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                                fontFamily: 'headingfont'),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              '${value1}',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontFamily: 'headingfont'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      // PROMPT 2

                      Visibility(
                          visible: visible2,
                          child: Column(
                            children: [
                              Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            '${prompt2}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                                fontFamily: 'headingfont'),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              '${value2}',
                                              textAlign: TextAlign.right,
                                              maxLines: 3,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontFamily: 'headingfont'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      // PROMPT 3

                      Visibility(
                        child: Column(
                          children: [
                            Divider(
                              height: 1,
                              color: Colors.grey,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Container(
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          '${prompt3}',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                              fontFamily: 'headingfont'),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            '${value3}',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.black,
                                                fontFamily: 'headingfont'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        visible: visible3,
                      ),

                      Visibility(
                          visible: visible4,
                          child: Column(
                            children: [
                              Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            '${prompt4}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                                fontFamily: 'headingfont'),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              '${value4}',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontFamily: 'headingfont'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),

                      Visibility(
                          visible: visible5,
                          child: Column(
                            children: [
                              Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            '${prompt5}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                                fontFamily: 'headingfont'),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              '${value5}',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontFamily: 'headingfont'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),

                      Visibility(
                          visible: visible6,
                          child: Column(
                            children: [
                              Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            '${prompt6}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                                fontFamily: 'headingfont'),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              '${value6}',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontFamily: 'headingfont'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                      //PROMPT 7

                      Visibility(
                          visible: visible7,
                          child: Column(
                            children: [
                              Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            '${prompt7}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                                fontFamily: 'headingfont'),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              '${value7}',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontFamily: 'headingfont'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),

                      Visibility(
                          visible: visible8,
                          child: Column(
                            children: [
                              Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            '${prompt8}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                                fontFamily: 'headingfont'),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              '${value8}',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontFamily: 'headingfont'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),

                      Visibility(
                          visible: visible9,
                          child: Column(
                            children: [
                              Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            '${prompt9}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                                fontFamily: 'headingfont'),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              '${value9}',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontFamily: 'headingfont'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),

                      Visibility(
                          visible: visible10,
                          child: Column(
                            children: [
                              Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            '${prompt10}',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                                fontFamily: 'headingfont'),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              '${value10}',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontFamily: 'headingfont'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            SlideLeftRoute(
                              page: TransactionLine(),
                            ));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // icon
                          Row(
                            children: [
                              Icon(
                                Icons.assignment,
                                color: ReColors().appMainColor,
                                size: 25,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              //text
                              Text(
                                'Type Lines',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontFamily: 'headingfont',
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: ReColors().appMainColor,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.history,
                              color: ReColors().appMainColor,
                              size: 25,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              'Action History',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontFamily: 'headingfont',
                              ),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {
                            /* Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      TrasactionLineScreen()),
                            );*/
                          },
                          child: Icon(
                            Icons.arrow_forward_ios,
                            color: ReColors().appMainColor,
                            size: 20,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: widgetContainer(),
        )
      ],
    );
  }

  Widget DetailsWidget() {
    return Padding(
      padding: EdgeInsets.all(5),
      child: Column(
        children: <Widget>[
          Row(
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 3, 0, 3),
                    child: Text(
                      '${fromUser}',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontFamily: 'headingfont',
                      ),
                    ),
                  )),
              Expanded(
                  child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
                  child: Text(
                    '${doc_no}',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'titlefont',
                    ),
                  ),
                ),
              ))
            ],
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 3, 0, 3),
                child: Text(
                  '${dep_name}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'titlefont',
                  ),
                ),
              )),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 3, 0, 3),
                child: Text(
                  '${des_name}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'titlefont',
                  ),
                ),
              )),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 3, 0, 3),
                child: Text(
                  '${frd_remarks}',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'titlefont',
                  ),
                ),
              ))
        ],
      ),
    );
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
   /* var someDateTime = new DateTime.now();
    mon = someDateTime.month;
    print(months[mon - 1]);*/
    return months[mon - 1];
  }

  Widget widgetContainer() {
    return Column(
      children: <Widget>[
        Container(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: appstring().remark,
                labelStyle: TextStyle(color: ReColors().appMainColor),
                fillColor: ReColors().appMainColor,
                enabledBorder: new OutlineInputBorder(
                  borderRadius: new BorderRadius.circular(5.0),
                  borderSide: BorderSide(color: ReColors().appMainColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: ReColors().appMainColor, width: 2.0),
                  borderRadius: BorderRadius.circular(5.0),
                ),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: ReColors().appMainColor)),
              ),
              maxLines: 1,
              controller: _controllers,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(10),
          child: RaisedButton(
              onPressed: () {
                showModalBottomSheet(
                    backgroundColor: Colors.transparent,
                    context: context,
                    isScrollControlled: true,
                    builder: (context) {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: StatefulBuilder(builder:
                              (BuildContext context, StateSetter setState) {
                            return Container(
                                width: MediaQuery.of(context).size.width,
                                height: 282,
                                decoration: BoxDecoration(
                                  // color: colorPrimary,
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(18.0),
                                    topRight: const Radius.circular(18.0),
                                  ),
                                ),
                                child: DefaultTabController(
                                  length: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 12),
                                    child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          TabBar(
                                            onTap: (index) {
                                              //your currently selected index
                                              print('show me the index${index}');
                                              if (index == 0) {
                                                GetJSON()
                                                    .getsystemgeneratedItem(
                                                        GetnotifyID, 1)
                                                    .then((sysGenList) {
                                                  if (mounted) {
                                                    setState(() {
                                                      systemgeneratedList =
                                                          sysGenList;
                                                      if (systemgeneratedList
                                                              .length ==
                                                          0) {
                                                        return showError(
                                                            'No data found',
                                                            Icons
                                                                .assignment_late_outlined);
                                                      }
                                                    });
                                                  }
                                                });
                                              }
                                              else if (index == 1) {
                                                GetJSON().getsystemgeneratedItem(GetnotifyID, 2).then((sysGenList) {
                                                  if (mounted) {
                                                    setState(() {
                                                      attachedDocumentList = sysGenList;
                                                      if (attachedDocumentList.length == 0) {
                                                        return showError('No data found', Icons.assignment_late_outlined);
                                                      }
                                                    });
                                                  }
                                                });
                                              }
                                            },
                                            tabs: [
                                              Tab(
                                                child: Text(
                                                  'System Generated',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                              Tab(
                                                child: Text(
                                                  'Attached Documents',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            ],
                                          ),
                                          Expanded(
                                            child: TabBarView(
                                              children: <Widget>[
                                                //system generated .......
                                                FutureBuilder<List<SystemAttachedModelitem>>(
                                                  future: GetJSON().getsystemgeneratedItem(GetnotifyID, 1),
                                                  builder: (context, snapshot) {
                                                    print('Connection State: ${snapshot.connectionState}');
                                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                                      return Center(
                                                        child: Container(
                                                          height: 40,
                                                          width: 40,
                                                          margin:
                                                              EdgeInsets.all(5),
                                                          child:
                                                              CircularProgressIndicator(
                                                            strokeWidth: 2.0,
                                                            valueColor:
                                                                AlwaysStoppedAnimation(
                                                                    ReColors()
                                                                        .appMainColor),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    if (snapshot.hasError) {
                                                      if (snapshot.error
                                                          is HttpException) {
                                                        return showError(
                                                            'An http error occurred. Page not found. Please try again.',
                                                            Icons.error);
                                                      }
                                                      if (snapshot.error
                                                          is NoInternetException) {
                                                        return showError(
                                                            'Please check your internet connection',
                                                            Icons
                                                                .signal_wifi_connected_no_internet_4_sharp);
                                                      }
                                                      if (snapshot.error
                                                          is NoServiceFoundException) {
                                                        return showError(
                                                            'Server Error.',
                                                            Icons.error);
                                                      }
                                                      if (snapshot.error
                                                          is InvalidFormatException) {
                                                        return showError(
                                                            'There is a problem with your request.',
                                                            Icons.error);
                                                      }
                                                      if (snapshot.error is SocketException) {
                                                        SocketException socketException = snapshot.error as SocketException;
                                                        return showError('Please check your internet connection', Icons.signal_wifi_connected_no_internet_4_sharp);
                                                      } else {
                                                        return showError('An Unknown error occurred.', Icons.error);
                                                      }
                                                    } else {
                                                      print(
                                                          'len data: ${systemgeneratedList.length}');
                                                      print(
                                                          'Snapshot data: ${snapshot.data.length}');
                                                      systemgeneratedList =
                                                          snapshot.data;
                                                      if (snapshot
                                                              .data.length ==
                                                          0) {
                                                        return showError(
                                                            'No data',
                                                            Icons
                                                                .assignment_late_outlined);
                                                      } else {
                                                        print(
                                                            'DataLIst13232: ${systemgeneratedList.length}');
                                                        return systemGeneratedtable(
                                                            systemgeneratedList);
                                                      }
                                                    }
                                                  },
                                                ),
                                                //attached documents .......
                                                FutureBuilder<List<SystemAttachedModelitem>>(
                                                  future: GetJSON()
                                                      .getsystemgeneratedItem(
                                                          GetnotifyID, 2),
                                                  builder: (context, snapshot) {
                                                    print('Connection State: ${snapshot.connectionState}');
                                                    if (snapshot.connectionState == ConnectionState.waiting) {
                                                      return Center(
                                                        child: Container(
                                                          height: 40,
                                                          width: 40,
                                                          margin:
                                                              EdgeInsets.all(5),
                                                          child:
                                                              CircularProgressIndicator(
                                                            strokeWidth: 2.0,
                                                            valueColor:
                                                                AlwaysStoppedAnimation(
                                                                    ReColors()
                                                                        .appMainColor),
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                    if (snapshot.hasError) {
                                                      if (snapshot.error
                                                          is HttpException) {
                                                        return showError(
                                                            'An http error occurred. Page not found. Please try again.',
                                                            Icons.error);
                                                      }
                                                      if (snapshot.error
                                                          is NoInternetException) {
                                                        return showError(
                                                            'Please check your internet connection',
                                                            Icons
                                                                .signal_wifi_connected_no_internet_4_sharp);
                                                      }
                                                      if (snapshot.error
                                                          is NoServiceFoundException) {
                                                        return showError(
                                                            'Server Error.',
                                                            Icons.error);
                                                      }
                                                      if (snapshot.error
                                                          is InvalidFormatException) {
                                                        return showError(
                                                            'There is a problem with your request.',
                                                            Icons.error);
                                                      }
                                                      if (snapshot.error is SocketException) {
                                                        SocketException socketException =
                                                            snapshot.error as SocketException;
                                                        return showError(
                                                            'Please check your internet connection',
                                                            Icons
                                                                .signal_wifi_connected_no_internet_4_sharp);
                                                      } else {
                                                        return showError(
                                                            'An Unknown error occurred.',
                                                            Icons.error);
                                                      }
                                                    }
                                                    else {
                                                      print('len data: ${attachedDocumentList.length}');
                                                      print('Snapshot data: ${snapshot.data.length}');
                                                      attachedDocumentList = snapshot.data;
                                                      if (snapshot.data.length == 0) {
                                                        return showError('No data', Icons.assignment_late_outlined);
                                                      }
                                                      else {
                                                        print('DataLIst13232: ${attachedDocumentList.length}');
                                                        return systemGeneratedtable(attachedDocumentList);
                                                      }
                                                    }
                                                  },
                                                ),
                                              ],
                                            ),
                                          )
                                        ]),
                                  ),
                                ));
                          }),
                        ),
                      );
                    });
              },
              color: ReColors().appMainColor,
              child: Padding(
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.attach_file,
                      color: Colors.white,
                    ),
                    Text(
                      "Attachment",
                      style: TextStyle(
                          color: Colors.white, fontFamily: 'headerfont'),
                    )
                  ],
                ),
              )),
        ),
        Container(
            child: Row(children: <Widget>[
          Expanded(
              child: Padding(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: RaisedButton(
                onPressed: () {
                  if (_controllers.text == '') {
                    print(
                        'Accept 1${getID},${h_id},${GetnotifyID},${_controllers.text}');
                    print(
                        'Accept 000${getID},${h_id},${GetnotifyID},${_controllers.text}');
                    postJSON()
                        .postRemark(getID, h_id, 'A', GetnotifyID, 'A')
                        .then((value) {
                      confirmationPopup(context, 'Approved',
                          'Transaction Approved Successfully', 'OK');
                    });
                  } else {
                    print(
                        'Accept 2 ${getID},${h_id},${GetnotifyID},${_controllers.text}');
                    postJSON()
                        .postRemark(
                            getID, h_id, 'A', GetnotifyID, _controllers.text)
                        .then((value) {
                      confirmationPopup(context, 'Approved',
                          'Transaction Approved Successfully', 'OK');
                    });
                  }
                },
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
                        "Approve",
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'headerfont'),
                      )
                    ],
                  ),
                )),
          )),
          Expanded(
              child: Padding(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
            child: RaisedButton(
                onPressed: () {
                  print('Reject ${getID},${h_id},${GetnotifyID}');
                  if (_controllers.text == '') {
                    postJSON()
                        .postRemark(getID, h_id, 'R', GetnotifyID, 'R')
                        .then((value) {
                      errorPopup(context, 'Rejected',
                          'Transaction Rejected Successfully', 'OK');
                    });
                    ;
                  } else {
                    postJSON()
                        .postRemark(
                            getID, h_id, 'R', GetnotifyID, _controllers.text)
                        .then((value) {
                      errorPopup(context, 'Rejected',
                          'Transaction Rejected Successfully', 'OK');
                    });
                  }
                },
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
                        "Reject",
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'headerfont'),
                      )
                    ],
                  ),
                )),
          )),
        ])),
      ],
    );
  }

  TextEditingController qtyController = TextEditingController();

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
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget systemGeneratedtable(List<SystemAttachedModelitem> list) {
    return FittedBox(
      child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(1.0, 15.0),
                  blurRadius: 20.0,
                ),
              ]),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: DataTable(
                sortColumnIndex: 0,
                dividerThickness: 2,
                headingTextStyle: TextStyle(
                    color: Colors.white,
                    fontFamily: 'headingfont',
                    fontSize: 13),
                showCheckboxColumn: false,
                dataRowHeight: 40,
                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => ReColors().appMainColor),
                headingRowHeight: 30,
                horizontalMargin: 10,
                columns: <DataColumn>[
                  DataColumn(
                    label: Text(
                      'Description',
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'File',
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                    ),
                  ),
                ],
                rows: List.generate(
                    list.length,
                    (index) => DataRow(
                            onSelectChanged: (bool selected) {
                              if (selected) {
                                fileId = list[index].fileId;
                                print('fieldID: ${fileId}');
                                print(
                                    'list[index].fileType: ${list[index].fileType}');
                                if (list[index].fileType ==
                                    ("application/pdf")) {
                                  MySharedPreferences.instance
                                      .setIntValue('fileId', fileId);
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(builder: (BuildContext context) =>
                                              AttachmentsScreenApp()),
                                      (Route<dynamic> route) => false);
                                }
                                else if (list[index].fileType ==
                                    ("application/image")) {
                                  MySharedPreferences.instance
                                      .setIntValue('fileId', fileId);
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              ImageAttachmentsScreenApp()),
                                      (Route<dynamic> route) => false);
                                }
                                else {}
                              }
                            },
                            cells: [
                              DataCell(
                                Text(
                                    '${list[index].fileDescription == null ? 'No Data' : list[index].fileDescription}',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontFamily: 'titlefont',
                                        fontSize: 12)),
                              ),
                              DataCell(Text(
                                  '${list[index].fileName == null ? 'No Data' : list[index].fileName}',
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'titlefont',
                                      fontSize: 12))),
                            ])
                )
            ),
          )),
    );
  }

  confirmationPopup(
      BuildContext dialogContext, String title, String msg, String okbtn) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      overlayColor: Colors.black87,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      descStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      animationDuration: Duration(milliseconds: 400),
    );
    Alert(
        context: dialogContext,
        style: alertStyle,
        title: title,
        desc: msg,
        buttons: [
          DialogButton(
            child: Text(
              okbtn,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed: () {
              if (!mounted) return;
              setState(() {
                //Your code
                Navigator.of(context, rootNavigator: true).pop();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => EapprovalPage()),
                    (Route<dynamic> route) => false);
              });
            },
            color: Colors.black,
          ),
        ]).show();
  }

  errorPopup(BuildContext dialogContext, String title, String msg, String okbtn) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      overlayColor: Colors.black87,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      titleStyle: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 18, fontFamily: 'titlefont'),
      descStyle: TextStyle(
          fontWeight: FontWeight.w500, fontSize: 16, fontFamily: 'titlefont'),
      animationDuration: Duration(milliseconds: 400),
    );

    Alert(
        context: dialogContext,
        style: alertStyle,
        title: title,
        desc: msg,
        buttons: [
          DialogButton(
            child: Text(
              okbtn,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed: () {
              if (!mounted) return;
              setState(() {
                //Your code
                Navigator.of(context, rootNavigator: true).pop();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => EapprovalPage()),
                    (Route<dynamic> route) => false);
              });
            },
            color: ReColors().appMainColor,
          ),
        ]).show();
  }
}
