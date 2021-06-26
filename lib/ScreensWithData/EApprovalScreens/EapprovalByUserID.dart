import 'dart:io';

import 'package:art/Error/Error.dart';
import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/Model/DatabyType.dart';
import 'package:art/Model/typeModel.dart';
import 'package:art/ParsingJSON/GetJSONMethod.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/CustomAppbarWidget.dart';
import 'package:art/ReuseableWidget/CustomDropdown.dart';
import 'package:art/ReuseableWidget/GradientBG.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:art/ScreensWithData/Menu/MainMenuPopup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'TransactionByID.dart';

class EapprovalByUSERID extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _EapprovalByUSERIDState();
}

class _EapprovalByUSERIDState extends State<EapprovalByUSERID> {
  String selectedSpinnerItem;
  int spinnerId;
  List<Typeitem> listTypeItem = [];
  int getID;
  List<DataByTypeitem> dataList = [];
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool visible = false;
  bool listvisible = false;

  @override
  void initState() {
    super.initState();
    MySharedPreferences.instance
        .getIntValue("UserId")
        .then((value) => setState(() {
              getID = value;
              print(getID);

              GetJSON().gettypeItem(getID).then((users) {
                setState(() {
                  //list of user
                  listTypeItem = users;
                  print('list type item: ${listTypeItem.length}');
                  if (listTypeItem.length == 0) {
                    visible = false;
                    return showError(
                        'No data found', Icons.assignment_late_outlined);
                  } else {
                    selectedSpinnerItem = listTypeItem.first.type;
                    spinnerId = listTypeItem.first.typeId;
                    visible = true;
                  }
                });
              });
            }));
  }

