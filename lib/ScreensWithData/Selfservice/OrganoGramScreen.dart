import 'dart:io';

import 'package:art/Error/Error.dart';
import 'package:art/InternetConnection/Offline.dart';
import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/Model/employeehierarchy.dart';
import 'package:art/Model/level_model.dart';
import 'package:art/ParsingJSON/GetJSONMethod.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/CustomAppbarWidget.dart';
import 'package:art/ReuseableWidget/CustomDropdown.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:art/ScreensWithData/Menu/MainMenuPopup.dart';
import 'package:art/ScreensWithData/Selfservice/UserProfile.dart';
import 'package:flutter/material.dart';

class Organogram extends StatefulWidget {
  @override
  _OrganogramPageState createState() => _OrganogramPageState();
}

class _OrganogramPageState extends State<Organogram> {
  List<EmployeeHierarchyitem> hierarchyList = [];
  List<Items> hierarchylevelList = [];
  String selectedItem = 'Select Level';
  String EMPLOYEEcODE;
  var hexDeocde;
  bool listvisibility = false;
  bool dropdownvisibility = false;
  int Level_num;

  @override
  void initState() {
    super.initState();

    MySharedPreferences.instance.getStringValue("employeecode").then((value) {
      if (mounted == true) {
        setState(() {
          EMPLOYEEcODE = value;
          print('Employee: ${EMPLOYEEcODE}');
          GetJSON().getHierarchyLevel(EMPLOYEEcODE).then((users) {
            setState(() {
              hierarchylevelList = users;
              if (hierarchylevelList.length == 0) {
                dropdownvisibility = false;
                return showError(
                    'No data found', Icons.assignment_late_outlined);
              } else {
                Level_num = hierarchylevelList.first.lvlNum;
                print('Level number : : ${Level_num}');
                dropdownvisibility = true;
                GetJSON()
                    .getEmployeeHierarchyLevel(EMPLOYEEcODE, Level_num)
                    .then((value) {
                  hierarchyList = value;
                });
              }
            });
          });
        });
      }
    });
  }

  Future<dynamic> _refreshMenu() async {
    return await GetJSON().getEmployeeHierarchyLevel(EMPLOYEEcODE, Level_num);
  }

  @override
  Widget build(BuildContext context) {
    return Willpopwidget().getWillScope(Scaffold(
      backgroundColor: Colors.white,
      appBar: new CustomAppBar(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MainMenuPopUp()),
          );
        },
        Title: 'Organogram',
        refreshonPressed: () {
          _getData();
        },
      ),
      body: Column(
        children: [
          Expanded(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Visibility(
                    visible: dropdownvisibility,
                    child: CustomDropdown(
                      dropdownMenuItemList: hierarchylevelList.map((item) {
                            return DropdownMenuItem(
                              child: chip(item.lvlNum),
                              value: item.lvlNum,
                              onTap: () {
                                Level_num = item.lvlNum;
                              },
                            );
                          }).toList() ??
                          [],
                      onChanged: (newVal) {
                        setState(() {
                          Level_num = newVal;
                          hierarchyList.clear();
                          print('spinnerID: ${Level_num}');
                          print('spinnerID12312: ${Level_num.toString()}');
                          GetJSON()
                              .getEmployeeHierarchyLevel(
                                  EMPLOYEEcODE, Level_num)
                              .then((value) {
                            hierarchyList = value;
                          });
                        });
                      },
                      value: Level_num,
                      isEnabled: true,
                      color: ReColors().appMainColor,
                      hint: '',
                    ),
                  ),
                ),
                Expanded(
                    child: FutureBuilder<List<EmployeeHierarchyitem>>(
                  future: GetJSON()
                      .getEmployeeHierarchyLevel(EMPLOYEEcODE, Level_num),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (snapshot.hasError) {
                      if (snapshot.error is HttpException) {
                        return showError(
                            'An http error occurred. Page not found. Please try again.',
                            Icons.error);
                      }
                      if (snapshot.error is NoInternetException) {
                        return showError(
                            'Please check your internet connection',
                            Icons.signal_wifi_connected_no_internet_4_sharp);
                      }
                      if (snapshot.error is NoServiceFoundException) {
                        return showError('Server Error.', Icons.error);
                      }
                      if (snapshot.error is InvalidFormatException) {
                        return showError(
                            'There is a problem with your request.',
                            Icons.error);
                      }
                      if (snapshot.error is SocketException) {
                        SocketException socketException =
                            snapshot.error as SocketException;
                        return showError(
                            'Please check your internet connection',
                            Icons.signal_wifi_connected_no_internet_4_sharp);
                      } else {
                        return showError(
                            'An Unknown error occurred.', Icons.error);
                      }
                    } else {
                      if (hierarchyList.length == 0) {
                        _getData();
                        if (hierarchyList == 0) {
                          return showError(
                              'No data', Icons.assignment_late_outlined);
                        } else {
                          return HierarchyView(hierarchyList);
                        }
                      } else {
                        return HierarchyView(hierarchyList);
                      }
                    }
                  },
                ))
              ],
            ),
          )
        ],
      ),
    ));
  }

  Widget chip(int label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Text(
            'Rank ' + label.toString(),
            style: TextStyle(
              color: ReColors().appMainColor,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _getData() async {
    _refreshMenu().then((list) => setState(() {
          hierarchyList = list;
        }));
  }

  Widget HierarchyView(List<EmployeeHierarchyitem> hierarchyList1) {
    return RefreshIndicator(
      onRefresh: _getData,
      child: Container(
          child: SingleChildScrollView(
              child: ListView.builder(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        primary: false,
        shrinkWrap: true,
        itemCount: null == hierarchyList1 ? 0 : hierarchyList1.length,
                itemBuilder: (BuildContext context, int index) {
          EmployeeHierarchyitem employeeHierarchyitem1 = hierarchyList1[index];
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(-0.9, -1),
                end: Alignment(-0.1, -0),
                colors: [ReColors().appTextWhiteColor, Colors.white54],
              ),
              color: Colors.white,
              borderRadius: BorderRadius.circular(0.0),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Text(
                        '${employeeHierarchyitem1.employeeName}',
                        textAlign: TextAlign.left,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                            fontFamily: 'headingfont',
                            color: ReColors().appMainColor),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          );
        },
      ))),
    );
  }
}
