import 'dart:io';

import 'package:art/InternetConnection/Offline.dart';
import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/Model/ipolicyModel.dart';
import 'package:art/ParsingJSON/GetJSONMethod.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/CustomAppbarWithImage.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:art/ScreensWithData/Menu/MainMenuPopup.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';
import 'package:art/Error/Error.dart';

import 'PolicyHub.dart';

class IPolicyHub extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _IPolicyHubstate();
}

class _IPolicyHubstate extends State<IPolicyHub> {
  List<IPolicyitem> iPolicyList = [];
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
    super.initState();
    progressDialog = new ProgressDialog(context);
    MySharedPreferences.instance
        .getIntValue("UserId")
        .then((value) => setState(() {
              getID = value;
              print(getID);
              GetJSON().getiPolicy(getID).then((users) {
                setState(() {
                  iPolicyList = users;
                  if (iPolicyList.length == 0) {
                    return showError(
                        'No data found', Icons.assignment_late_outlined);
                  }
                });
              });
            }));
  }

  Future<dynamic> _refreshMenu() async {
    return await GetJSON().getiPolicy(getID);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new CustomAppBarImage(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => MainMenuPopUp()),
            );
          },
          Title: 'POLICY HUB',
          image_bar: 'assets/images/policymanage_logo.png',
          refreshonPressed: () {
            _refreshMenu().then((list) => setState(() {
                  iPolicyList = list;
                  print(iPolicyList.length);
                }));
          },
        ),
        body: Willpopwidget().getWillScope(
            ReuseOffline().getoffline(FutureBuilder<List<IPolicyitem>>(
          future: GetJSON().getiPolicy(getID),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              iPolicyList = snapshot.data;
              if (iPolicyList.length == 0) {
                return Center(
                  child: Text(
                    "No Data Found",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                );
              } else {
                return CompleteWidget(iPolicyList);
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
    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Expanded(child: _groupedListView(transactionList)),
        ],
      ),
    );
  }

  Widget _groupedListView(List<IPolicyitem> _gplist1) {
    return Padding(
        padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
        child: StickyGroupedListView<IPolicyitem, int>(
          elements: _gplist1,
          order: StickyGroupedListOrder.DESC,
          groupBy: (IPolicyitem element) => element.categoryId,
          groupComparator: (int value1, int value2) => value2.compareTo(value1),
          itemComparator: (IPolicyitem element1, IPolicyitem element2) =>
              element1.subcat.compareTo(element2.subcat),
          floatingHeader: true,
          groupSeparatorBuilder: (IPolicyitem value) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              color: Colors.white,
              child: Text(
                value.categoryTitle,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: ReColors().appButtonColor),
              ),
            ),
          ),
          itemBuilder: (c, element) {
            return Card(
              elevation: 4.0,
              margin: EdgeInsets.symmetric(horizontal: 2.0, vertical: 2.0),
              child: InkWell(
                onTap: () {
                  print('cdt: ${element.cdt}');
                  print('doc no: ${element.docNo}');
                  print('attachment file: ${element.attachmentFile}');
                  MySharedPreferences.instance
                      .setStringValue('cdt', element.cdt);
                  MySharedPreferences.instance
                      .setStringValue('docNo', element.docNo);
                  MySharedPreferences.instance
                      .setStringValue('attachmentFile', element.attachmentFile);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => policyhub()),
                      (Route<dynamic> route) => false);
                },
                child: Container(
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                    leading: Icon(Icons.picture_as_pdf,color: ReColors().appMainColor,),
                    title: Text(element.title),
                  ),
                ),
              ),
            );
          },
        ));
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
}
