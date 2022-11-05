import 'dart:io';

import 'package:art/Error/Error.dart';
import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/Model/employee_training_model.dart';
import 'package:art/Model/trainingList.dart';
import 'package:art/ParsingJSON/GetJSONMethod.dart';
import 'package:art/ParsingJSON/PostJSONMethod.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/CustomDropdown.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:art/ScreensWithData/DAMScreens/DAMMain.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class TabScreen extends StatelessWidget {
  TabScreen(this.listType);

  final String listType;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(primarySwatch: Colors.blue),
        home: Attendance());
  }
}

class Attendance extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AttendanceState();
}

class _AttendanceState extends State<Attendance> {
  List<TrainingListitem> training_list = [];
  List<EmployeeTrainingitems> datalist = [];
  int spinnerId;
  String selectedSpinnerItem;
  bool visible = false;
  int UserID;
  bool status_check = false;

  @override
  void initState() {
    super.initState();
    if (!mounted) return;
    GetJSON().getTrainingList().then((list) {
      training_list = list;
      print('list type item: ${training_list.length}');
      if (training_list.length == 0) {
        visible = false;
        return showError('No data found', Icons.assignment_late_outlined);
      } else {
        selectedSpinnerItem = training_list.first.trainingTitle;
        spinnerId = training_list.first.scheduleId;
        print('spinnerId: ${spinnerId}');
        print('selectedSpinnerItem: ${selectedSpinnerItem}');
        GetJSON().getEmployeeTrainingid(spinnerId).then((value) {
          datalist = value;
          print('sdbnsdn ${datalist.length}');
        });
        _refreshMenu().then((list) => setState(() {
              training_list = list;
            }));
        visible = true;
      }
    });
    MySharedPreferences.instance
        .getIntValue("UserId")
        .then((value) => setState(() {
              UserID = value;
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Willpopwidget().getWillScope(
      Scaffold(
        body: profileView(),
      ),
    );
  }

  Widget chip(String label) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            maxLines: 3,
            style: TextStyle(
              color: ReColors().appMainColor,
            ),
          ),
        ),
      ],
    );
  }

  Widget profileView() {
    return Container(
      child: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(10),
        child: visible == false
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Visibility(
                visible: visible,
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
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 5, 20, 14),
                            child: Container(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 8, 10, 10),
                                          child: Text(
                                            'Training Attendance',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18,
                                                fontFamily: 'headerfont'),
                                          ),
                                        ),
                                      )),
                                    ],
                                  ),
                                  CustomDropdown(
                                    dropdownMenuItemList:
                                        training_list.map((item) {
                                              return DropdownMenuItem(
                                                child: chip(
                                                  item.trainingTitle,
                                                ),
                                                value: item.trainingTitle,
                                                onTap: () {
                                                  datalist.clear();
                                                  spinnerId = item.scheduleId;
                                                  print(
                                                      'Selected UNit ID: ${spinnerId}');
                                                  print(
                                                      'selectedSpinnerItem3293: ${selectedSpinnerItem.toString()}');
                                                },
                                              );
                                            }).toList() ??
                                            [],
                                    onChanged: (newVal) {
                                      setState(() {
                                        selectedSpinnerItem = newVal;
                                        print(
                                            'spinnerID: ${selectedSpinnerItem}');
                                        print(
                                            'spinnerID12312: ${spinnerId.toString()}');
                                        print('DataLIst: ${datalist.length}');
                                        GetJSON()
                                            .getEmployeeTrainingid(spinnerId)
                                            .then((value) {
                                          datalist = value;
                                          visible = true;
                                          print('DataL123: ${datalist.length}');
                                        });
                                      });
                                    },
                                    value: selectedSpinnerItem,
                                    isEnabled: true,
                                    color: ReColors().appMainColor,
                                    hint: '',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FittedBox(
                      child: FutureBuilder<List<EmployeeTrainingitems>>(
                        future: GetJSON().getEmployeeTrainingid(spinnerId),
                        builder: (context, snapshot) {
                          print(
                              'Connection State: ${snapshot.connectionState}');
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
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
                                  Icons
                                      .signal_wifi_connected_no_internet_4_sharp);
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
                                  Icons
                                      .signal_wifi_connected_no_internet_4_sharp);
                            } else {
                              return showError(
                                  'An Unknown error occurred.', Icons.error);
                            }
                          } else {
                            print('len data: ${datalist.length}');
                            print('Snapshot data: ${snapshot.data.length}');
                            datalist = snapshot.data;
                            if (snapshot.data.length == 0) {
                              return showError(
                                  'No data', Icons.assignment_late_outlined);
                            } else {
                              print('DataLIst13232: ${datalist.length}');
                              return table(datalist);
                            }
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(child: Row(children: <Widget>[])),
                  ],
                )),
      )),
    );
  }

  Future<dynamic> _refreshMenu() async {
    return await GetJSON().getTrainingList();
  }

  int selectedIndex = -1;
  String Status_, enroll_id_, name_, enroll_code_;

  Widget table(List<EmployeeTrainingitems> list) {
    return Container(
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
          scrollDirection: Axis.vertical,
          child: DataTable(
              sortColumnIndex: 0,
              dividerThickness: 2,
              headingTextStyle: TextStyle(
                  color: Colors.white, fontFamily: 'headerfont', fontSize: 15),
              showCheckboxColumn: false,
              dataRowHeight: 60,
              headingRowColor: MaterialStateColor.resolveWith(
                  (states) => ReColors().appMainColor),
              headingRowHeight: 40,
              horizontalMargin: 10,
              columns: <DataColumn>[
                DataColumn(
                  label: Text(
                    'Employee Code',
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Employee Name',
                    overflow: TextOverflow.ellipsis,
                    softWrap: false,
                  ),
                ),
                DataColumn(
                  label: Text(
                    'Status',
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
                              Status_ = list[index].status;
                              name_ = list[index].ename;
                              enroll_id_ = list[index].enrollId;
                              enroll_code_ = list[index].empCode;
                              print('status: PPP ${Status_}');
                              if (Status_ == null) {
                                Errordata(context, 'Error',
                                    'Update Your Status', 'OK');
                              } else {
                                _displayAttendanceDialog(context, Status_);
                              }
                              print('STATUS: ${Status_}--${enroll_id_}');
                            }
                          },
                          cells: [
                            DataCell(
                              Text('${list[index].empCode}',
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'headerfont',
                                      fontSize: 15)),
                            ),
                            DataCell(Text('${list[index].ename}',
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: 'headerfont',
                                    fontSize: 15))),
                            DataCell(
                              list[index].status == null
                                  ? Dropdown(
                                      'null',
                                      ['A', 'P'],
                                      datalist[index].enrollId,
                                      UserID,
                                      spinnerId,
                                      datalist,
                                      update: (update) {
                                        print('update: ${update}');
                                      },
                                    )
                                  : Text('${list[index].status}',
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'headerfont',
                                          fontSize: 15)),
                            )
                          ]))),
        ));
  }

  confirmationPopupforTicket(BuildContext dialogContext, String title, String msg, String okbtn) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      overlayColor: Colors.black87,
      isCloseButton: true,
      isOverlayTapDismiss: true,
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
              Navigator.pop(context);
              GetJSON().getEmployeeTrainingid(spinnerId).then((value) {
                datalist = value;
              });
            },
            color: ReColors().appMainColor,
          ),
        ]).show();
  }

  ErrorDIalog(BuildContext dialogContext, String title, String msg, String okbtn) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      overlayColor: Colors.black87,
      isCloseButton: true,
      isOverlayTapDismiss: true,
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
              Navigator.pop(context);
            },
            color: ReColors().appMainColor,
          ),
        ]).show();
  }

  Savedata(BuildContext dialogContext, String title, String msg, String savebtn,
      String Nobtn, enroll_id_, UserID, Status_) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      overlayColor: Colors.black87,
      isCloseButton: true,
      isOverlayTapDismiss: true,
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
              savebtn,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed: () {
              Navigator.pop(context);
              if (Status_ != null) {
                postJSON()
                    .PostTriaingEmployee(context, enroll_id_, UserID, Status_)
                    .then((value) {
                  confirmationPopupforTicket(
                      context, 'Success', 'Data saved successfully!', 'OK');
                });
              } else {
                print('status: chck: ${Status_}');
              }
            },
            color: ReColors().appMainColor,
          ),
          DialogButton(
            child: Text(
              Nobtn,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            color: ReColors().appMainColor,
          ),
        ]).show();
  }

  Future<dynamic> _refreshlist() async {
    return await GetJSON().getEmployeeTrainingid(spinnerId);
  }

  TextEditingController statusController = TextEditingController();

  Errordata(
      BuildContext dialogContext, String title, String msg, String okbtn) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      overlayColor: Colors.black87,
      isCloseButton: true,
      isOverlayTapDismiss: true,
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
              Navigator.pop(dialogContext);
            },
            color: ReColors().appMainColor,
          ),
        ]).show();
  }

  Future<void> _displayAttendanceDialog(BuildContext context, status) async {
    statusController.text = status;
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Update Attendance',
              textAlign: TextAlign.center,
            ),
            content: SingleChildScrollView(
              child: Container(
                child: Center(
                  child: Column(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.all(2),
                          child: Dropdown1(
                            'null',
                            ['A', 'P'],
                            enroll_id_,
                            UserID,
                            spinnerId,
                            datalist,
                            update: (update) {
                              print('update: ${update}');
                            },
                          )),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        );
  }
}

