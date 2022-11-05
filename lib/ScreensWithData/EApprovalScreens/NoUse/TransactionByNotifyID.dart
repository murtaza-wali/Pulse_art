import 'dart:io';

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
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:art/Error/Error.dart';

import '../viewdocuments/viewpdfScreen.dart';
import '../EapprovalFirstScreen.dart';
import '../viewdocuments/viewImageScreen.dart';

class TransactionNotifyID extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _TransactionNotifyIDstate();
}

class _TransactionNotifyIDstate extends State<TransactionNotifyID>
    with SingleTickerProviderStateMixin{
  List<Detailcardsitem> notifylist = [];
  TextEditingController _controllers = TextEditingController();
  bool editVisibility = false;
  String dep_name, fromUser, des_name, frd_remarks;
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
        .getStringValue("fromUser")
        .then((value) => setState(() {
              fromUser = value;
              print(fromUser);
            }));
    MySharedPreferences.instance
        .getStringValue("department")
        .then((value) => setState(() {
              dep_name = value;
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
        .getIntValue("notificationID")
        .then((value) => setState(() {
              GetnotifyID = value;
              print('GetnotifyID ${GetnotifyID}');
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
          Title: 'Transaction',
          image_bar: 'assets/images/eapprovals.png',
          refreshonPressed: () {
            _refreshMenu().then((list) => setState(() {
                  notifylist = list;
                  print(notifylist.length);
                }));
          },
        ),
        body: ReuseOffline().getoffline(FutureBuilder<List<Detailcardsitem>>(
          future: GetJSON().getTrasactionByNotifyId(GetnotifyID),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              notifylist = snapshot.data;
              if (notifylist.length == 0) {
                return Center(
                  child: Text(
                    "No Data Found",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                );
              } else {
                return CompleteWidget(notifylist);
              }
            } else if (snapshot.hasError) {
              print('checking Error: ${snapshot.error}');
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

  Widget CompleteWidget(transactionList) {
    return Column(
      children: <Widget>[
        DetailsWidget(),
        Expanded(child: _groupedListView(transactionList)),
        widgetContainer(),
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

  int converterInt(Detailcardsitem detailcardsitem) {
    String details = detailcardsitem.cardId.toString().replaceAll(".", "");
    print('details details: ${details}');
    int a = int.parse(details);
    print('details card: ${a}');
    return a;
  }

  Widget _groupedListView(List<Detailcardsitem> _gplist1) {
    return Padding(
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: StickyGroupedListView<Detailcardsitem, int>(
          elements: _gplist1,
          order: StickyGroupedListOrder.ASC,
          groupBy: (Detailcardsitem element) => converterInt(element),
          groupComparator: (int value1, int value2) => value2.compareTo(value1),
          itemComparator:
              (Detailcardsitem element1, Detailcardsitem element2) =>
                  element1.columnSequence.compareTo(element2.columnSequence),
          floatingHeader: true,
          groupSeparatorBuilder: (Detailcardsitem element) => Container(
            child: Text(''),
          ),
          itemBuilder: (_, Detailcardsitem element) {
            if (element.columnPrompt.contains("Item")) {
              print('checking${element.columnPrompt.contains("Item")}');
              return Container(
                padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(-0.9, -1),
                      end: Alignment(-0.1, -0),
                      colors: [
                        ReColors().appMainColor,
                        ReColors().lightappMainColor1
                      ],
                    ),
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1.0, 15.0),
                        blurRadius: 10.0,
                      ),
                    ]),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '${element.columnPrompt}  ',
                          maxLines: 3,
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'headingfont'),
                        ),
                        Expanded(
                            child: Text('${element.columnVal}',
                                maxLines: 3,
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'titlefont'))),
                      ],
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                  ],
                ),
              );
            }
            if (element.columnVal.contains('chk')) {
              return Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(-0.9, -1),
                      end: Alignment(-0.1, -0),
                      colors: [
                        ReColors().appMainColor,
                        ReColors().lightappMainColor1
                      ],
                    ),
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1.0, 15.0),
                        blurRadius: 10.0,
                      ),
                    ]),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '${element.columnPrompt}',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'headingfont'),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.check_circle,
                              color: Colors.red,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                  ],
                ),
              );
            }
            else if (element.columnVal.contains('nck')) {
              return Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(-0.9, -1),
                      end: Alignment(-0.1, -0),
                      colors: [
                        ReColors().appMainColor,
                        ReColors().lightappMainColor1
                      ],
                    ),
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1.0, 15.0),
                        blurRadius: 10.0,
                      ),
                    ]),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '${element.columnPrompt}',
                          style: TextStyle(
                              color: Colors.white, fontFamily: 'headingfont'),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Icon(
                              Icons.cancel,
                              color: Colors.green,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                  ],
                ),
              );
            }
            if (element.columnVal.contains('Edit')) {
              return Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment(-0.9, -1),
                      end: Alignment(-0.1, -0),
                      colors: [
                        ReColors().appMainColor,
                        ReColors().lightappMainColor1
                      ],
                    ),
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(1.0, 15.0),
                        blurRadius: 10.0,
                      ),
                    ]),
                child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          '',
                          style: TextStyle(color: Colors.white),
                        ),
                        Padding(
                          padding: EdgeInsets.all(0),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: IconButton(
                              color: Colors.white,
                              icon: new Icon(Icons.edit),
                              onPressed: () {
                                print('lineees ID${element.cardId}');
                                _displayQuantityDialog(
                                  context,
                                  element.cardId,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                  ],
                ),
              );
            }

            return Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(-0.9, -1),
                  end: Alignment(-0.1, -0),
                  colors: [
                    ReColors().appMainColor,
                    ReColors().lightappMainColor1
                  ],
                ),
                color: Colors.white,
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${element.columnPrompt}  ',
                        maxLines: 6,
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'headingfont'),
                      ),
                      Expanded(
                          child: Text('${element.columnVal}',
                              maxLines: 6,
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'titlefont'))),
                    ],
                  ),
                  Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                ],
              ),
            );
          },
        ));
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
                                              print(
                                                  'show me the index${index}');
                                              if (index == 0) {
                                                GetJSON()
                                                    .getsystemgeneratedItem(
                                                        GetnotifyID, 1)
                                                    .then((sysGenList) {
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
                                                });
                                              } else if (index == 1) {
                                                GetJSON()
                                                    .getsystemgeneratedItem(
                                                        GetnotifyID, 2)
                                                    .then((sysGenList) {
                                                  setState(() {
                                                    attachedDocumentList =
                                                        sysGenList;
                                                    if (attachedDocumentList
                                                            .length ==
                                                        0) {
                                                      return showError(
                                                          'No data found',
                                                          Icons
                                                              .assignment_late_outlined);
                                                    }
                                                  });
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
                                                FutureBuilder<
                                                    List<
                                                        SystemAttachedModelitem>>(
                                                  future: GetJSON()
                                                      .getsystemgeneratedItem(
                                                          GetnotifyID, 1),
                                                  builder: (context, snapshot) {
                                                    print(
                                                        'Connection State: ${snapshot.connectionState}');
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
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
                                                      if (snapshot.error
                                                          is SocketException) {
                                                        SocketException
                                                            socketException =
                                                            snapshot.error
                                                                as SocketException;
                                                        return showError(
                                                            'Please check your internet connection',
                                                            Icons
                                                                .signal_wifi_connected_no_internet_4_sharp);
                                                      } else {
                                                        return showError(
                                                            'An Unknown error occurred.',
                                                            Icons.error);
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
                                                FutureBuilder<
                                                    List<
                                                        SystemAttachedModelitem>>(
                                                  future: GetJSON()
                                                      .getsystemgeneratedItem(
                                                          GetnotifyID, 2),
                                                  builder: (context, snapshot) {
                                                    print(
                                                        'Connection State: ${snapshot.connectionState}');
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
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
                                                      if (snapshot.error
                                                          is SocketException) {
                                                        SocketException
                                                            socketException =
                                                            snapshot.error
                                                                as SocketException;
                                                        return showError(
                                                            'Please check your internet connection',
                                                            Icons
                                                                .signal_wifi_connected_no_internet_4_sharp);
                                                      } else {
                                                        return showError(
                                                            'An Unknown error occurred.',
                                                            Icons.error);
                                                      }
                                                    } else {
                                                      print(
                                                          'len data: ${attachedDocumentList.length}');
                                                      print(
                                                          'Snapshot data: ${snapshot.data.length}');
                                                      attachedDocumentList =
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
                                                            'DataLIst13232: ${attachedDocumentList.length}');
                                                        return systemGeneratedtable(
                                                            attachedDocumentList);
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
        )
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

  Future<void> _displayQuantityDialog(BuildContext context, lineID) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              '',
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
                            keyboardType: TextInputType.number,
                            controller: qtyController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Approve Quantity',
                            ),
                            onChanged: (Quantitytext) {
                              setState(() {});
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
                        print('lines id: ${lineID}');
                        print('user id :${getID}');
                        print('qtyController.text :${qtyController.text}');
                        postJSON().postqty(getID, qtyController.text, lineID);
                        _refreshMenu().then((list) => setState(() {
                              notifylist = list;
                              print(
                                  'notification length: ${notifylist.length}');
                            }));
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
              ]
          ),
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
                dataRowHeight: 60,
                headingRowColor: MaterialStateColor.resolveWith(
                    (states) => ReColors().appMainColor),
                headingRowHeight: 40,
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
                                  Navigator.pushAndRemoveUntil(context,
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
                              DataCell(
                                  Text(
                                  '${list[index].fileName == null ? 'No Data' : list[index].fileName}',
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'titlefont',
                                      fontSize: 12))),
                            ]
                    ))),
          )
      ),
    );
  }

  confirmationPopup(BuildContext dialogContext, String title, String msg, String okbtn) {
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
                Navigator.pushAndRemoveUntil(context,
                    MaterialPageRoute(builder: (BuildContext context) => EapprovalPage()),
                    (Route<dynamic> route) => false);
              });
            },
            color: Colors.black,
          ),
        ]).show();
  }

  errorPopup(
      BuildContext dialogContext, String title, String msg, String okbtn) {
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
