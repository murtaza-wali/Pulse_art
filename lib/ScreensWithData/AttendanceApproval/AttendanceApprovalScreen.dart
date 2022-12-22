import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/ParsingJSON/GetJSONMethod.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/CustomAppbarWidget.dart';
import 'package:art/ScreensWithData/AttendanceApproval/UserDataNotifier.dart';
import 'package:art/ScreensWithData/Menu/MainMenuPopup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class AttendanceApprovalScreen extends StatefulWidget {
  AttendanceApprovalScreen({Key key}) : super(key: key);

  @override
  State<AttendanceApprovalScreen> createState() =>
      _AttendanceApprovalScreenState();
}

class _AttendanceApprovalScreenState extends State<AttendanceApprovalScreen>
    with SingleTickerProviderStateMixin {
  String employeeCode;

  bool isFloatingOpen = false;
  AnimationController animationController;
  Animation<Color> btnFloatColor;
  Animation<double> animationFloatIcon;
  Animation<double> animationFloatTranslate;
  Curve _curve = Curves.easeOut;
  double _fabHeight = 56.0;

  @override
  void initState() {
    // floating animation
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500))
          ..addListener(() {
            setState(() {});
          });


    animationFloatIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(animationController);
    btnFloatColor = ColorTween(begin: Colors.blue, end: Colors.red).animate(
        CurvedAnimation(
            parent: animationController,
            curve: Interval(0.00, 1.00, curve: Curves.linear)));

    animationFloatTranslate = Tween<double>(begin: _fabHeight, end: -14.0)
        .animate(CurvedAnimation(
            parent: animationController,
            curve: Interval(0.0, 0.75, curve: _curve)));
    // floating animation end

    // TODO: implement initState

    MySharedPreferences.instance.getStringValue("employeecode").then((name) {
      setState(() {
        employeeCode = name;
        print('Employee code correction: ${employeeCode}');
        GetJSON().getAttendanceReport(employeeCode).then((value) {
          setState(() {});
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    animationController.dispose();
    super.dispose();
  }



  Widget CorrectionFloatButton() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {},
        tooltip: "Correction",
        child: Icon(
          Icons.access_time,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget LeaveFloatButton() {
    return Container(
      child: FloatingActionButton(
        onPressed: () {},
        tooltip: "Leave",
        child: Icon(
          Icons.inventory_outlined,
          color: Colors.white,
        ),
      ),
    );
  }

  Widget btnToggle() {
    return Container(
      child: FloatingActionButton(
          onPressed: animate,
          backgroundColor: btnFloatColor.value,
          tooltip: "Toggle",
          child: AnimatedIcon(
            icon: AnimatedIcons.menu_close,
            progress: animationFloatIcon,
          )),
    );
  }

  animate() {
    if (!isFloatingOpen)
      animationController.forward();
    else
      animationController.reverse();
    isFloatingOpen = !isFloatingOpen;
  }



  @override
  Widget build(BuildContext context) {
    List<String> tabTexts = ['Time Correction', 'Leave Request'];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Transform(
              transform: Matrix4.translationValues(
                  0.0, animationFloatTranslate.value * 2.0, 0.0),
              child: CorrectionFloatButton(),
            ),
            Transform(
              transform: Matrix4.translationValues(
                  0.0, animationFloatTranslate.value, 0.0),
              child: LeaveFloatButton(),
            ),

            btnToggle(),
          ],
        ),
        appBar: new CustomAppBar(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => MainMenuPopUp()),
            );
          },
          Title: 'Requests',
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            children: [
              Container(
                  decoration: BoxDecoration(
                      color: const Color(0xff292639),
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TabBar(
                      indicator: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(8)),
                      tabs: tabTexts.map((text) {
                        return Tab(
                          text: text,
                        );
                      }).toList(),
                    ),
                  )),
              Expanded(
                child: TabBarView(
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    //Tab bar 1
                    ChangeNotifierProvider<UserDataNotifier>(
                        create: (context) => UserDataNotifier(),
                        child: Consumer<UserDataNotifier>(
                          builder: (context, provider, child) {
                            provider.fetchData(employeeCode);
                            if (provider.attendanceCorrectionReport == null) {
                              provider.fetchData(employeeCode);
                              print(provider.fetchData(employeeCode));
                              print(provider.attendanceCorrectionReport);

                              return Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      ReColors().appMainColor),
                                ),
                              );
                            }
                            if (provider
                                .attendanceCorrectionReport.items.isEmpty) {
                              return Center(
                                  child: Text(
                                'No Data Found!',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ReColors().appMainColor,
                                ),
                              ));
                            } else {
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SingleChildScrollView(
                                  child: Center(
                                    child: DataTable(
                                      showCheckboxColumn: false,
                                      columnSpacing: 19,
                                      dividerThickness: 1,
                                      dataRowHeight: 50,
                                      headingRowHeight: 45,
                                      showBottomBorder: false,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3.0),
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.grey,
                                          )),
                                      columns: [
                                        DataColumn(
                                          label: Expanded(
                                            child: Text(
                                              'Request ID',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),

                                        DataColumn(
                                            label: Expanded(
                                          child: Text(
                                            'Employee Name',
                                            textAlign: TextAlign.center,
                                          ),
                                        )),
                                        DataColumn(
                                            label: Expanded(
                                          child: Text(
                                            'Status',
                                            textAlign: TextAlign.center,
                                          ),
                                        ))

                                        // DataColumn(label: Text('Dated',
                                        //   textAlign: TextAlign.center,)),
                                        // DataColumn(label: Text('Status',
                                        //   textAlign: TextAlign.center,)),
                                      ],
                                      rows: provider.attendanceCorrectionReport
                                          .items.reversed
                                          .map((data) => DataRow(cells: [
                                                DataCell(RichText(
                                                  textAlign: TextAlign.center,
                                                  text: TextSpan(
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text:
                                                                data.requestNo,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                            ),
                                                            recognizer:
                                                                TapGestureRecognizer()
                                                                  ..onTap = () {
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return Dialog(
                                                                            child:
                                                                                Card(
                                                                              child: Column(
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        Text(
                                                                                          'Attendance Approval',
                                                                                          style: TextStyle(fontSize: 16, color: Colors.blueAccent, fontWeight: FontWeight.bold),
                                                                                        ),
                                                                                        Align(
                                                                                            alignment: AlignmentDirectional.topEnd,
                                                                                            child: IconButton(
                                                                                                onPressed: () {
                                                                                                  Navigator.of(context, rootNavigator: true).pop();
                                                                                                },
                                                                                                icon: Icon(Icons.cancel))),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  Divider(
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: SingleChildScrollView(
                                                                                      child: Column(children: [
                                                                                        //employee data
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: Column(
                                                                                            children: [
                                                                                              ReusableRow(
                                                                                                title: "Request No:",
                                                                                                detail: data.requestNo,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Name: ",
                                                                                                detail: data.employeename,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Leave Code: ",
                                                                                                detail: data.employeename,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Date From: ",
                                                                                                detail: data.employeename,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Date to: ",
                                                                                                detail: data.employeename,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Employee ID: ",
                                                                                                detail: data.companyname,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Address leave: ",
                                                                                                detail: data.employeename,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Leave Backup: ",
                                                                                                detail: data.employeename,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Contact No: ",
                                                                                                detail: data.employeename,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Remarks: ",
                                                                                                detail: data.employeename,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        //employee data ends

                                                                                        //leave summary widget
                                                                                        Align(
                                                                                          alignment: Alignment.topLeft,
                                                                                          child: Container(
                                                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: const Color(0xff292639), boxShadow: [
                                                                                              BoxShadow(
                                                                                                color: Color(0xff292639),
                                                                                                blurRadius: 4,
                                                                                                offset: Offset(1, 2),
                                                                                              )
                                                                                            ]),
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets.all(8.0),
                                                                                              child: Row(
                                                                                                children: [
                                                                                                  Text(
                                                                                                    'Leave Summary',
                                                                                                    textAlign: TextAlign.start,
                                                                                                    style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        LeaveSummarytable(),
                                                                                        //leave summary widget ends

                                                                                        const SizedBox(
                                                                                          height: 10,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                          children: [
                                                                                            Expanded(
                                                                                              flex: 1,
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsets.all(4),
                                                                                                child: ElevatedButton(
                                                                                                  onPressed: () {
                                                                                                    Navigator.of(context, rootNavigator: true).pop();
                                                                                                  },
                                                                                                  style: ElevatedButton.styleFrom(
                                                                                                    primary: Color(0xff292639),
                                                                                                    //backgroundColor: const Color(0xff292639),
                                                                                                  ),
                                                                                                  child: Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                                    children: const [
                                                                                                      Text('Accept'),
                                                                                                      Icon(Icons.thumb_up_alt_outlined)
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Expanded(
                                                                                              flex: 1,
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsets.all(4.0),
                                                                                                child: ElevatedButton(
                                                                                                  onPressed: () {
                                                                                                    /*                                     Fluttertoast.showToast(
                                                msg: 'Rejected',  // message
                                                toastLength: Toast.LENGTH_SHORT, // length
                                                gravity: ToastGravity.BOTTOM, // location
                                              );*/
                                                                                                    Navigator.of(context, rootNavigator: true).pop();
                                                                                                  },
                                                                                                  child: Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                                    children: const [
                                                                                                      Text('Reject'),
                                                                                                      Icon(Icons.thumb_down_alt_outlined)
                                                                                                    ],
                                                                                                  ),
                                                                                                  style: ElevatedButton.styleFrom(
                                                                                                    //backgroundColor: Colors.red,
                                                                                                    primary: Colors.red,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            )
                                                                                          ],
                                                                                        )
                                                                                      ]),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          );
                                                                        });
                                                                  }),
                                                        TextSpan(
                                                            text: '\nDate: ' +
                                                                data
                                                                    .correctionDate,
                                                            style: TextStyle(
                                                                fontSize: 10),
                                                            recognizer:
                                                                TapGestureRecognizer()
                                                                  ..onTap = () {
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return Dialog(
                                                                            child:
                                                                                Card(
                                                                              child: Column(
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        Text(
                                                                                          'Attendance Approval',
                                                                                          style: TextStyle(fontSize: 16, color: Colors.blueAccent, fontWeight: FontWeight.bold),
                                                                                        ),
                                                                                        Align(
                                                                                            alignment: AlignmentDirectional.topEnd,
                                                                                            child: IconButton(
                                                                                                onPressed: () {
                                                                                                  Navigator.of(context, rootNavigator: true).pop();
                                                                                                },
                                                                                                icon: Icon(Icons.cancel))),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  Divider(
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: SingleChildScrollView(
                                                                                      child: Column(children: [
                                                                                        //employee data
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: Column(
                                                                                            children: [
                                                                                              ReusableRow(
                                                                                                title: "Request No:",
                                                                                                detail: data.requestNo,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Name: ",
                                                                                                detail: data.employeename,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Leave Code: ",
                                                                                                detail: data.employeename,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Date From: ",
                                                                                                detail: data.employeename,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Date to: ",
                                                                                                detail: data.employeename,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Employee ID: ",
                                                                                                detail: data.companyname,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Address leave: ",
                                                                                                detail: data.employeename,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Leave Backup: ",
                                                                                                detail: data.employeename,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Contact No: ",
                                                                                                detail: data.employeename,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Remarks: ",
                                                                                                detail: data.employeename,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        //employee data ends

                                                                                        //leave summary widget
                                                                                        Align(
                                                                                          alignment: Alignment.topLeft,
                                                                                          child: Container(
                                                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: const Color(0xff292639), boxShadow: [
                                                                                              BoxShadow(
                                                                                                color: Color(0xff292639),
                                                                                                blurRadius: 4,
                                                                                                offset: Offset(1, 2),
                                                                                              )
                                                                                            ]),
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets.all(8.0),
                                                                                              child: Row(
                                                                                                children: [
                                                                                                  Text(
                                                                                                    'Leave Summary',
                                                                                                    textAlign: TextAlign.start,
                                                                                                    style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        LeaveSummarytable(),
                                                                                        //leave summary widget ends

                                                                                        const SizedBox(
                                                                                          height: 10,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                          children: [
                                                                                            Expanded(
                                                                                              flex: 1,
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsets.all(4),
                                                                                                child: ElevatedButton(
                                                                                                  onPressed: () {
                                                                                                    Navigator.of(context, rootNavigator: true).pop();
                                                                                                  },
                                                                                                  style: ElevatedButton.styleFrom(
                                                                                                    primary: Color(0xff292639),
                                                                                                    //backgroundColor: const Color(0xff292639),
                                                                                                  ),
                                                                                                  child: Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                                    children: const [
                                                                                                      Text('Accept'),
                                                                                                      Icon(Icons.thumb_up_alt_outlined)
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Expanded(
                                                                                              flex: 1,
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsets.all(4.0),
                                                                                                child: ElevatedButton(
                                                                                                  onPressed: () {
                                                                                                    /*                                     Fluttertoast.showToast(
                                                  msg: 'Rejected',  // message
                                                  toastLength: Toast.LENGTH_SHORT, // length
                                                  gravity: ToastGravity.BOTTOM, // location
                                                );*/
                                                                                                    Navigator.of(context, rootNavigator: true).pop();
                                                                                                  },
                                                                                                  child: Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                                    children: const [
                                                                                                      Text('Reject'),
                                                                                                      Icon(Icons.thumb_down_alt_outlined)
                                                                                                    ],
                                                                                                  ),
                                                                                                  style: ElevatedButton.styleFrom(
                                                                                                    //backgroundColor: Colors.red,
                                                                                                    primary: Colors.red,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            )
                                                                                          ],
                                                                                        )
                                                                                      ]),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          );
                                                                        });
                                                                  }),
                                                      ]),
                                                )),

                                                DataCell(Container(
                                                  width: 160,
                                                  child: Center(
                                                    child: Text(
                                                      data.employeename,
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                )),
                                                DataCell(Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          3, 0, 0, 0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Column(children: [
                                                      if (data.status ==
                                                          'Approved') ...[
                                                        IconButton(
                                                          onPressed: () {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "This request is approved.",
                                                                toastLength: Toast
                                                                    .LENGTH_SHORT,
                                                                gravity:
                                                                    ToastGravity
                                                                        .BOTTOM,
                                                                timeInSecForIosWeb:
                                                                    1,
                                                                backgroundColor:
                                                                    Colors
                                                                        .green,
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16.0);
                                                          },
                                                          icon: Icon(
                                                            Icons.check_circle,
                                                            color: Colors.green,
                                                            size: 30,
                                                          ),
                                                        )
                                                      ] else ...[
                                                        IconButton(
                                                          onPressed: () {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "This request is rejected.",
                                                                toastLength: Toast
                                                                    .LENGTH_SHORT,
                                                                gravity:
                                                                    ToastGravity
                                                                        .BOTTOM,
                                                                timeInSecForIosWeb:
                                                                    1,
                                                                backgroundColor:
                                                                    Colors.red,
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16.0);
                                                          },
                                                          icon: Icon(
                                                            Icons.cancel,
                                                            color: Colors.red,
                                                            size: 30,
                                                          ),
                                                        ),
                                                      ]
                                                    ]),
                                                  ),
                                                )),

                                                // DataCell(Text(data.correctionDate,
                                                //   textAlign: TextAlign.right,)),
                                                // DataCell(Text(data.status)),
                                              ]))
                                          .toList(),
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        )),
                    //Tab bar 1 ends

                    //tab1 ends

                    //TabBar 2
                    ChangeNotifierProvider<UserDataNotifier>(
                        create: (context) => UserDataNotifier(),
                        child: Consumer<UserDataNotifier>(
                          builder: (context, provider, child) {
                            provider.fetchData(employeeCode);
                            if (provider.attendanceCorrectionReport == null) {
                              provider.fetchData(employeeCode);
                              print(provider.fetchData(employeeCode));
                              print(provider.attendanceCorrectionReport);

                              return Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      ReColors().appMainColor),
                                ),
                              );
                            }
                            if (provider
                                .attendanceCorrectionReport.items.isEmpty) {
                              return Center(
                                  child: Text(
                                'No Data Found!',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: ReColors().appMainColor,
                                ),
                              ));
                            } else {
                              return SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: SingleChildScrollView(
                                  child: Center(
                                    child: DataTable(
                                      showCheckboxColumn: false,
                                      columnSpacing: 19,
                                      dividerThickness: 1,
                                      dataRowHeight: 50,
                                      headingRowHeight: 45,
                                      showBottomBorder: false,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3.0),
                                          border: Border.all(
                                            width: 1,
                                            color: Colors.grey,
                                          )),
                                      columns: [
                                        DataColumn(
                                          label: Expanded(
                                            child: Text(
                                              'Request ID',
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),

                                        DataColumn(
                                            label: Expanded(
                                          child: Text(
                                            'Employee Name',
                                            textAlign: TextAlign.center,
                                          ),
                                        )),
                                        DataColumn(
                                            label: Expanded(
                                          child: Text(
                                            'Status',
                                            textAlign: TextAlign.center,
                                          ),
                                        ))

                                        // DataColumn(label: Text('Dated',
                                        //   textAlign: TextAlign.center,)),
                                        // DataColumn(label: Text('Status',
                                        //   textAlign: TextAlign.center,)),
                                      ],
                                      rows: provider.attendanceCorrectionReport
                                          .items.reversed
                                          .map((data) => DataRow(cells: [
                                                DataCell(RichText(
                                                  textAlign: TextAlign.center,
                                                  text: TextSpan(
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                      ),
                                                      children: <TextSpan>[
                                                        TextSpan(
                                                            text:
                                                                data.requestNo,
                                                            style:
                                                                const TextStyle(
                                                              color:
                                                                  Colors.blue,
                                                              decoration:
                                                                  TextDecoration
                                                                      .underline,
                                                            ),
                                                            recognizer:
                                                                TapGestureRecognizer()
                                                                  ..onTap = () {
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return Dialog(
                                                                            child:
                                                                                Card(
                                                                              child: Column(
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        Text(
                                                                                          'Attendance Approval',
                                                                                          style: TextStyle(fontSize: 16, color: Colors.blueAccent, fontWeight: FontWeight.bold),
                                                                                        ),
                                                                                        Align(
                                                                                            alignment: AlignmentDirectional.topEnd,
                                                                                            child: IconButton(
                                                                                                onPressed: () {
                                                                                                  Navigator.of(context, rootNavigator: true).pop();
                                                                                                },
                                                                                                icon: Icon(Icons.cancel))),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  Divider(
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: SingleChildScrollView(
                                                                                      child: Column(children: [
                                                                                        //employee data
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: Column(
                                                                                            children: [
                                                                                              ReusableRow(
                                                                                                title: "Request No:",
                                                                                                detail: data.requestNo,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Name: ",
                                                                                                detail: data.employeename,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Leave Code: ",
                                                                                                detail: data.employeename,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Date From: ",
                                                                                                detail: data.employeename,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Date to: ",
                                                                                                detail: data.employeename,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Employee ID: ",
                                                                                                detail: data.companyname,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Address leave: ",
                                                                                                detail: data.employeename,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Leave Backup: ",
                                                                                                detail: data.employeename,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Contact No: ",
                                                                                                detail: data.employeename,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Remarks: ",
                                                                                                detail: data.employeename,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        //employee data ends

                                                                                        //leave summary widget
                                                                                        Align(
                                                                                          alignment: Alignment.topLeft,
                                                                                          child: Container(
                                                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: const Color(0xff292639), boxShadow: [
                                                                                              BoxShadow(
                                                                                                color: Color(0xff292639),
                                                                                                blurRadius: 4,
                                                                                                offset: Offset(1, 2),
                                                                                              )
                                                                                            ]),
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets.all(8.0),
                                                                                              child: Row(
                                                                                                children: [
                                                                                                  Text(
                                                                                                    'Leave Summary',
                                                                                                    textAlign: TextAlign.start,
                                                                                                    style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        LeaveSummarytable(),
                                                                                        //leave summary widget ends

                                                                                        const SizedBox(
                                                                                          height: 10,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                          children: [
                                                                                            Expanded(
                                                                                              flex: 1,
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsets.all(4),
                                                                                                child: ElevatedButton(
                                                                                                  onPressed: () {
                                                                                                    Navigator.of(context, rootNavigator: true).pop();
                                                                                                  },
                                                                                                  style: ElevatedButton.styleFrom(
                                                                                                    primary: Color(0xff292639),
                                                                                                    //backgroundColor: const Color(0xff292639),
                                                                                                  ),
                                                                                                  child: Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                                    children: const [
                                                                                                      Text('Accept'),
                                                                                                      Icon(Icons.thumb_up_alt_outlined)
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Expanded(
                                                                                              flex: 1,
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsets.all(4.0),
                                                                                                child: ElevatedButton(
                                                                                                  onPressed: () {
                                                                                                    /*                                     Fluttertoast.showToast(
                                                msg: 'Rejected',  // message
                                                toastLength: Toast.LENGTH_SHORT, // length
                                                gravity: ToastGravity.BOTTOM, // location
                                              );*/
                                                                                                    Navigator.of(context, rootNavigator: true).pop();
                                                                                                  },
                                                                                                  child: Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                                    children: const [
                                                                                                      Text('Reject'),
                                                                                                      Icon(Icons.thumb_down_alt_outlined)
                                                                                                    ],
                                                                                                  ),
                                                                                                  style: ElevatedButton.styleFrom(
                                                                                                    //backgroundColor: Colors.red,
                                                                                                    primary: Colors.red,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            )
                                                                                          ],
                                                                                        )
                                                                                      ]),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          );
                                                                        });
                                                                  }),
                                                        TextSpan(
                                                            text: '\nDate: ' +
                                                                data
                                                                    .correctionDate,
                                                            style: TextStyle(
                                                                fontSize: 10),
                                                            recognizer:
                                                                TapGestureRecognizer()
                                                                  ..onTap = () {
                                                                    showDialog(
                                                                        context:
                                                                            context,
                                                                        builder:
                                                                            (BuildContext
                                                                                context) {
                                                                          return Dialog(
                                                                            child:
                                                                                Card(
                                                                              child: Column(
                                                                                children: [
                                                                                  Padding(
                                                                                    padding: const EdgeInsets.all(8.0),
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                                      children: [
                                                                                        Text(
                                                                                          'Attendance Approval',
                                                                                          style: TextStyle(fontSize: 16, color: Colors.blueAccent, fontWeight: FontWeight.bold),
                                                                                        ),
                                                                                        Align(
                                                                                            alignment: AlignmentDirectional.topEnd,
                                                                                            child: IconButton(
                                                                                                onPressed: () {
                                                                                                  Navigator.of(context, rootNavigator: true).pop();
                                                                                                },
                                                                                                icon: Icon(Icons.cancel))),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                  Divider(
                                                                                    color: Colors.black,
                                                                                  ),
                                                                                  Expanded(
                                                                                    child: SingleChildScrollView(
                                                                                      child: Column(children: [
                                                                                        //employee data
                                                                                        Padding(
                                                                                          padding: const EdgeInsets.all(8.0),
                                                                                          child: Column(
                                                                                            children: [
                                                                                              ReusableRow(
                                                                                                title: "Request No:",
                                                                                                detail: data.requestNo,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Name: ",
                                                                                                detail: data.employeename,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Leave Code: ",
                                                                                                detail: data.employeename,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Date From: ",
                                                                                                detail: data.employeename,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Date to: ",
                                                                                                detail: data.employeename,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Employee ID: ",
                                                                                                detail: data.companyname,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Address leave: ",
                                                                                                detail: data.employeename,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Leave Backup: ",
                                                                                                detail: data.employeename,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Contact No: ",
                                                                                                detail: data.employeename,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                              ReusableRow(
                                                                                                title: "Remarks: ",
                                                                                                detail: data.employeename,
                                                                                              ),
                                                                                              Divider(
                                                                                                color: Colors.grey,
                                                                                              ),
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        //employee data ends

                                                                                        //leave summary widget
                                                                                        Align(
                                                                                          alignment: Alignment.topLeft,
                                                                                          child: Container(
                                                                                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(4), color: const Color(0xff292639), boxShadow: [
                                                                                              BoxShadow(
                                                                                                color: Color(0xff292639),
                                                                                                blurRadius: 4,
                                                                                                offset: Offset(1, 2),
                                                                                              )
                                                                                            ]),
                                                                                            child: Padding(
                                                                                              padding: const EdgeInsets.all(8.0),
                                                                                              child: Row(
                                                                                                children: [
                                                                                                  Text(
                                                                                                    'Leave Summary',
                                                                                                    textAlign: TextAlign.start,
                                                                                                    style: TextStyle(fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
                                                                                                  ),
                                                                                                ],
                                                                                              ),
                                                                                            ),
                                                                                          ),
                                                                                        ),
                                                                                        LeaveSummarytable(),
                                                                                        //leave summary widget ends

                                                                                        const SizedBox(
                                                                                          height: 10,
                                                                                        ),
                                                                                        Row(
                                                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                                          children: [
                                                                                            Expanded(
                                                                                              flex: 1,
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsets.all(4),
                                                                                                child: ElevatedButton(
                                                                                                  onPressed: () {
                                                                                                    Navigator.of(context, rootNavigator: true).pop();
                                                                                                  },
                                                                                                  style: ElevatedButton.styleFrom(
                                                                                                    primary: Color(0xff292639),
                                                                                                    //backgroundColor: const Color(0xff292639),
                                                                                                  ),
                                                                                                  child: Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                                    children: const [
                                                                                                      Text('Accept'),
                                                                                                      Icon(Icons.thumb_up_alt_outlined)
                                                                                                    ],
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            ),
                                                                                            Expanded(
                                                                                              flex: 1,
                                                                                              child: Padding(
                                                                                                padding: const EdgeInsets.all(4.0),
                                                                                                child: ElevatedButton(
                                                                                                  onPressed: () {
                                                                                                    /*                                     Fluttertoast.showToast(
                                                  msg: 'Rejected',  // message
                                                  toastLength: Toast.LENGTH_SHORT, // length
                                                  gravity: ToastGravity.BOTTOM, // location
                                                );*/
                                                                                                    Navigator.of(context, rootNavigator: true).pop();
                                                                                                  },
                                                                                                  child: Row(
                                                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                                                    children: const [
                                                                                                      Text('Reject'),
                                                                                                      Icon(Icons.thumb_down_alt_outlined)
                                                                                                    ],
                                                                                                  ),
                                                                                                  style: ElevatedButton.styleFrom(
                                                                                                    //backgroundColor: Colors.red,
                                                                                                    primary: Colors.red,
                                                                                                  ),
                                                                                                ),
                                                                                              ),
                                                                                            )
                                                                                          ],
                                                                                        )
                                                                                      ]),
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                          );
                                                                        });
                                                                  }),
                                                      ]),
                                                )),

                                                DataCell(Container(
                                                  width: 160,
                                                  child: Center(
                                                    child: Text(
                                                      data.employeename,
                                                      textAlign:
                                                          TextAlign.center,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1,
                                                    ),
                                                  ),
                                                )),
                                                DataCell(Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          3, 0, 0, 0),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.centerRight,
                                                    child: Column(children: [
                                                      if (data.status ==
                                                          'Approved') ...[
                                                        IconButton(
                                                          onPressed: () {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "This request is approved.",
                                                                toastLength: Toast
                                                                    .LENGTH_SHORT,
                                                                gravity:
                                                                    ToastGravity
                                                                        .BOTTOM,
                                                                timeInSecForIosWeb:
                                                                    1,
                                                                backgroundColor:
                                                                    Colors
                                                                        .green,
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16.0);
                                                          },
                                                          icon: Icon(
                                                            Icons.check_circle,
                                                            color: Colors.green,
                                                            size: 30,
                                                          ),
                                                        )
                                                      ] else ...[
                                                        IconButton(
                                                          onPressed: () {
                                                            Fluttertoast.showToast(
                                                                msg:
                                                                    "This request is rejected.",
                                                                toastLength: Toast
                                                                    .LENGTH_SHORT,
                                                                gravity:
                                                                    ToastGravity
                                                                        .BOTTOM,
                                                                timeInSecForIosWeb:
                                                                    1,
                                                                backgroundColor:
                                                                    Colors.red,
                                                                textColor:
                                                                    Colors
                                                                        .white,
                                                                fontSize: 16.0);
                                                          },
                                                          icon: Icon(
                                                            Icons.cancel,
                                                            color: Colors.red,
                                                            size: 30,
                                                          ),
                                                        ),
                                                      ]
                                                    ]),
                                                  ),
                                                )),

                                                // DataCell(Text(data.correctionDate,
                                                //   textAlign: TextAlign.right,)),
                                                // DataCell(Text(data.status)),
                                              ]))
                                          .toList(),
                                    ),
                                  ),
                                ),
                              );
                            }
                          },
                        )),
                    //TabBar 2 end
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class LeaveSummarytable extends StatefulWidget {
  LeaveSummarytable({Key key}) : super(key: key);

  @override
  State<LeaveSummarytable> createState() => _LeaveSummarytableState();
}

class _LeaveSummarytableState extends State<LeaveSummarytable> {
  TableRow tableRow =
      const TableRow(decoration: BoxDecoration(color: Colors.grey), children: [
    Padding(
      padding: EdgeInsets.all(8),
      child: Text(
        'Type',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Allowed',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Text(
        'Availed',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
    Padding(
      padding: EdgeInsets.all(
        8.0,
      ),
      child: Text(
        'Remain',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ),
  ]);
  TableRow tableRow2 = const TableRow(children: [
    Padding(
      padding: EdgeInsets.all(8),
      child: Text('Casual'),
    ),
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('8.5'),
    ),
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('7.5'),
    ),
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('1'),
    ),
  ]);
  TableRow tableRow3 = const TableRow(children: [
    Padding(
      padding: EdgeInsets.all(8),
      child: Text('Sick'),
    ),
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('13.5'),
    ),
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('12'),
    ),
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('1.5'),
    ),
  ]);

  TableRow tableRow4 = const TableRow(children: [
    Padding(
      padding: EdgeInsets.all(8),
      child: Text('Annual'),
    ),
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('14'),
    ),
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('4'),
    ),
    Padding(
      padding: EdgeInsets.all(8.0),
      child: Text('10'),
    ),
  ]);

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      children: [
        tableRow,
        tableRow2,
        tableRow3,
        tableRow4,
      ],
    );
  }
}

class ReusableRow extends StatelessWidget {
  final String title, detail;

  ReusableRow({Key key, @required this.title, @required this.detail})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String s;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          Expanded(
              child: Text(
            detail,
            textAlign: TextAlign.right,
            style: TextStyle(color: ReColors().appMainColor),
          )),
        ],
      ),
    );
  }
}
