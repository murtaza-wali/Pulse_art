import 'dart:io';

import 'package:art/APIUri/BaseUrl.dart';
import 'package:art/Error/Error.dart';
import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/Model/DAM/DAMunitlist.dart';
import 'package:art/Model/WorkBoard/WorkboardTicket.dart';
import 'package:art/Model/WorkBoard/ticket_workboard_list.dart';
import 'package:art/Model/WorkBoard/workboard_status.dart';
import 'package:art/Model/ticket/assign.dart';
import 'package:art/Model/ticket/department.dart';
import 'package:art/ParsingJSON/GetJSONMethod.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/CustomAppbarWithImage.dart';
import 'package:art/ReuseableWidget/CustomDropdown.dart';
import 'package:art/ReuseableWidget/StaticDropdown.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'DetailsTicket.dart';
import 'eitMain.dart';

class WorkboardEIT extends StatefulWidget {
  WorkboardEIT({
    Key key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WorkboardEITState();
}

class _WorkboardEITState extends State<WorkboardEIT> {
  String selectedSpinnerItem;
  int spinnerId;

  // List<DamUnitListitem> DamUnitlist = [];
  int getID;
  List<TicketWorkboarditem> WorkboarddataList = [];
  List<Statusitems> WorkboardStatusList = [];
  List<TicketWorkboarditem> filterdata = [];
  List<String> unitlist = [];
  bool listvisible = false;
  bool loaderVisiblity = false;
  ProgressDialog progressDialog;
  List<DamUnitListitem> dam_unit_list = [];
  int selected_unit_id;
  String StatusSelected;

  @override
  void initState() {
    super.initState();
    progressDialog = new ProgressDialog(context);
    print('selected value ${selectedSpinnerItem}');
    MySharedPreferences.instance
        .getIntValue("UserId")
        .then((value) => setState(() {
              getID = value;
              print(getID);
              loaderVisiblity = true;
              GetJSON().getTicketWorkboardList(getID).then((value) {
                WorkboarddataList = value;
                print('value check${WorkboarddataList.length}');
              });
              GetJSON().getWorkboardStatus(getID).then((value) {
                WorkboardStatusList = value;
                print('value check${WorkboardStatusList.length}');
                StatusSelected = WorkboardStatusList.first.filterType;
              });
              GetJSON().getDAMUnitList(getID).then((DAMData) {
                setState(() {
                  dam_unit_list = DAMData;
                  if (dam_unit_list.length == 0) {
                    return showError(
                        'No data found', Icons.assignment_late_outlined);
                  } else {
                    selected_unit_id = dam_unit_list.first.orgId;
                  }
                });
              });
            }));
  }

  Future<dynamic> _refreshMenu() async {
    print('GET ID : ${getID}');
    print('selectedSpinnerItem : ${selectedSpinnerItem}');
    return await GetJSON().getTicketWorkboardList(getID);
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
            MaterialPageRoute(builder: (BuildContext context) => eitMain()),
          );
        },
        Title: '',
        image_bar: 'assets/images/EIT_logo.png',
        refreshonPressed: () {
          _refreshMenu().then((list) {
            setState(() {
              WorkboarddataList = list;
            });
            /*      _refreshMenu().then((list) {
            setState(() {
              DamUnitlist = list;
              print('list type item: ${DamUnitlist.length}');
              if (DamUnitlist.length == 0) {
                visible = false;
                return showError(
                    'No data found', Icons.assignment_late_outlined);
              } else {
                selectedSpinnerItem = DamUnitlist.first.companycode;
                spinnerId = DamUnitlist.first.orgId;
                visible = true;
                if (spinnerId == 14) {
                  print('typeID${spinnerId}');
                  MySharedPreferences.instance.setIntValue("typeID", spinnerId);
                }
              }
            });
          });*/
          });
        },
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                                pageBuilder: (context, _, __) => filterAlert(
                                    context,
                                    getID,
                                    selected_unit_id,
                                    dam_unit_list),
                                opaque: false),
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(7),
                          decoration: BoxDecoration(
                            color: ReColors().appMainColor,
                            border: Border.all(
                                color: ReColors().appMainColor,
                                // Set border color
                                width: 3.0), // Set border width
                            borderRadius: BorderRadius.all(Radius.circular(
                                10.0)), // Set rounded corner radius
                          ),
                          child: Icon(
                            Icons.filter_alt_outlined,
                            size: 30,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 7,
                        child: Center(
                          child: Text(
                            'WorkBoard',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                color: ReColors().appMainColor,
                                fontFamily: 'headerfont',
                                fontSize: 20),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              FutureBuilder<List<TicketWorkboarditem>>(
                future: GetJSON().getTicketWorkboardList(getID),
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
                      return showError('Please check your internet connection',
                          Icons.signal_wifi_connected_no_internet_4_sharp);
                    }
                    if (snapshot.error is NoServiceFoundException) {
                      return showError('Server Error.', Icons.error);
                    }
                    if (snapshot.error is InvalidFormatException) {
                      return showError(
                          'There is a problem with your request.', Icons.error);
                    }
                    if (snapshot.error is SocketException) {
                      SocketException socketException =
                          snapshot.error as SocketException;
                      return showError('Please check your internet connection',
                          Icons.signal_wifi_connected_no_internet_4_sharp);
                    } else {
                      return showError(
                          'An Unknown error occurred.', Icons.error);
                    }
                  } else {
                    if (WorkboarddataList.length == 0) {
                      return showError(
                          'No data', Icons.assignment_late_outlined);
                    } else {
                      return buildListView(WorkboarddataList);
                    }
                  }
                },
              )
            ],
          ),
        ),
      ),
    ));
  }

  Widget buildListView(List<TicketWorkboarditem> categories) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      physics: NeverScrollableScrollPhysics(),
      itemCount: categories == null ? 0 : categories.length,
      itemBuilder: (BuildContext ctx, int index) {
        return listText(categories[index]);
      },
    );
  }
  Widget listText(TicketWorkboarditem category) {
    return Container(
      child: Padding(
        padding: EdgeInsets.all(0),
        child: Card(
          elevation: 25,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child: Container(
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
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                child: Text(
                                  '${category.subject}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'headingfont'),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                          '${category.ticketBy}',
                                          textAlign: TextAlign.left,
                                          overflow: TextOverflow.ellipsis,
                                          softWrap: false,
                                          style: TextStyle(
                                              fontFamily: 'titlefont',
                                              color: Colors.white),
                                        )),
                                    Text('${category.fromDepartment}',
                                        style: TextStyle(
                                            fontFamily: 'titlefont',
                                            color: Colors.white)),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                    child: Text('${category.statusId}',
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        style: TextStyle(
                                            fontFamily: 'titlefont',
                                            color: Colors.white)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                    child: Text(
                                        '${category.ticketDate.day}-${getmonthName(category.ticketDate.month)}-${category.ticketDate.year}',
                                        overflow: TextOverflow.ellipsis,
                                        softWrap: false,
                                        style: TextStyle(
                                            fontFamily: 'titlefont',
                                            color: Colors.white)),
                                  )
                                ],
                              ),
                              Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                    ticketDetails()));
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                ReColors()
                                                    .appTextWhiteColor_transparent,
                                                ReColors()
                                                    .appTextWhiteColor_transparent
                                              ],
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(10.0)),
                                        alignment: Alignment.center,
                                        child: Text(
                                          'Complain ID: ${category.ticketId}',
                                          style: TextStyle(
                                              color: ReColors().appMainColor,
                                              fontFamily: 'headerfont'),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.of(context).push(
                                          PageRouteBuilder(
                                              pageBuilder: (context, _, __) =>
                                                  customAler(context),
                                              opaque: false),
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [
                                                ReColors()
                                                    .appTextWhiteColor_transparent,
                                                ReColors()
                                                    .appTextWhiteColor_transparent
                                              ],
                                              begin: Alignment.centerLeft,
                                              end: Alignment.centerRight,
                                            ),
                                            borderRadius:
                                            BorderRadius.circular(10.0)),
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding:
                                          EdgeInsets.fromLTRB(8, 0, 8, 0),
                                          child: Text('Assign',
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              style: TextStyle(
                                                  fontFamily: 'headerfont',
                                                  color:
                                                  ReColors().appMainColor)),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<List<TicketWorkboarditem>> getTICKETlist(filter, userId) async {
    var result = await Dio().get(
      BaseURL().Auth + 'ticket/workboard/' + userId.toString(),
      queryParameters: {"filter": filter},
    );
    var parse = result.data;
    var data = parse["items"] as List;
    if (data != null) {
      return TicketWorkboarditem.fromJsonList(data);
    }

    return [];
  }



  Widget getListofTransactionByID(list) {
    return Visibility(
        visible: listvisible,
        child: ListView.builder(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
          physics: NeverScrollableScrollPhysics(),
          primary: false,
          shrinkWrap: true,
          itemCount: null == list ? 0 : list.length,
          itemBuilder: (BuildContext context, int index) {
            Workboardticketitem depReqItem = list[index];
            print('Result ${depReqItem}');
            Container(
              child: Padding(
                padding: EdgeInsets.all(5),
                child: Card(
                  elevation: 25,
                  child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
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
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Text(
                                            '${depReqItem.ticketId}',
                                            style: TextStyle(
                                                fontFamily: 'headingfont',
                                                color: Colors.white),
                                          ),
                                          Text('${depReqItem.statusId} ',
                                              style: TextStyle(
                                                  fontFamily: 'titlefont',
                                                  color: Colors.white)),
                                        ],
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 5, 0, 5),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Expanded(
                                                child: Text(
                                              '${depReqItem.fromDepartment}',
                                              textAlign: TextAlign.left,
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              style: TextStyle(
                                                  fontFamily: 'titlefont',
                                                  color: Colors.white),
                                            )),
                                            Expanded(
                                                child: Text(
                                                    '${depReqItem.assignTo}',
                                                    textAlign: TextAlign.right,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    softWrap: false,
                                                    style: TextStyle(
                                                        fontFamily: 'titlefont',
                                                        color: Colors.white))),
                                          ],
                                        ),
                                      ),
                                      Divider(
                                        height: 1,
                                        color: Colors.grey,
                                      ),
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(0, 5, 0, 5),
                                        child: Text('${depReqItem.subject}',
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            style: TextStyle(
                                                fontFamily: 'titlefont',
                                                color: Colors.white)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        ));
  }

  List<Deptitems> deptList = [];
  List<AssignItems> AssignItemsList = [];
  String message;
  String selectedDepartmentName;
  String selectedSeverityName = '';
  String selectedAssignName;
  String selectedAssignid;
  String employeCode, PlayerID, AppID;
  int deptcode;
  int selectdeptID;
  TextEditingController descriptionController = TextEditingController();

  customAler(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      title: Align(
        alignment: Alignment.center,
        child: Row(
          children: [
            new Expanded(
              child: Text(
                'Assign',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ReColors().appMainColor,
                  fontSize: 17.0,
                  fontFamily: 'headingfont',
                ),
              ),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(20))),
      actions: <Widget>[
        FlatButton(child: const Text('CANCEL',
              style: TextStyle(
                color: Color(0xff055e8e),
                fontSize: 14.0,
                fontFamily: 'headingfont',
              )), materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, textColor: Theme.of(context).accentColor, onPressed: () {Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => WorkboardEIT()),
            );},),
        FlatButton(
          child: const Text('Assign',
              style: TextStyle(
                color: Color(0xff055e8e),
                fontSize: 14.0,
                fontFamily: 'headingfont',
              )),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textColor: Theme.of(context).accentColor,
          onPressed: () {},
        ),
      ],
      content: StatefulBuilder(
        builder:
            (BuildContext context, void Function(void Function()) setState) {
          return SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Dropdown('Department', ['I.T', 'ERP']),
                        Divider(
                          color: Colors.white,
                        ),
                        Dropdown('Employee', ['Uroosa Ali', 'Taha', 'Hamza']),
                        Divider(
                          color: Colors.white,
                        ),
                        TextField(
                          style: TextStyle(
                              color: ReColors().appMainColor,
                              fontFamily: 'headingfont'),
                          controller: descriptionController,
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  bool Severityvisible = false;
  bool unitvisible = false;
  bool statusvisible = false;
  String itemsSelection;

  filterAlert(BuildContext context, int getID, int selected_unit_id,
      List<DamUnitListitem> dam_unit_list) {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      title: Align(
        alignment: Alignment.center,
        child: Row(
          children: [
            new Expanded(
              child: Text(
                'Filters',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ReColors().appMainColor,
                  fontSize: 17.0,
                  fontFamily: 'headingfont',
                ),
              ),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actions: <Widget>[
        FlatButton(
          child: const Text('CANCEL',
              style: TextStyle(
                color: Color(0xff055e8e),
                fontSize: 14.0,
                fontFamily: 'headingfont',
              )),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textColor: Theme.of(context).accentColor,
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => WorkboardEIT()),
            );
          },
        ),
        FlatButton(
          child: const Text('Save',
              style: TextStyle(
                color: Color(0xff055e8e),
                fontSize: 14.0,
                fontFamily: 'headingfont',
              )),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textColor: Theme.of(context).accentColor,
          onPressed: () {
            print('selected status ${StatusSelected}');
            print('selected unit ${selectedSpinnerItem}');
            Navigator.of(context).pop(null);
          },
        ),
      ],
      content: StatefulBuilder(
        builder:
            (BuildContext context, void Function(void Function()) setState) {
          return SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: FutureBuilder<List<DamUnitListitem>>(
                              future: GetJSON().getDAMUnitList(getID),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return CustomDropdown(
                                    dropdownMenuItemList:
                                        dam_unit_list.map((item) {
                                              return DropdownMenuItem(
                                                child: chip(item.companycode),
                                                value: item.companycode,
                                                onTap: () {
                                                  selected_unit_id = item.orgId;
                                                  print('Selected UNit ID: ${selected_unit_id}');
                                                  print('selectedSpinnerItem3293: ${selectedSpinnerItem.toString()}');
                                                },
                                              );
                                            }).toList() ??
                                            [],
                                    onChanged: (newVal) {
                                      setState(() {
                                        selectedSpinnerItem = newVal;
                                        print('selected_unit_id test: ${selected_unit_id.toString()}');
                                        print('selectedSpinnerItem test: ${selectedSpinnerItem.toString()}');
                                        GetJSON().getWorkboardStatus(getID).then((value) {
                                          WorkboardStatusList = value;
                                          print('value check${WorkboardStatusList.length}');
                                          StatusSelected = WorkboardStatusList.first.filterType;
                                        });
                                      });
                                    },
                                    value: selectedSpinnerItem,
                                    isEnabled: true,
                                    color: ReColors().appMainColor,
                                    hint: 'Unit',
                                  );
                                }
                                else if (snapshot.hasError) {
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
                                    NoServiceFoundException noServiceFoundException = snapshot.error as NoServiceFoundException;
                                    return showError(
                                        'Server Error.', Icons.error);
                                  }
                                  if (snapshot.error
                                      is InvalidFormatException) {
                                    InvalidFormatException
                                        invalidFormatException = snapshot.error
                                            as InvalidFormatException;
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
                            )),
                        Divider(color: Colors.white,),
                        Padding(
                            padding: EdgeInsets.all(5),
                            child: FutureBuilder<List<Statusitems>>(
                              future: GetJSON().getWorkboardStatus(getID),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return CustomDropdown(
                                    dropdownMenuItemList:
                                        WorkboardStatusList.map((item) {
                                              return DropdownMenuItem(
                                                child: chip(item.filterType),
                                                value: item.filterType,
                                                onTap: () {
                                                  StatusSelected =
                                                      item.filterType;
                                                },
                                              );
                                            }).toList() ??
                                            [],
                                    onChanged: (newVal) {
                                      setState(() {
                                        StatusSelected = newVal;
                                        print('StatusSelected test: ${StatusSelected.toString()}');
                                      });
                                    },
                                    value: StatusSelected,
                                    isEnabled: true,
                                    color: ReColors().appMainColor,
                                    hint: 'Status',
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
                                        noServiceFoundException = snapshot.error
                                            as NoServiceFoundException;
                                    return showError(
                                        'Server Error.', Icons.error);
                                  }
                                  if (snapshot.error
                                      is InvalidFormatException) {
                                    InvalidFormatException
                                        invalidFormatException = snapshot.error
                                            as InvalidFormatException;
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
                            ))
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
    mon = someDateTime.month;*/
    return months[mon - 1];
  }
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

