import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/GradientBG.dart';
import 'package:art/ReuseableWidget/appbar.dart';
import 'package:flutter/material.dart';

class eApproval extends StatefulWidget {
  State<StatefulWidget> createState() => _eApprovalState();
}

// ignore: camel_case_types
class _eApprovalState extends State<eApproval> {
  String partname, sno;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MySharedPreferences.instance
        .getStringValue("transactionID")
        .then((name) => setState(() {
              partname = name;
              print(partname);
            }));
    MySharedPreferences.instance
        .getStringValue("sno")
        .then((no) => setState(() {
              sno = no;
              print(sno);
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: new ReusableWidgets().getAppBar(context, 'E-Approval'),
      body: Container(
        decoration: Gradientbg().getbg(),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Center(
            child: Column(
              children: <Widget>[
                //Main Container
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                  ),
                  padding: EdgeInsets.all(10),
                  //first container
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              /*Container(
                            width: 7.0,
                            height: 7.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFB42827),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          )*/
                              SizedBox(
                                width: 8.0,
                              ),
                              Text(
                                '${sno}',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle
                                    .copyWith(
                                        color: ReColors().appMainColor,
                                        fontSize: 15),
                              ),
                              Expanded(
                                child: SizedBox(),
                              ),
                              Text(
                                'Styling',
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle
                                    .copyWith(
                                        color: ReColors().appMainColor,
                                        fontSize: 15),
                              ),
                            ],
                          ),
                        )
                        /*Row(
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
                              '${sno}',
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
                    ),*/
                        ,
                        Padding(
                          padding: const EdgeInsets.only(bottom: 16.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: <Widget>[
                              /*Container(
                            width: 7.0,
                            height: 7.0,
                            decoration: BoxDecoration(
                              color: Color(0xFFB42827),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          )*/
                              SizedBox(
                                width: 8.0,
                              ),
                              Expanded(
                                  child: Text(
                                '${partname}',
                                maxLines: 1,
                                /*// overflow: TextOverflow.fade,
                      softWrap: false,*/
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle
                                    .copyWith(
                                        color: ReColors().appMainColor,
                                        fontSize: 15),
                              )),
                              Expanded(
                                child: SizedBox(),
                              ),
                            ],
                          ),
                        )

                        /*Row(
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
                              '${partname}',
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
                    )*/
                        ,
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
        ),
      ),
    );
  }
}
