import 'dart:io';

import 'package:art/InternetConnection/Offline.dart';
import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/Model/DetailCards.dart';
import 'package:art/Model/testingModel.dart';
import 'package:art/ParsingJSON/GetJSONMethod.dart';
import 'package:art/ParsingJSON/PostJSONMethod.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableValues/ReStrings.dart';
import 'package:art/ReuseableWidget/CustomAppbarWidget.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:art/Error/Error.dart';

import 'EapprovalByUserID.dart';

class TransactionNotifyID extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _TransactionNotifyIDstate();
}

class _TransactionNotifyIDstate extends State<TransactionNotifyID> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                  //list of user
                  notifylist = users;
                  // _controllers[transactionList.length] =
                  //     new TextEditingController();
                  if (notifylist.length == 0) {
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
    return Scaffold(
        appBar: new CustomAppBar(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => EapprovalByUSERID()),
            );
          },
          Title: 'Transaction',
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
                    'An http error occured.Page not found. Please try again.',
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
                return showError('An Unknown error occured.', Icons.error);
              }
            }
            return Center(
                child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(ReColors().appMainColor),
            ));
          },
        )));
  }

  Widget CompleteWidget(transactionList) {
    return Column(
      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      '${fromUser}',
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  )),
              Expanded(
                  child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text(
                    '${doc_no}',
                    textAlign: TextAlign.right,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                ),
              ))
            ],
          ),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(
                  '${dep_name}',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              )),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(
                  '${des_name}',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              )),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(
                  '${frd_remarks}',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ))
        ],
      ),
    );
  }

  Widget _groupedListView(_gplist1) {
    return Padding(
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: StickyGroupedListView<Detailcardsitem, int>(
          elements: _gplist1,
          order: StickyGroupedListOrder.ASC,
          groupBy: (Detailcardsitem element) => element.cardId,
          groupComparator: (int value1, int value2) => value2.compareTo(value1),
          itemComparator:
              (Detailcardsitem element1, Detailcardsitem element2) =>
                  element1.cardId.compareTo(element2.cardId),
          floatingHeader: true,
          // ignore: missing_return
          groupSeparatorBuilder: (Detailcardsitem element) => Container(
            child: Text(''),
          ),
          itemBuilder: (_, Detailcardsitem element) {
            if (element.columnPrompt.contains("Item")) {
              print('checking${element.columnPrompt.contains("Item")}');
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
                          '${element.columnPrompt}  ',
                          maxLines: 3,
                          style: TextStyle(color: Colors.white),
                        ),
                        Expanded(
                            child: Text('${element.columnVal}',
                                maxLines: 3,
                                textAlign: TextAlign.right,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(color: Colors.white))),
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
                    // border: Border.all(color: Color(0xff940D5A)),
                    /*gradient: LinearGradient(
                          begin: Alignment(-0.6, -1),
                          end: Alignment(-1, -0),
                          colors: [ReColors().darkgreyColor,
                            ReColors().darkgreyColor,],
                        ),*/
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
                          style: TextStyle(color: Colors.white),
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
            } else if (element.columnVal.contains('N')) {
              return Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(
                    // border: Border.all(color: Color(0xff940D5A)),
                    /*gradient: LinearGradient(
                          begin: Alignment(-0.6, -1),
                          end: Alignment(-1, -0),
                          colors: [ReColors().darkgreyColor,
                            ReColors().darkgreyColor,],
                        ),*/
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
                          style: TextStyle(color: Colors.white),
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
            if (element.columnVal.contains('Edit')) {
              return Container(
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(
                    // border: Border.all(color: Color(0xff940D5A)),
                    /*gradient: LinearGradient(
                          begin: Alignment(-0.6, -1),
                          end: Alignment(-1, -0),
                          colors: [ReColors().darkgreyColor,
                            ReColors().darkgreyColor,],
                        ),*/
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
              padding: EdgeInsets.fromLTRB(10, 3, 10, 3),
              decoration: BoxDecoration(
                // border: Border.all(color: Color(0xff940D5A)),
                /*gradient: LinearGradient(
                          begin: Alignment(-0.6, -1),
                          end: Alignment(-1, -0),
                          colors: [ReColors().darkgreyColor,
                            ReColors().darkgreyColor,],
                        ),*/
                gradient: LinearGradient(
                  begin: Alignment(-0.9, -1),
                  end: Alignment(-0.1, -0),
                  colors: [
                    ReColors().appMainColor,
                    ReColors().lightappMainColor1
                  ],
                ),
                color: Colors.white,
                /*boxShadow: <BoxShadow>[
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(1.0, 1.0),
                      blurRadius: 5.0,
                    ),
                  ]*/
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '${element.columnPrompt}  ',
                        maxLines: 6,
                        style: TextStyle(color: Colors.white),
                      ),
                      Expanded(
                          child: Text('${element.columnVal}',
                              maxLines: 6,
                              textAlign: TextAlign.right,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(color: Colors.white))),
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
    var someDateTime = new DateTime.now();
    mon = someDateTime.month;
    print(months[mon - 1]);
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
              // controller: _controllers[index],
              controller: _controllers,
            ),
          ),
        ),
        Container(
            child: Row(children: <Widget>[
          Expanded(
              child: Padding(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 20),
            child: RaisedButton(
                onPressed: () {
                  if (_controllers.text == '') {
                    print(
                        'Accept 1${getID},${h_id},${GetnotifyID},${_controllers.text}');
                    postJSON().postRemark(getID, h_id, 'A', GetnotifyID, 'A');
                  } else {
                    print(
                        'Accept 2 ${getID},${h_id},${GetnotifyID},${_controllers.text}');
                    postJSON().postRemark(
                        getID, h_id, 'A', GetnotifyID, _controllers.text);
                  }
                  // _controllers[index].text
                  setState(() {
                    _isloading = true;
                    print('is loading?${_isloading}');
                    if (_isloading) {
                      progressDialog.show();
                    }
                  });
                  Future.delayed(Duration(seconds: 3)).then((value) => {
                        print('is loading1?${_isloading}'),
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  EapprovalByUSERID()),
                        ),
                        /* setState(() {
                          print('is loading2?${_isloading}');
                          _isloading = false;
                          progressDialog.hide();
                        })*/
                      });
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
                        "Accept",
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                )),
          )),
          Expanded(
              child: Padding(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 20),
            child: RaisedButton(
                onPressed: () {
                  print('Reject ${getID},${h_id},${GetnotifyID}');
                  if (_controllers.text == '') {
                    postJSON().postRemark(getID, h_id, 'R', GetnotifyID, 'R');
                  } else {
                    postJSON().postRemark(
                        getID, h_id, 'R', GetnotifyID, _controllers.text);
                  }

                  setState(() {
                    _isloading = true;
                    print('is loading?${_isloading}');
                    if (_isloading) {
                      progressDialog.show();
                    }
                  });
                  Future.delayed(Duration(seconds: 3)).then((value) => {
                        print('is loading1?${_isloading}'),
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  EapprovalByUSERID()),
                        ),
                        /* setState(() {
                          print('is loading2?${_isloading}');
                          _isloading = false;
                          progressDialog.hide();
                        })*/
                      });
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
                        style: TextStyle(color: Colors.white),
                      )
                    ],
                  ),
                )),
          )),
          Expanded(
              child: Padding(
            padding: EdgeInsets.fromLTRB(5, 5, 5, 20),
            child: RaisedButton(
                onPressed: () {
                  print('Cancel ${getID},${h_id},${GetnotifyID}');
                  if (_controllers.text == '') {
                    postJSON().postRemark(getID, h_id, 'C', GetnotifyID, 'C');
                  } else {
                    postJSON().postRemark(
                        getID, h_id, 'C', GetnotifyID, _controllers.text);
                  }

                  setState(() {
                    _isloading = true;
                    print('is loading?${_isloading}');
                    if (_isloading) {
                      progressDialog.show();
                    }
                  });
                  Future.delayed(Duration(seconds: 3)).then((value) => {
                        print('is loading1?${_isloading}'),
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  EapprovalByUSERID()),
                        ),
                        /* setState(() {
                          print('is loading2?${_isloading}');
                          _isloading = false;
                          progressDialog.hide();
                        })*/
                      });
                },
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
                        style: TextStyle(color: Colors.white),
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

  Future<void> _displayQuantityDialog(BuildContext context, lineID) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Update',
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
                            // ..text = quantity,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Required Quantity',
                            ),
                            onChanged: (Quantitytext) {
                              setState(() {
                                // quantity = 'Required Quantity';
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
                        //hit hogi api
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
}