class Dropdown extends StatefulWidget {
  final String _key;
  final List<String> _values;
  final Function update;
  int UserID;
  int selectedId;
  List<EmployeeTrainingitems> datalist1 = [];
  var enroll_id_;

  Dropdown(this._key, this._values, this.enroll_id_, this.UserID, this.selectedId, this.datalist1, {this.update = null});

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  var _chosenValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Container(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              border: Border.all(
                color: ReColors().appMainColor,
                width: 1,
              ),
              color: ReColors().appTextWhiteColor),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: Text(
                widget._key,
                style: TextStyle(color: ReColors().appMainColor),
              ),
              icon: Icon(
                Icons.arrow_drop_down,
                color: ReColors().appMainColor,
              ),
              iconSize: 24,
              isExpanded: true,
              items:
                  widget._values.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: ReColors().appMainColor),
                  ),
                );
              }).toList(),
              onChanged: (String value) {
                setState(() {
                  _chosenValue = value;
                  print('_chosenValue: ${_chosenValue}');
                  print(' widget.enroll_id_: ${widget.enroll_id_}');
                  print(' widget.UserID: ${widget.UserID}');
                  postJSON().PostTriaingEmployee(context, widget.enroll_id_, widget.UserID, _chosenValue).then((value) {
                    confirmationPopupforTicket(
                        context,
                        'Update',
                        'Data Updated successfully!',
                        'OK',
                        widget.datalist1,
                        widget.selectedId);
                  });
                });
              },
              style: TextStyle(
                  fontFamily: 'headingfont',
                  fontSize: 15.0,
                  color: ReColors().appMainColor),
              value: _chosenValue,
            ),
          ),
        )
    );
  }

  confirmationPopupforTicket(
      BuildContext dialogContext,
      String title,
      String msg,
      String okbtn,
      List<EmployeeTrainingitems> datalist,
      spinnerId) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      overlayColor: Colors.black87,
      isCloseButton: true,
      isOverlayTapDismiss: true,
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
              Navigator.pop(context);
              Navigator.popAndPushNamed(context, '/attendance');
            },
            color: ReColors().appMainColor,
          ),
        ]).show();
  }
}

