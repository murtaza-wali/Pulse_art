import 'package:art/Model/GpModel.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Gatepass extends StatefulWidget {
  State<StatefulWidget> createState() => new _GetpassState();
}

class _GetpassState extends State<Gatepass> {
  List<GpModel> emps;

  @override
  void initState() {
    emps = GpModel.getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new ReusableWidgets().getAppBar(context,'Gatepass'),
      body: Row(
        children: <Widget>[
          Expanded(
            child: tableBody(
              context,
            ),
          ),
        ],
      ),
    );
  }

  SingleChildScrollView tableBody(BuildContext ctx) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,

          child: DataTable(
            headingRowColor: MaterialStateColor.resolveWith(
                (states) => ReColors().appMainColor),
            dividerThickness: 2,
            columns: [
              DataColumn(
                label: Text(
                  "GP#",
                  style: TextStyle(
                    color: ReColors().appTextWhiteColor,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  "Department",
                  style: TextStyle(
                    color: ReColors().appTextWhiteColor,
                  ),
                ),
              ),
              DataColumn(
                label: Text(
                  "Requested By",
                  style: TextStyle(
                    color: ReColors().appTextWhiteColor,
                  ),
                ),
              ),
            ],
            rows: emps
                .map(
                  (emp) => DataRow(cells: [
                    DataCell(
                      Text(emp.GpCode),
                    ),
                    DataCell(
                      Text(emp.GpDept),
                    ),
                    DataCell(
                      Text('${emp.GpReqBy}'),
                    ),
                  ]
                  ),
                )
                .toList(),
          )),
    );
  }
}
