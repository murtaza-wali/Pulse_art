import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/appbar.dart';
import 'package:flutter/material.dart';

class eApproval extends StatefulWidget {
  State<StatefulWidget> createState() => new _eApprovalState();
}

class _eApprovalState extends State<eApproval> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new ReusableWidgets().getAppBar('E-Approval'),
      body: Center(
        child: Column(
          children: <Widget>[
            //Main Container
            Container(
              padding: EdgeInsets.all(10),
              //first container
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        // first column
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            // Textfield
                            Text(
                              "GP#",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "SG05/0032/21",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            )
                          ],
                        ),
                        // second column
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Type",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Styling",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            )
                          ],
                        )
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Padding(padding: EdgeInsets.fromLTRB(0, 40, 0, 40)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              "Party Name",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            ),
                            Text(
                              "Artistic Milliners ",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14.0,
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.w600),
                              textAlign: TextAlign.center,
                            )
                          ],
                        )
                      ],
                    ),
                    DataTable(
                      headingRowColor: MaterialStateColor.resolveWith(
                          (states) => ReColors().appMainColor),
                      dataRowColor: MaterialStateColor.resolveWith(
                          (states) => Colors.white),
                      columns: [
                        DataColumn(
                            label: Text(
                          'Item Description',
                          style: TextStyle(color: Colors.white),
                        )),
                        DataColumn(
                            label: Text(
                          'UOM',
                          style: TextStyle(color: Colors.white),
                        )),
                        DataColumn(
                            label: Text(
                          'Qty',
                          style: TextStyle(color: Colors.white),
                        )),
                      ],
                      rows: [
                        DataRow(cells: [
                          DataCell(Text('Fabric')),
                          DataCell(Text('MTR')),
                          DataCell(Text('60')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('Fabric')),
                          DataCell(Text('MTR')),
                          DataCell(Text('129')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('Fabric')),
                          DataCell(Text('MTR')),
                          DataCell(Text('118')),
                        ])
                      ],
                    ),
                    Container(
                        child: Row(children: <Widget>[
                      Expanded(
                          child: RaisedButton(
                              onPressed: () {},
                              color: Color(0xFF29A02F),
                              child: Text(
                                "Accept",
                                style: TextStyle(color: Colors.white),
                              ))),
                      Expanded(
                          child: RaisedButton(
                              onPressed: () {},
                              color: Color(0xfff60000),
                              child: Text("Reject"))),
                    ])),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
