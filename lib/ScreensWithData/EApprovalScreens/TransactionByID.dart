import 'dart:io';

import 'package:art/Error/Error.dart';
import 'package:art/InternetConnection/Offline.dart';
import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/Model/transactionByID.dart';
import 'package:art/ParsingJSON/GetJSONMethod.dart';
import 'package:art/ParsingJSON/PostJSONMethod.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableValues/ReStrings.dart';
import 'package:art/ReuseableWidget/CustomAppbarWidget.dart';
import 'package:art/ReuseableWidget/GradientBG.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:art/ScreensWithData/EApprovalScreens/EapprovalByUserID.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionByID extends StatefulWidget {
  State<StatefulWidget> createState() => _TransationByIDState();
}

class _TransationByIDState extends State<TransactionByID> {
  List<DepReqItem> transactionList = [];
  int GettransID;
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  int getID;
  int h_id;
  String dep_name, fromUser, des_name;
  int doc_no;
  TextEditingController _controllers = TextEditingController();

  // List<TextEditingController> _controllers = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
              print(dep_name);
            }));
    MySharedPreferences.instance
        .getStringValue("description")
        .then((value) => setState(() {
              des_name = value;
              print(des_name);
            }));
    MySharedPreferences.instance
        .getIntValue("doc_number")
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
        .getIntValue("hID")
        .then((value) => setState(() {
              h_id = value;
              print(h_id);
            }));
    MySharedPreferences.instance
        .getIntValue("transactionID")
        .then((value) => setState(() {
              GettransID = value;
              print('GettransID ${GettransID}');
              GetJSON().getTransationItemsById(GettransID).then((users) {
                setState(() {
                  //list of user
                  transactionList = users;
                  // _controllers[transactionList.length] =
                  //     new TextEditingController();
                  if (transactionList.length == 0) {
                    return showError(
                        'No data found', Icons.assignment_late_outlined);
                  }
                });
              });
            }));
  }

  Future<dynamic> _refreshMenu() async {
    return await GetJSON().getTransationItemsById(GettransID);
  }

  @override
  Widget build(BuildContext context) {
    return Willpopwidget().getWillScope(Scaffold(
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
                transactionList = list;
                print(transactionList.length);
              }));
        },
      ),
      body: ReuseOffline().getoffline(FutureBuilder<List<DepReqItem>>(
        future: GetJSON().getTransationItemsById(GettransID),
        builder: (context, snapshot) {
          print('hasData: ${snapshot.hasError}');
          if (snapshot.hasData) {
            transactionList = snapshot.data;
            print('LIST: ${transactionList.length}');
            print('Error: ${snapshot.error}');
            if (transactionList.length == 0) {
              return showError('No data found', Icons.assignment_late_outlined);
            } else {
              return CompleteWidget(transactionList);
              // return getListofTransactionByID(transactionList);
              // return getData(transactionList);
            }
          } else if (snapshot.hasError) {
            print('checking Error: ${snapshot.error}');
            if (snapshot.error is HttpException) {
              HttpException httpException = snapshot.error as HttpException;
              return showError(httpException.message, Icons.error);
            }
            if (snapshot.error is NoInternetException) {
              NoInternetException noInternetException =
                  snapshot.error as NoInternetException;
              return showError(noInternetException.message, Icons.error);
            }
            if (snapshot.error is NoServiceFoundException) {
              NoServiceFoundException noServiceFoundException =
                  snapshot.error as NoServiceFoundException;
              return showError(noServiceFoundException.message, Icons.error);
            }
            if (snapshot.error is InvalidFormatException) {
              InvalidFormatException invalidFormatException =
                  snapshot.error as InvalidFormatException;
              return showError(invalidFormatException.message, Icons.error);
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
            }
          }
          return Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(ReColors().appMainColor),
          ));
        },
      )),
    ));
  }

  Widget tableWidget(uom, approve_qty, required_qty) {
    return Padding(
      padding: EdgeInsets.all(3),
      child: Column(children: [
        Container(
          padding: EdgeInsets.all(3),
          child: Row(children: <Widget>[
            Expanded(
                child: Center(
                    child: Text("UOM",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(color: Colors.white)))),
            Expanded(
                child: Center(
                    child: Text("Required Quantity",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(color: Colors.white)))),
            Expanded(
                child: Center(
                    child: Text("Approved Quantity",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(color: Colors.white)))),
          ]),
        ),
        Divider(
          height: 1,
          color: Colors.grey,
        ),
        Container(
          padding: EdgeInsets.all(3),
          child: Row(children: <Widget>[
            Expanded(
                child: Center(
                    child: Text(uom.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(color: Colors.white)))),
            Expanded(
                child: Center(
                    child: Text(required_qty.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(color: Colors.white)))),
            Expanded(
                child: Center(
                    child: Text(approve_qty.toString(),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(color: Colors.white)))),
          ]),
        ),
      ]),
    );
  }

  Widget getData(transList) {
    return Container(
      child: IntrinsicHeight(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: MediaQuery.of(context).size.height,
          ),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(children: [
              Container(
                color: ReColors().appMainColor,
                child: ListTile(
                  title: Row(children: <Widget>[
                    Expanded(
                        child: Center(
                            child: Text(
                      "Description",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      softWrap: false,
                      style: TextStyle(color: Colors.white),
                    ))),
                    Expanded(
                        child: Center(
                            child: Text("UOM",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(color: Colors.white)))),
                    Expanded(
                        child: Center(
                            child: Text("Required Quantity",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(color: Colors.white)))),
                    Expanded(
                        child: Center(
                            child: Text("Approve Quantity",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(color: Colors.white)))),
                    Expanded(
                        child: Center(
                      child: Text("Edit",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(color: Colors.white)),
                    )),
                  ]),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: transList == null ? 0 : transList.length,
                itemBuilder: (BuildContext context, int index) {
                  DepReqItem depReqItem = transactionList[index];
                  // _controllers.add(new TextEditingController());
                  // _controllers[index].text = transactionList[index].toString();
                  return ListTile(
                      //return new ListTile(
                      onTap: null,
                      title: Column(
                        children: [
                          Row(children: <Widget>[
                            Expanded(
                                child: Center(
                              child: Text(
                                depReqItem.itemDesc,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ),
                            )),
                            Expanded(
                                child: Center(
                              child: Text(
                                depReqItem.uomCode,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ),
                            )),
                            Expanded(
                                child: Center(
                              child: Text(
                                depReqItem.requiredQuantity.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ),
                            )),
                            Expanded(
                                child: Center(
                              child: Text(
                                depReqItem.approvedQuantity.toString(),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                              ),
                            )),
                            Expanded(
                                child: Center(
                              child: IconButton(
                                color: Colors.white,
                                icon: new Icon(Icons.edit),
                                onPressed: () {
                                  print('lineees ID${depReqItem.linesId}');
                                  _displayQuantityDialog(
                                      context,
                                      depReqItem.approvedQuantity,
                                      depReqItem.linesId,
                                      depReqItem.itemDesc);
                                },
                              ),
                            )),
                          ]),
                          Divider(
                            color: Colors.white,
                          )
                        ],
                      ));
                }, //itemBuilder
              ),
              Column(
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
                            borderSide:
                                BorderSide(color: ReColors().appMainColor),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: ReColors().appMainColor, width: 2.0),
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          border: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: ReColors().appMainColor)),
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
                      padding: EdgeInsets.all(10),
                      child: RaisedButton(
                          onPressed: () {
                            print('Accept ${getID},${h_id},${GettransID}');
                            postJSON().postRemark(getID, h_id, 'A', GettransID,
                                _controllers.text);
                            // _controllers[index].text
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      EapprovalByUSERID()),
                            );
                          },
                          color: ReColors().appMainColor,
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.check_circle,
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
                      padding: EdgeInsets.all(10),
                      child: RaisedButton(
                          onPressed: () {
                            print('Reject ${getID},${h_id},${GettransID}');
                            postJSON().postRemark(getID, h_id, 'R', GettransID,
                                _controllers.text);
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      EapprovalByUSERID()),
                            );
                          },
                          color: ReColors().appMainColor,
                          child: Padding(
                            padding: EdgeInsets.all(5),
                            child: Column(
                              children: [
                                Icon(
                                  Icons.cancel,
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
                  ])),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
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
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
      ],
    );
  }

  TextEditingController qtyController = TextEditingController();

  Future<void> _displayQuantityDialog(
      BuildContext context, int quantity, lineID, String description) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              description,
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
                            controller: qtyController
                              ..text = quantity.toString(),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Quantity',
                            ),
                            onChanged: (Quantitytext) {
                              setState(() {
                                quantity = int.parse(Quantitytext);
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
                        postJSON().postqty(getID, qtyController.text, lineID);
                        _refreshMenu().then((list) => setState(() {
                              transactionList = list;
                              print(transactionList.length);
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

  Widget getListofTransactionByID(transactionList) {
    return Column(
      children: <Widget>[
        ListView.builder(
            shrinkWrap: true,
            itemCount: null == transactionList ? 0 : transactionList.length,
            itemBuilder: (BuildContext context, int index) {
              DepReqItem depReqItem = transactionList[index];
              print('Result ${depReqItem}');
              return Card(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 0.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                          // border: Border.all(color: Color(0xff940D5A)),

                          color: Colors.white,
                          // borderRadius: BorderRadius.circular(17.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(1.0, 15.0),
                              blurRadius: 20.0,
                            ),
                          ]),
                      height: 70,
                      // color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Expanded(
                                      child: Text(
                                    '${depReqItem.itemDesc}',
                                    style: TextStyle(fontSize: 18),
                                  )),
                                  Text('UOM : ${depReqItem.uomCode}'),
                                  Text(
                                      'Required Quantity  : ${depReqItem.requiredQuantity}'),
                                  Text(
                                      'Approved Quantity: ${depReqItem.approvedQuantity}')
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                              child: Center(
                                  child: IconButton(
                            color: Colors.white,
                            icon: new Icon(Icons.edit),
                            onPressed: () {
                              print('lineees ID${depReqItem.linesId}');
                              _displayQuantityDialog(
                                  context,
                                  depReqItem.approvedQuantity,
                                  depReqItem.linesId,
                                  depReqItem.itemDesc);
                            },
                          )))
                          // Icon(Icons.arrow_forward_ios, color: Colors.blue),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
        Column(
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
                      borderSide: BorderSide(
                          color: ReColors().appMainColor, width: 2.0),
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
                padding: EdgeInsets.all(10),
                child: RaisedButton(
                    onPressed: () {
                      print('Accept ${getID},${h_id},${GettransID}');
                      postJSON().postRemark(
                          getID, h_id, 'A', GettransID, _controllers.text);
                      // _controllers[index].text
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                EapprovalByUSERID()),
                      );
                    },
                    color: ReColors().appMainColor,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Icon(
                            Icons.check_circle,
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
                padding: EdgeInsets.all(10),
                child: RaisedButton(
                    onPressed: () {
                      print('Reject ${getID},${h_id},${GettransID}');
                      postJSON().postRemark(
                          getID, h_id, 'R', GettransID, _controllers.text);
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                EapprovalByUSERID()),
                      );
                    },
                    color: ReColors().appMainColor,
                    child: Padding(
                      padding: EdgeInsets.all(5),
                      child: Column(
                        children: [
                          Icon(
                            Icons.cancel,
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
            ])),
          ],
        ),
      ],
    );
  }

  Widget CompleteWidget(transactionList) {
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          DetailsWidget(),
          AllListview(transactionList),
          widgetContainer(),
        ],
      ),
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
                      fromUser,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                    ),
                  )),
              Expanded(
                  child: Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: Text(
                    'Document No. ${doc_no.toString()}',
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
                  dep_name,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              )),
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: Text(
                  des_name,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ))
        ],
      ),
    );
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
            padding: EdgeInsets.all(5),
            child: RaisedButton(
                onPressed: () {
                  print('Accept ${getID},${h_id},${GettransID}');
                  postJSON().postRemark(
                      getID, h_id, 'A', GettransID, _controllers.text);
                  // _controllers[index].text
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => EapprovalByUSERID()),
                  );
                },
                color: ReColors().appMainColor,
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
            padding: EdgeInsets.all(5),
            child: RaisedButton(
                onPressed: () {
                  print('Reject ${getID},${h_id},${GettransID}');
                  postJSON().postRemark(
                      getID, h_id, 'R', GettransID, _controllers.text);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => EapprovalByUSERID()),
                  );
                },
                color: ReColors().appMainColor,
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
            padding: EdgeInsets.all(5),
            child: RaisedButton(
                onPressed: () {
                  print('Cancel ${getID},${h_id},${GettransID}');
                  postJSON().postRemark(
                      getID, h_id, 'C', GettransID, _controllers.text);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => EapprovalByUSERID()),
                  );
                },
                color: ReColors().appMainColor,
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

  Icon getMyIcon(String urgent) {
    if (urgent == 'Yes') {
      return Icon(
        Icons.check_circle,
        color: Colors.green,
        size: 20,
      );
    } else if (urgent == 'NO') {
      return Icon(
        Icons.cancel_rounded,
        color: Colors.red,
        size: 20,
      );
    }
  }

