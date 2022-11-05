import 'dart:io';

import 'package:art/APIUri/BaseUrl.dart';
import 'package:art/Error/Error.dart';
import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/Model/FPCmODEL/FpcSeasonModel.dart';
import 'package:art/Model/FPCmODEL/fpcBrandModel.dart';
import 'package:art/Model/FPCmODEL/fpcForwardToModel.dart';
import 'package:art/Model/FPCmODEL/fpcglobalparamModel.dart';
import 'package:art/ParsingJSON/GetJSONMethod.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/CustomAppbarWithImage.dart';
import 'package:art/ReuseableWidget/CustomDropdown.dart';
import 'package:art/ReuseableWidget/StaticDropdown.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../FabricCostingBottom.dart';

class CostingRequestForm extends StatefulWidget {
  _CostingRequestFormtate createState() => _CostingRequestFormtate();
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

class _CostingRequestFormtate extends State<CostingRequestForm>
    with SingleTickerProviderStateMixin {
  List<Fpcbranditem> fpcBrandItemList = [];
  List<Fpcseasonitem> fpcSeasonItemList = [];
  List<Globalparamitem> fpcglobalParamItemList = [];
  List<Forwardtoitem> fpcForwardToItemList = [];
  bool boxesvisible = false;
  int getID;
  String selected_unit_id, selected_season_code;
  int selected_userID;
  int header_id, h_seq;
  String employeCode;
  String selectedSpinnerItem, selectedSeasonItem, selectedForwardUserID;
  String username;
  DateTime now, date;
  TextEditingController titleController = TextEditingController();
  TextEditingController commentController = TextEditingController();
  TextEditingController programController = TextEditingController();
  TextEditingController expectedVolumeController = TextEditingController();
  TextEditingController targetPriceController = TextEditingController();
  TextEditingController _todateController = TextEditingController();
  DateTime toselectedDate = DateTime.now();
  String todateTime;
  bool forward_visibility = false;
  DateTime selectedDate;
  DateTime initialDate;
  bool pickerIsExpanded = false;
  int _pickerYear = DateTime.now().year;
  DateTime _selectedMonth = DateTime(
    DateTime.now().year,
    DateTime.now().month,
    1,
  );

  dynamic _pickerOpen = false;

  void switchPicker() {
    setState(() {
      _pickerOpen ^= true;
    });
  }

  List<Widget> generateRowOfMonths(from, to) {
    List<Widget> months = [];
    for (int i = from; i <= to; i++) {
      DateTime dateTime = DateTime(_pickerYear, i, 1);
      final backgroundColor = dateTime.isAtSameMomentAs(_selectedMonth)
          ? Theme.of(context).focusColor
          : Colors.transparent;
      months.add(
        AnimatedSwitcher(
          duration: kThemeChangeDuration,
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: TextButton(
            key: ValueKey(backgroundColor),
            onPressed: () {
              setState(() {
                _selectedMonth = dateTime;
              });
            },
            style: TextButton.styleFrom(
              backgroundColor: backgroundColor,
              shape: CircleBorder(),
            ),
            child: Text(
              DateFormat('MMM').format(dateTime),
            ),
          ),
        ),
      );
    }
    return months;
  }

  List<Widget> generateMonths() {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: generateRowOfMonths(1, 4),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: generateRowOfMonths(5, 8),
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: generateRowOfMonths(9, 12),
      ),
    ];
  }

  @override
  void initState() {
    super.initState();
    _todateController.text = DateFormat.yMd().format(DateTime.now());
    now = new DateTime.now();
    date = new DateTime(now.year, now.month, now.day);
    MySharedPreferences.instance.getIntValue("UserId").then((value) =>
        setState(() {
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
          GetJSON().getFpcSeasonModel().then((FpcSeason) {
            setState(() {
              fpcSeasonItemList = FpcSeason;
              if (fpcSeasonItemList.length == 0) {
                // visible = false;
                return showError(
                    'No data found', Icons.assignment_late_outlined);
              } else {
                selected_season_code = fpcSeasonItemList.first.seasonName;
                // visible = true;
              }
            });
          });
          GetJSON().getFpcGlobalParamModel(getID).then((Fpcglobalparam) {
            setState(() {
              fpcglobalParamItemList = Fpcglobalparam;
              if (fpcglobalParamItemList.length == 0) {
                // visible = false;
                return showError(
                    'No data found', Icons.assignment_late_outlined);
              } else {
                header_id = fpcglobalParamItemList.first.headerId;
                h_seq = fpcglobalParamItemList.first.hSeq;
                print('fpcglobalParamItemList${header_id}------${h_seq}');
                if (h_seq == null) {
                  forward_visibility = false;
                } else {
                  forward_visibility = true;
                  GetJSON().getFpcForwardToModel(h_seq).then((Fpcglobalparam) {
                    setState(() {
                      fpcForwardToItemList = Fpcglobalparam;
                      if (fpcForwardToItemList.length == 0) {
                        // visible = false;
                        return showError(
                            'No data found', Icons.assignment_late_outlined);
                      } else {
                        selected_userID = fpcForwardToItemList.first.userId;
                        print(
                            'fpcForwardToItemList${fpcForwardToItemList.first.userId}---${fpcForwardToItemList.first.fndEmpnameAppsMUserId}');
                        // visible = true;
                      }
                    });
                  });
                }
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

  Future<Null> _toselectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: toselectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        toselectedDate = picked;
        _todateController.text = DateFormat.yMd().format(toselectedDate);
      });
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
            "${label}",
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
                  builder: (BuildContext context) =>
                      FabricCostingBottomNavBar()),
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
        body: DEtailsScreen()));
  }

  Future<List<Fpcbranditem>> getBrand(filter) async {
    var result = await Dio().get(
      BaseURL().NewAuth + "traceability/brands",
      queryParameters: {"filter": filter},
    );
    var parse = result.data;
    var data = parse["items"] as List;
    if (data != null) {
      return Fpcbranditem.fromJsonList(data);
    }

    return [];
  }

  Widget DEtailsScreen() {
    return Container(
      child: SingleChildScrollView(
        //Main Container
        child: Container(
          child: Column(
            children: [
              //Request Container
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
                      // request by text
                      Text(
                        'Request by: $username',
                        style: TextStyle(
                            color: ReColors().appTextBlackColor,
                            fontSize: 16,
                            fontFamily: 'headingfont'),
                      ),
                      //Row of date and Status
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Date: ${date.day}-${date.month}-${date.year}',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: ReColors().appTextBlackColor,
                                fontSize: 16,
                                fontFamily: 'headingfont'),
                          ),
                          Text(
                            'Status: Draft',
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                color: ReColors().appTextBlackColor,
                                fontSize: 16,
                                fontFamily: 'headingfont'),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 7, 0, 5),
                        child: TextField(
                          style: TextStyle(
                              color: ReColors().appMainColor,
                              fontFamily: 'headingfont'),
                          controller: programController,
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
                            labelText: 'Program',
                            labelStyle: TextStyle(
                                color: Color(0xff055e8e),
                                fontFamily: 'headingfont'),
                          ),
                          onChanged: (addresstext) {
                            setState(() {});
                          },
                        ),
                      ),
                      //Brand DropDown
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
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
                                                selected_unit_id =
                                                    item.baseBrand;
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
                                  return showError(
                                      'Server Error.', Icons.error);
                                }
                                if (snapshot.error is InvalidFormatException) {
                                  InvalidFormatException
                                      invalidFormatException =
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
                      //validity date
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Expanded(
                            child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Validity',
                                  style: TextStyle(
                                    color: ReColors().appMainColor,
                                    fontFamily: 'titlefont',
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                _toselectDate(context);
                              },
                              child: Container(
                                  padding: EdgeInsets.all(5.0),
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    enabled: false,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                        fontFamily: 'titlefont',
                                        fontSize: 15.0,
                                        color: Colors.white),
                                    controller: _todateController,
                                    onSaved: (String val) {
                                      todateTime = val;
                                    },
                                    autocorrect: true,
                                    decoration: InputDecoration(
                                      prefixIcon: Icon(
                                          Icons.calendar_today_rounded,
                                          color: ReColors().appTextWhiteColor),
                                      hintStyle: TextStyle(color: Colors.grey),
                                      filled: true,
                                      fillColor: ReColors().appMainColor,
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12.0)),
                                        borderSide: BorderSide(
                                            color: Colors.green, width: 2),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.0)),
                                        borderSide: BorderSide(
                                            color: Colors.green, width: 2),
                                      ),
                                    ),
                                  )),
                            )
                          ],
                        )),
                      ),
                      //Season DropDown
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                          child: FutureBuilder<List<Fpcseasonitem>>(
                            future: GetJSON().getFpcSeasonModel(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return CustomDropdown(
                                  dropdownMenuItemList:
                                      fpcSeasonItemList.map((item) {
                                            return DropdownMenuItem(
                                              child: chip(item.seasonName),
                                              value: item.seasonName,
                                              onTap: () {
                                                selected_season_code =
                                                    item.seasonName;
                                                print(
                                                    'Selected UNit ID: ${selected_season_code}');
                                                print(
                                                    'selectedSeasonItem3293: ${selectedSeasonItem.toString()}');
                                              },
                                            );
                                          }).toList() ??
                                          [],
                                  onChanged: (newVal) {
                                    setState(() {
                                      selectedSeasonItem = newVal;
                                      boxesvisible = true;
                                      print(
                                          'selectedSeasonItem test: ${selectedSeasonItem.toString()}');
                                    });
                                  },
                                  value: selectedSeasonItem,
                                  isEnabled: true,
                                  color: ReColors().appMainColor,
                                  hint: 'Season',
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
                                  return showError(
                                      'Server Error.', Icons.error);
                                }
                                if (snapshot.error is InvalidFormatException) {
                                  InvalidFormatException
                                      invalidFormatException =
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
                      //forward to DropDown
                      Visibility(
                          visible: forward_visibility,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                              child: FutureBuilder<List<Forwardtoitem>>(
                                future: GetJSON().getFpcForwardToModel(h_seq),
                                builder: (context, snapshot) {
                                  if (snapshot.hasData) {
                                    return CustomDropdown(
                                      dropdownMenuItemList: fpcForwardToItemList
                                              .map((item) {
                                            return DropdownMenuItem(
                                              child: chip(
                                                  item.fndEmpnameAppsMUserId),
                                              value: item.fndEmpnameAppsMUserId,
                                              onTap: () {
                                                selected_userID = item.userId;
                                                print(
                                                    'Selected UNit ID: ${selected_userID}');
                                                print(
                                                    'selectedSpinnerItem3293: ${selectedForwardUserID.toString()}');
                                              },
                                            );
                                          }).toList() ??
                                          [],
                                      onChanged: (newVal) {
                                        setState(() {
                                          selectedForwardUserID = newVal;
                                          boxesvisible = true;
                                          print(
                                              'selected_unit_id test: ${selected_userID.toString()}');
                                          print(
                                              'selectedSpinnerItem test: ${selectedForwardUserID.toString()}');
                                        });
                                      },
                                      value: selectedSpinnerItem,
                                      isEnabled: true,
                                      color: ReColors().appMainColor,
                                      hint: 'Forward To',
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
                                    if (snapshot.error
                                        is NoServiceFoundException) {
                                      NoServiceFoundException
                                          noServiceFoundException = snapshot
                                              .error as NoServiceFoundException;
                                      return showError(
                                          'Server Error.', Icons.error);
                                    }
                                    if (snapshot.error
                                        is InvalidFormatException) {
                                      InvalidFormatException
                                          invalidFormatException = snapshot
                                              .error as InvalidFormatException;
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
                                          'An Unknown error occurred.',
                                          Icons.error);
                                    }
                                  }
                                  return Center(
                                      child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        ReColors().appMainColor),
                                  ));
                                },
                              ))),
                    ],
                  ),
                ),
              ),
              //Selection Container
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
                      //Article Dropdown
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: DropdownSearch<Fpcbranditem>(
                          mode: Mode.BOTTOM_SHEET,
                          onFind: (String filter) => getBrand(filter),
                          itemAsString: (Fpcbranditem u) => u.userAsString(),
                          dropdownSearchDecoration: InputDecoration(
                            labelText: "Article",
                            contentPadding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                            border: OutlineInputBorder(
                                borderSide: BorderSide(
                              color: ReColors().appMainColor,
                              width: 1,
                            )),
                          ),
                          onChanged: (Fpcbranditem data) {
                            setState(() {
                              selectedSpinnerItem = data.baseBrand;
                              print('Article Namwe${selectedSpinnerItem}');
                            });
                          },
                          showSearchBox: true,
                          searchFieldProps: TextFieldProps(
                            style: TextStyle(color: ReColors().appMainColor),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: ReColors().appMainColor,
                                    width: 1,
                                  )),
                              contentPadding: EdgeInsets.fromLTRB(12, 12, 8, 0),
                              labelText: "Article",
                            ),
                          ),
                        ),
                      )
                      /*Padding(
                          padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
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
                                                print('Selected UNit ID: ${selected_unit_id}');
                                                print('selectedSpinnerItem3293: ${selectedSpinnerItem.toString()}');
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
                                  hint: 'Article',
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
                                  return showError(
                                      'Server Error.', Icons.error);
                                }
                                if (snapshot.error is InvalidFormatException) {
                                  InvalidFormatException
                                      invalidFormatException =
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
                          ))*/
                      ,
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 7, 0, 5),
                        child: Dropdown('Inquiry Type', [
                          'New',
                          'Repeat',
                        ]),
                      ),
