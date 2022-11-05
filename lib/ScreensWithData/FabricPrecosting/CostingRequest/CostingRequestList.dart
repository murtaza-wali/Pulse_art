import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/Model/FPCmODEL/fpcBrandModel.dart';
import 'package:art/ParsingJSON/GetJSONMethod.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/CustomAppbarWithImage.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:art/ScreensWithData/Menu/MainMenuPopup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'CostingRequestForm.dart';

class CostingRequestList extends StatefulWidget {
  _CostingRequestListtate createState() => _CostingRequestListtate();
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
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      )
    ],
  );
}

class _CostingRequestListtate extends State<CostingRequestList> {
  List<Fpcbranditem> fpcBrandItemList = [];
  bool boxesvisible = false;
  int getID;
  String selected_unit_id;
  String employeCode;
  String selectedSpinnerItem;
  String username;
  DateTime now, date;
  TextEditingController titleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    now = new DateTime.now();
    date = new DateTime(now.year, now.month, now.day);
    MySharedPreferences.instance
        .getIntValue("UserId")
        .then((value) => setState(() {
              getID = value;
              print(getID);
              GetJSON().getFpcBrandModel().then((FpcBrand) {
                setState(() {
                  fpcBrandItemList = FpcBrand;
                  if (fpcBrandItemList.length == 0) {
                    // visible = false;
                    return showError(
                        'No data found', Icons.assignment_late_outlined);
                  } else {
                    selected_unit_id = fpcBrandItemList.first.baseBrand;
                    // visible = true;
                  }
                });
              });
            }));
    MySharedPreferences.instance
        .getStringValue("Username")
        .then((name) => setState(() {
              username = name;
            }));
  }

  Future<dynamic> _refreshMenu() async {
    return await GetJSON().getFpcBrandModel();
  }

  Widget chip(String label) {
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Willpopwidget().getWillScope(Scaffold(
        appBar: new CustomAppBarImage(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => MainMenuPopUp()),
            );
          },
          Title: 'Fabric PreCosting',
          image_bar: 'assets/images/denimcosting_logo.png',
          refreshonPressed: () {
            _refreshMenu().then((list) {
              setState(() {
                fpcBrandItemList = list;
                if (fpcBrandItemList.length == 0) {
                  // visible = false;
                  return showError(
                      'No data found', Icons.assignment_late_outlined);
                } else {
                  selected_unit_id = fpcBrandItemList.first.baseBrand;
                  // visible = true;
                }
              });
            });
          },
        ),
        body: DEtailsScreen()
        /*Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.all(4),
                                child: Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    'Request by: $username',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
                                        color: ReColors().appTextBlackColor,
                                        fontSize: 16,
                                        fontFamily: 'headingfont'),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(4),
                                child: Container(
                                  child: Row(
                                    children: [
                                      Align(
                                          alignment: Alignment.topLeft,
                                          child: Padding(
                                            padding: EdgeInsets.fromLTRB(
                                                10, 3, 0, 3),
                                            child: Text(
                                              'Date: ${date.day}-${date.month}-${date.year}',
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 16,
                                                fontFamily: 'headingfont',
                                              ),
                                            ),
                                          )),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 3, 10, 3),
                                          child: Text(
                                            'Status: Draft',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 16,
                                              fontFamily: 'headingfont',
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.all(5),
                        child: FutureBuilder<List<Fpcbranditem>>(
                          future: GetJSON().getFpcBrandModel(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return CustomDropdown(
                                dropdownMenuItemList:
                                    fpcBrandItemList.map((item) {
                                          return DropdownMenuItem(
                                            child: chip(item.baseBrand),
                                            value: item.baseBrand,
                                            onTap: () {
                                              selected_unit_id = item.baseBrand;
                                              print(
                                                  'Selected UNit ID: ${selected_unit_id}');
                                              print(
                                                  'selectedSpinnerItem3293: ${selectedSpinnerItem.toString()}');
                                            },
                                          );
                                        }).toList() ??
                                        [],
                                onChanged: (newVal) {
                                  setState(() {
                                    selectedSpinnerItem = newVal;
                                    boxesvisible = true;
                                    print(
                                        'selected_unit_id test: ${selected_unit_id.toString()}');
                                    print(
                                        'selectedSpinnerItem test: ${selectedSpinnerItem.toString()}');
                                  });
                                },
                                value: selectedSpinnerItem,
                                isEnabled: true,
                                color: ReColors().appMainColor,
                                hint: 'Brands',
                              );
                            } else if (snapshot.hasError) {
                              if (snapshot.error is HttpException) {
                                HttpException httpException =
                                    snapshot.error as HttpException;
                                return showError(
                                    'An http error occurred.Page not found. Please try again.',
                                    Icons.error);
                              }
                              if (snapshot.error is NoInternetException) {
                                NoInternetException noInternetException =
                                    snapshot.error as NoInternetException;
                                return showError(
                                    'Please check your internet connection',
                                    Icons
                                        .signal_wifi_connected_no_internet_4_sharp);
                              }
                              if (snapshot.error is NoServiceFoundException) {
                                NoServiceFoundException
                                    noServiceFoundException =
                                    snapshot.error as NoServiceFoundException;
                                return showError('Server Error.', Icons.error);
                              }
                              if (snapshot.error is InvalidFormatException) {
                                InvalidFormatException invalidFormatException =
                                    snapshot.error as InvalidFormatException;
                                return showError(
                                    'There is a problem with your request.',
                                    Icons.error);
                              }
                              if (snapshot.error is SocketException) {
                                SocketException socketException =
                                    snapshot.error as SocketException;
                                print(
                                    'Socket checking: ${socketException.message}');
                                return showError(
                                    'Please check your internet connection',
                                    Icons
                                        .signal_wifi_connected_no_internet_4_sharp);
                              } else {
                                UnknownException unknownException =
                                    snapshot.error as UnknownException;
                                return showError(
                                    'An Unknown error occurred.', Icons.error);
                              }
                            }
                            return Center(
                                child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  ReColors().appMainColor),
                            ));
                          },
                        )),
                    TextField(
                      style: TextStyle(
                          color: ReColors().appMainColor,
                          fontFamily: 'headingfont'),
                      controller: titleController,
                      decoration: InputDecoration(
                        fillColor: ReColors().appMainColor,
                        enabledBorder: new OutlineInputBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                          borderSide:
                              BorderSide(color: ReColors().appMainColor),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              color: Color(0xff055e8e), width: 2.0),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        labelText: 'Title',
                        labelStyle: TextStyle(
                            color: Color(0xff055e8e),
                            fontFamily: 'headingfont'),
                      ),
                      onChanged: (addresstext) {
                        setState(() {});
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),*/
        ));
  }

  Widget DEtailsScreen() {
    return Container(
      child: SingleChildScrollView(
        child:
            //Main Container
            Container(
          child: Column(
            children: [
              //button
              Padding(
                padding: EdgeInsets.all(10),
                child: RaisedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  CostingRequestForm()),
                          (Route<dynamic> route) => false);
                    },
                    color: ReColors().appMainColor,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "New Request",
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'headerfont'),
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.all(5),
                child: Container(
                  padding: EdgeInsets.all(7),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: ReColors().appMainColor,
                    ),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  child: Column(
                    children: [
                      //article
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              'Request Date',
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
                                '-',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              'Cost Sheet',
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
                                '-',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              'Title',
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
                                '-',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              'Status',
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
                                '-',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              'Brand',
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
                                '',
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Text(
                              'Approved Date',
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
                                '-',
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