// NeverScrollableScrollPhysics use if you use listview inside singlescrollview....
  Widget AllListview(transactionList) {
    return ListView.builder(
        physics: NeverScrollableScrollPhysics(),
        primary: false,
        shrinkWrap: true,
        itemCount: null == transactionList ? 0 : transactionList.length,
        itemBuilder: (BuildContext context, int index) {
          DepReqItem depReqItem = transactionList[index];
          print('Result ${depReqItem}');
          return Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Container(
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
                      borderRadius: BorderRadius.circular(10.0),
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
                          Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                child: Text(
                                  depReqItem.itemDesc,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 16),
                                ),
                              )),
                          Expanded(
                              child: Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: IconButton(
                                color: Colors.white,
                                icon: new Icon(Icons.edit),
                                onPressed: () {
                                  print('lineees ID${depReqItem.linesId}');
                                  _displayQuantityDialog(
                                      context,
                                      depReqItem.approvedQuantity,
                                      depReqItem.linesId,
                                      depReqItem.itemDesc);
                                },
                              ),
                            ),
                          ))
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 3),
                            child: Text(
                              'Urgent',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          )),
                          Expanded(
                              child: Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 3),
                              child: getMyIcon(depReqItem.urgent),
                            ),
                          ))
                        ],
                      ),
                      Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                      tableWidget(
                          depReqItem.uomCode,
                          depReqItem.approvedQuantity,
                          depReqItem.requiredQuantity),
                      /*Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                            child: Text(
                              'UOM',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          )),
                          Expanded(
                              child: Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: Text(
                                depReqItem.uomCode.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ))
                        ],
                      ),
                      Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 4, 0, 0),
                            child: Text(
                              'Required Quantity',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          )),
                          Expanded(
                              child: Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 4, 10, 0),
                              child: Text(
                                depReqItem.requiredQuantity.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ))
                        ],
                      ),
                      Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 4, 0, 0),
                            child: Text(
                              'Approved Quantity',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          )),
                          Expanded(
                              child: Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 4, 10, 0),
                              child: Text(
                                depReqItem.approvedQuantity.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ))
                        ],
                      ),*/
                      Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 4, 0, 0),
                            child: Text(
                              'Need By Date',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          )),
                          Expanded(
                              child: Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 4, 10, 0),
                              child: Text(
                                '${getmonthName(depReqItem.needByDate.month)} ${depReqItem.needByDate.day}, ${depReqItem.needByDate.year}',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ))
                        ],
                      ),
                      Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 4, 0, 0),
                            child: Text(
                              'Note To Buyer',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          )),
                          Expanded(
                              child: Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 4, 10, 0),
                              child: Text(
                                depReqItem.noteToBuyer.toString(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ))
                        ],
                      ),
                      Divider(
                        height: 1,
                        color: Colors.grey,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Padding(
                            padding: const EdgeInsets.fromLTRB(10, 4, 0, 0),
                            child: Text(
                              'Justification',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            ),
                          )),
                          Expanded(
                              child: Align(
                            alignment: Alignment.topRight,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 4, 10, 0),
                              child: Text(
                                depReqItem.justification,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            ),
                          ))
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 0,
                )
              ],
            ),
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
    var someDateTime = new DateTime.now();
    mon = someDateTime.month;
    print(months[mon - 1]);
    return months[mon - 1];
  }
}
