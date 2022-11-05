import 'dart:convert';
import 'dart:math';

import 'package:art/ReuseableWidget/CustomAppbarWidget.dart';
import 'package:art/ScreensWithData/Menu/MainMenuPopup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';



class AttendanceApprovalScreen extends StatefulWidget {
  AttendanceApprovalScreen({Key key}) : super(key: key);

  @override
  State<AttendanceApprovalScreen> createState() =>
      _AttendanceApprovalScreenState();
}

class _AttendanceApprovalScreenState extends State<AttendanceApprovalScreen> {
  @override
  Widget build(BuildContext context) {
    List<String> tabTexts = ['Time Correction', 'Leave Request'];
    final DataTableSource _data = Mydata(context);
    final DataTableSource _data2 = MyLeaveData(context);

    return DefaultTabController(

      length: 2,
      child: Scaffold(
         resizeToAvoidBottomInset: false,
         appBar: new CustomAppBar(
           onPressed: () {
             Navigator.push(context,
               MaterialPageRoute(builder: (BuildContext context) => MainMenuPopUp()),
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
                   children: [
                     //Tab bar 1

                     PaginatedDataTable(
                       source: _data,
                       columns: const [
                         DataColumn(
                             label: Text(
                               'ID',
                               textAlign: TextAlign.center,
                             )),
                         DataColumn(
                             label: Text(
                               'Employee Name',
                               textAlign: TextAlign.center,
                             )),
                         DataColumn(label: Text('Dated'))
                       ],
                       rowsPerPage: 7,
                       horizontalMargin: 30,
                     ),

                     //TabBar 2

                     PaginatedDataTable(
                       source: _data2,
                       columns: const [
                         DataColumn(
                             label: Text(
                               'ID',
                               textAlign: TextAlign.center,
                             )),
                         DataColumn(
                             label: Text(
                               'Employee Name',
                               textAlign: TextAlign.center,
                             )),
                         DataColumn(label: Text('Dated'))
                       ],
                       rowsPerPage: 7,
                       horizontalMargin: 30,
                     ),
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

class MyLeaveData extends DataTableSource {
  @override
  final List<Map<String, dynamic>> _data = List.generate(
      100,
          (index) => {
        "id": index + 300,
        "name": "Artistic Milliners  $index",
        "requested_date": "31-10-2022",
        "type": "correction"
      });

  BuildContext buildContext;

  MyLeaveData(this.buildContext);

  DataRow getRow(int index) {
    return DataRow(cells: [
      DataCell(
        Text(
          _data[index]['id'].toString(),
          style: const TextStyle(
              color: Colors.blue, decoration: TextDecoration.underline),
          textAlign: TextAlign.center,
        ),
        onTap: () {
//             Fluttertoast.showToast(
//             msg: _data[index]['id'].toString(), // message
//             toastLength: Toast.LENGTH_SHORT, // length
//             gravity: ToastGravity.BOTTOM, // location
//           );

          Navigator.push(
            buildContext,
            MaterialPageRoute(
                builder: (BuildContext context) =>
                    AttendanceApprovalScreen()),
          );

          showDialog(
              context: buildContext,
              builder: (BuildContext context) {
                return Dialog(
                  child: Card(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const [
                              Text(
                                'Attendance Approval',
                                style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.blueAccent,
                                    fontWeight: FontWeight.bold),
                              ),
                              Align(
                                alignment: AlignmentDirectional.topEnd,
                                child: Icon(Icons.cancel),
                              )
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
                                      title: "Application No",
                                      detail: _data[index]['name'].toString(),
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    ReusableRow(
                                      title: "Name",
                                      detail: _data[index]['name'].toString(),
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    ReusableRow(
                                      title: "Leave Code",
                                      detail: _data[index]['name'].toString(),
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    ReusableRow(
                                      title: "Date From",
                                      detail: _data[index]['name'].toString(),
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    ReusableRow(
                                      title: "Date to",
                                      detail: _data[index]['name'].toString(),
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    ReusableRow(
                                      title: "Employee ID",
                                      detail: _data[index]['name'].toString(),
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    ReusableRow(
                                      title: "Address when to leave",
                                      detail: _data[index]['name'].toString(),
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    ReusableRow(
                                      title: "Backup during Leave",
                                      detail: _data[index]['name'].toString(),
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    ReusableRow(
                                      title: "Contact No",
                                      detail: _data[index]['name'].toString(),
                                    ),
                                    Divider(
                                      color: Colors.grey,
                                    ),
                                    ReusableRow(
                                      title: "Remarks",
                                      detail: _data[index]['name'].toString(),
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
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4),
                                      color: const Color(0xff292639),
                                      boxShadow: [
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
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              //leave summary widget ends

                              LeaveSummarytable(),

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
                                          Navigator.of(context, rootNavigator: true)
                                              .pop();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          primary:  Color(0xff292639),
                                          //backgroundColor: const Color(0xff292639),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                          Navigator.of(context, rootNavigator: true)
                                              .pop();
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: const [
                                            Text('Reject'),
                                            Icon(Icons.thumb_down_alt_outlined)
                                          ],
                                        ),
                                        style: ElevatedButton.styleFrom(
                                          //backgroundColor: Colors.red,
                                          primary:  Colors.red,
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

          //print("ID number: "+_data[index]['id'].toString());
        },
      ),
      DataCell(Text(_data[index]['name'].toString())),
      DataCell(Text(_data[index]['requested_date'].toString())),
    ]);
    // TODO: implement getRow
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => _data.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}

class Mydata extends DataTableSource {
  @override
  final List<Map<String, dynamic>> _data = List.generate(
      200,
          (index) => {
        "id": index + 21233,
        "name": "Item: $index",
        "requested_date": Random().nextInt(100000),
        "type": "correction"
      });

  BuildContext buildContext;

  Mydata(this.buildContext);

  DataRow getRow(int index) {

    return DataRow(cells: [

      DataCell(

        Text(
          _data[index]['id'].toString(),
          style: const TextStyle(
              color: Colors.blue, decoration: TextDecoration.underline),
          textAlign: TextAlign.center,
        ),
        onTap: () {

          // Navigator.push(
          //   buildContext,
          //   MaterialPageRoute(
          //       builder: (BuildContext context) =>
          //           AttendanceApprovalScreen()),
          // );

          showDialog(
              context: buildContext,
              builder: (BuildContext context) {
                return Dialog(
                  child: Card(
                    child: Column(
                        children: [
                    Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text(
                          'Attendance Approval',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold),
                        ),
                        Align(
                            alignment: AlignmentDirectional.topEnd,
                            child: Icon(Icons.cancel))
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
                                  title: "Application No",
                                  detail: _data[index]['name'].toString(),
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                ReusableRow(
                                  title: "Name",
                                  detail: _data[index]['name'].toString(),
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                ReusableRow(
                                  title: "Leave Code",
                                  detail: _data[index]['name'].toString(),
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                ReusableRow(
                                  title: "Date From",
                                  detail: _data[index]['name'].toString(),
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                ReusableRow(
                                  title: "Date to",
                                  detail: _data[index]['name'].toString(),
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                ReusableRow(
                                  title: "Employee ID",
                                  detail: _data[index]['name'].toString(),
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                ReusableRow(
                                  title: "Address when to leave",
                                  detail: _data[index]['name'].toString(),
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                ReusableRow(
                                  title: "Backup during Leave",
                                  detail: _data[index]['name'].toString(),
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                ReusableRow(
                                  title: "Contact No",
                                  detail: _data[index]['name'].toString(),
                                ),
                                Divider(
                                  color: Colors.grey,
                                ),
                                ReusableRow(
                                  title: "Remarks",
                                  detail: _data[index]['name'].toString(),
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
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(4),
                                  color: const Color(0xff292639),
                                  boxShadow: [
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
                                      style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          //leave summary widget ends

                          LeaveSummarytable(),

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
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary:  Color(0xff292639),
                                      //backgroundColor: const Color(0xff292639),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
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
                                      Navigator.of(context, rootNavigator: true)
                                          .pop();
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: const [
                                        Text('Reject'),
                                        Icon(Icons.thumb_down_alt_outlined)
                                      ],
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      //backgroundColor: Colors.red,
                                      primary:  Colors.red,
                                    ),
                                  ),
                                ),
                              )                        ],
                        )
                        ]),
                  ),
                ),
                ],
                ),
                ),
                );
              });

          //print("ID number: "+_data[index]['id'].toString());
        },
      ),
      DataCell(Text(_data[index]['name'].toString()), onTap: () {
        // Navigator.push(
        //   buildContext,
        //   MaterialPageRoute(builder: (BuildContext context) => AmplifyClass()),
        // );
      }),
      DataCell(Text(_data[index]['requested_date'].toString())),
    ]);
    // TODO: implement getRow
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => _data.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(detail),
        ],
      ),
    );
  }
}