  Future<dynamic> _refreshMenu() async {
    print('GET ID : ${getID}');
    print('selectedSpinnerItem : ${selectedSpinnerItem}');
    return await GetJSON().gettypeItem(getID);
  }

/* avatar: CircleAvatar(
        backgroundColor: Colors.grey.shade600,
        child: Text(count.toString()),
      )*/
  /*Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
      )*/
  Widget chip(String label, int count, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: ReColors().appMainColor,
            ),
          ),
        ),
        CircleAvatar(
          radius: 13,
          backgroundColor: Colors.red,
          child: Center(
            child: Text(count.toString(),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                )),
          ),
        ),
      ],
    );
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
        Title: 'E-Approval',
        refreshonPressed: () {
          _refreshMenu().then((list) => setState(() {
                listTypeItem = list;
                print(listTypeItem.length);
              }));
        },
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: Visibility(
                  visible: visible,
                  child: CustomDropdown(
                    dropdownMenuItemList: listTypeItem.map((item) {
                          return DropdownMenuItem(
                            child: chip(item.type, item.typecount, Colors.grey),
                            value: item.type,
                          );
                        }).toList() ??
                        [],
                    onChanged: (newVal) {
                      setState(() {
                        selectedSpinnerItem = newVal;
                        print('spinnerID: ${selectedSpinnerItem}');
                        GetJSON()
                            .getDatabytypeItem(getID, spinnerId.toString())
                            .then((value) {
                          dataList = value;
                        });
                      });
                    },
                    value: selectedSpinnerItem,
                    isEnabled: true,
                    color: ReColors().appMainColor,
                  ),
                ),
              ),
              FutureBuilder<List<DataByTypeitem>>(
                future: GetJSON().getDatabytypeItem(getID, spinnerId.toString()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    dataList = snapshot.data;
                    if (visible == true) {
                      listvisible = true;
                      if (dataList.length == 0) {
                        return showError(
                            'No data found', Icons.assignment_late_outlined);
                      } else {
                        return getListofTransactionByID(dataList);
                      }
                    } else {
                      return showError(
                          'No data found', Icons.assignment_late_outlined);
                    }

                    // return getListofTransactionByID(transactionList);
                  } else if (snapshot.hasError) {
                    if (snapshot.error is NoInternetException) {
                      NoInternetException noInternetException =
                      snapshot.error as NoInternetException;
                      return showError(
                          noInternetException.message, Icons.error);
                    } if (snapshot.error is SocketException) {
                      SocketException socketException =
                      snapshot.error as SocketException;
                      print('Socket checking: ${socketException.message}');
                      return showError('Please check your internet connection',
                          Icons.signal_wifi_connected_no_internet_4);
                    }
                   /* if (snapshot.error is HttpException) {
                      HttpException httpException =
                          snapshot.error as HttpException;
                      return showError(httpException.message, Icons.error);
                    }
                    if (snapshot.error is NoInternetException) {
                      NoInternetException noInternetException =
                          snapshot.error as NoInternetException;
                      return showError(
                          noInternetException.message, Icons.error);
                    }
                    if (snapshot.error is NoServiceFoundException) {
                      NoServiceFoundException noServiceFoundException =
                          snapshot.error as NoServiceFoundException;
                      return showError(
                          noServiceFoundException.message, Icons.error);
                    }
                    if (snapshot.error is InvalidFormatException) {
                      InvalidFormatException invalidFormatException =
                          snapshot.error as InvalidFormatException;
                      return showError(
                          invalidFormatException.message, Icons.error);
                    }
                    if (snapshot.error is SocketException) {
                      SocketException socketException =
                          snapshot.error as SocketException;
                      print('Socket checking: ${socketException.message}');
                      return showError('Please check your internet connection',
                          Icons.signal_wifi_connected_no_internet_4);
                    } else {
                      UnknownException unknownException =
                          snapshot.error as UnknownException;
                      return showError(unknownException.message, Icons.error);
                    }*/
                  }
                  return Center(
                      child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(ReColors().appMainColor),
                  ));
                },
              )
            ],
          ),
        ),
      ),
    ));
  }

  Widget getListofTransactionByID(list) {
    return Visibility(
        visible: listvisible,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: RefreshIndicator(
              key: _refreshIndicatorKey,
              onRefresh: () => _refreshMenu(),
              child: ListView.builder(
                padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                shrinkWrap: true,
                itemCount: null == list ? 0 : list.length,
                itemBuilder: (BuildContext context, int index) {
                  DataByTypeitem depReqItem = list[index];
                  print('Result ${depReqItem}');
                  return GestureDetector(
                      onTap: () {
                        // MySharedPreferences.instance.removeValue("transactionID");
                        MySharedPreferences.instance.setIntValue(
                            "transactionID", depReqItem.transactionId);
                        MySharedPreferences.instance
                            .setStringValue("fromUser", depReqItem.fromUserName);
                        MySharedPreferences.instance.setStringValue(
                            "doc_number", depReqItem.documentNumber);
                        MySharedPreferences.instance.setStringValue(
                            "department", depReqItem.departmentName);
                        MySharedPreferences.instance
                            .setStringValue("description", depReqItem.subject);
                        MySharedPreferences.instance
                            .setIntValue("hID", depReqItem.hid);
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TransactionByID()),
                        );
                      },
                      child: Container(
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: Card(
                            elevation: 25,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 0.0, horizontal: 0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(5),
                                child: Container(
                                  decoration: BoxDecoration(
                                    // border: Border.all(color: Color(0xff940D5A)),
                                    gradient: LinearGradient(
                                      begin: Alignment(-0.9, -1),
                                      end: Alignment(-0.1, -0),
                                      colors: [
                                        ReColors().appMainColor,
                                        ReColors().lightappMainColor1
                                      ],
                                    ),
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(5.0),
                                  ),
                                  // color: Colors.white,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(10, 10, 10, 10),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 0, 0, 0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: <Widget>[
                                                    Text(
                                                      '${depReqItem.fromUserName}',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                    Text(
                                                        '${getmonthName(depReqItem.sentDate.month)} ${depReqItem.sentDate.day}, ${depReqItem.sentDate.year}',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white)),
                                                  ],
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 5, 0, 5),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Text(
                                                        '${depReqItem.departmentName}',
                                                        style: TextStyle(
                                                            color:
                                                                Colors.white),
                                                      ),
                                                      Text(
                                                          '${depReqItem.documentNumber}',
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                    ],
                                                  ),
                                                ),
                                                Divider(
                                                  height: 1,
                                                  color: Colors.grey,
                                                ),
                                                Padding(
                                                  padding: EdgeInsets.fromLTRB(
                                                      0, 5, 0, 5),
                                                  child: Text(
                                                      '${depReqItem.subject}',
                                                      // maxLines: 3,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      softWrap: false,
                                                      style: TextStyle(
                                                          color: Colors.white)),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),

                                        // Icon(Icons.arrow_forward_ios, color: Colors.blue),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ));
                },
              )),
        ));
  }

  Widget showError(String message, key) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Center(
          child: Icon(
            key,
            size: 70,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          message,
          style: TextStyle(fontSize: 20),
        )
      ],
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
    var someDateTime = new DateTime.now();
    mon = someDateTime.month;
    print(months[mon - 1]);
    return months[mon - 1];
  }
}