//production month

                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                        child: Expanded(
                            child: Column(
                          children: [
                            Material(
                              color: Theme.of(context).cardColor,
                              child: AnimatedSize(
                                curve: Curves.easeInOut,
                                vsync: this,
                                duration: Duration(milliseconds: 300),
                                child: Container(
                                  height: _pickerOpen ? null : 0.0,
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _pickerYear = _pickerYear - 1;
                                              });
                                            },
                                            icon: Icon(
                                                Icons.navigate_before_rounded),
                                          ),
                                          Expanded(
                                            child: Center(
                                              child: Text(
                                                _pickerYear.toString(),
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              setState(() {
                                                _pickerYear = _pickerYear + 1;
                                              });
                                            },
                                            icon: Icon(
                                                Icons.navigate_next_rounded),
                                          ),
                                        ],
                                      ),
                                      ...generateMonths(),
                                      SizedBox(
                                        height: 10.0,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            Padding(
                              padding: EdgeInsets.all(5),
                              child: Align(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  'Production Mode',
                                  style: TextStyle(
                                    color: ReColors().appMainColor,
                                    fontFamily: 'titlefont',
                                  ),
                                ),
                              ),
                            ),
                            Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(5),
                                child: ElevatedButton.icon(
                                  onPressed: switchPicker,
                                  label: Text(DateFormat.yMMMM()
                                      .format(_selectedMonth)),
                                  icon: Icon(Icons.calendar_today_sharp),
                                  style: ElevatedButton.styleFrom(
                                    primary: ReColors().appMainColor,
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontFamily: 'titlefont',
                                    ),
                                  ),
                                )),
                          ],
                        )),
                      ),