class Dropdown1 extends StatefulWidget {
  final String _key;
  final List<String> _values;
  final Function update;
  int UserID;
  int selectedId;
  List<EmployeeTrainingitems> datalist1 = [];
  var enroll_id_;

  Dropdown1(this._key, this._values, this.enroll_id_, this.UserID,
      this.selectedId, this.datalist1,
      {this.update = null});

  @override
  _DropdownState1 createState() => _DropdownState1();
}

class _DropdownState1 extends State<Dropdown1> {
  var _chosenValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Container(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              border: Border.all(
                color: ReColors().appMainColor,
                width: 1,
              ),
              color: ReColors().appTextWhiteColor),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: Text(
                widget._key,
                style: TextStyle(color: ReColors().appMainColor),
              ),
              icon: Icon(
                Icons.arrow_drop_down,
                color: ReColors().appMainColor,
              ),
              iconSize: 24,
              isExpanded: true,
              items:
                  widget._values.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: ReColors().appMainColor),
                  ),
                );
              }).toList(),
              onChanged: (String value) {
                setState(() {
                  _chosenValue = value;
                  print('_chosenValue: ${_chosenValue}');
                  print(' widget.enroll_id_: ${widget.enroll_id_}');
                  print(' widget.UserID: ${widget.UserID}');
                  postJSON()
                      .PostTriaingEmployee(context, widget.enroll_id_,
                          widget.UserID, _chosenValue)
                      .then((value) {
                    setState(() {
                      confirmationPopupforTicket(
                          context,
                          'Update',
                          'Data Updated successfully!',
                          'OK',
                          widget.datalist1,
                          widget.selectedId);
                    });
                  });
                });
              },
              style: TextStyle(
                  fontFamily: 'headingfont',
                  fontSize: 15.0,
                  color: ReColors().appMainColor),
              value: _chosenValue,
            ),
          ),
        ));
  }

  Future<dynamic> _refreshlist() async {
    return await GetJSON().getEmployeeTrainingid(widget.selectedId);
  }

  confirmationPopupforTicket(
      BuildContext dialogContext,
      String title,
      String msg,
      String okbtn,
      List<EmployeeTrainingitems> datalist,
      spinnerId) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      overlayColor: Colors.black87,
      isCloseButton: true,
      isOverlayTapDismiss: true,
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
              Navigator.pop(context);
              Navigator.popAndPushNamed(context, '/attendance');
            },
            color: ReColors().appMainColor,
          ),
        ]).show();
  }
}