//moq
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 7, 0, 5),
                        child: TextField(
                          style: TextStyle(
                              color: ReColors().appMainColor,
                              fontFamily: 'headingfont'),
                          controller: expectedVolumeController,
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
                            labelText: 'Expected Volume',
                            labelStyle: TextStyle(
                                color: Color(0xff055e8e),
                                fontFamily: 'headingfont'),
                          ),
                          onChanged: (addresstext) {
                            setState(() {});
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 7, 0, 5),
                        child: Dropdown('UoM', [
                          'Pieces',
                          'Yards',
                        ]),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 7, 0, 5),
                        child: TextField(
                          style: TextStyle(
                              color: ReColors().appMainColor,
                              fontFamily: 'headingfont'),
                          controller: targetPriceController,
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
                            labelText: 'Target Price',
                            labelStyle: TextStyle(
                                color: Color(0xff055e8e),
                                fontFamily: 'headingfont'),
                          ),
                          onChanged: (addresstext) {
                            setState(() {});
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 7, 0, 5),
                        child: TextField(
                          style: TextStyle(
                              color: ReColors().appMainColor,
                              fontFamily: 'headingfont'),
                          controller: commentController,
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
                            labelText: 'Comment',
                            labelStyle: TextStyle(
                                color: Color(0xff055e8e),
                                fontFamily: 'headingfont'),
                          ),
                          onChanged: (addresstext) {
                            setState(() {});
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10),
                        child: RaisedButton(
                            onPressed: () {},
                            color: ReColors().appMainColor,
                            child: Padding(
                              padding: EdgeInsets.all(8),
                              child: Text(
                                "SELECT",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'headerfont'),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
              //List Container
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
                              'Mill Code',
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
                                'AMX-380-I-MR-FLASH-BLUE-OD',
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
                              'Article',
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
                                'AMX-380-I-MR-FLASH-BLUE-OD',
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
                              'Sample Refrence',
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
                              'Weave',
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
                                '3/1 RHT',
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
                              'Oz.',
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
                                '11.00',
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
                              'Cut Width"',
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
                                '61',
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
                              'Composition',
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
                                '100% Contton',
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
                              'Comment',
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
                                '1,1',
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
                              'Production Month',
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
                                '3.5',
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
                              'Expected Volume',
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
                                '3.5',
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
                              'UoM',
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
                                '3.5',
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
                              'Target Price',
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
                                '3.5',
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
              //button
              Padding(
                padding: EdgeInsets.all(10),
                child: RaisedButton(
                    onPressed: () {},
                    color: ReColors().appMainColor,
                    child: Padding(
                      padding: EdgeInsets.all(8),
                      child: Text(
                        "Request",
                        style: TextStyle(
                            color: Colors.white, fontFamily: 'headerfont'),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
