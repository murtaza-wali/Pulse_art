import 'package:art/InternetConnection/Offline.dart';
import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/Model/transactionByID.dart';
import 'package:art/ParsingJSON/GetJSONMethod.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/CustomAppbarWidget.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:art/ReuseableWidget/appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'EapprovalGPByID.dart';

class TransactionByID extends StatefulWidget {
  State<StatefulWidget> createState() => _TransationByIDState();
}

class _TransationByIDState extends State<TransactionByID> {
  List<DepReqItem> transactionList = [];
  int GettransID;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MySharedPreferences.instance
        .getIntValue("transactionID")
        .then((value) => setState(() {
              GettransID = value;
              print('GettransID ${GettransID}');
              GetJSON().getTransationItemsById(GettransID).then((users) {
                setState(() {
                  //list of user
                  transactionList = users;
                  print('GettransID ${transactionList.length}');
                });
              });
            }));
  }

  @override
  Widget build(BuildContext context) {
    return Willpopwidget().getWillScope(Scaffold(
      appBar: new CustomAppBar(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => EapprovalGPById()),
          );
        },
        Title: 'Transaction',
      ),
      body: ReuseOffline().getoffline(FutureBuilder<List<DepReqItem>>(
        future: GetJSON().getTransationItemsById(GettransID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            transactionList = snapshot.data;
            return getData(transactionList);
            // return getListofTransactionByID(transactionList);
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(ReColors().appMainColor),
          ));
        },
      )),
    ));
  }

  Widget getData(transList) {
    return Column(children: [
      Container(
        color: ReColors().appMainColor,
        child: ListTile(
          title: Row(children: <Widget>[
            Expanded(
                child: Center(
                    child: Text(
              "Description",
              style: TextStyle(color: Colors.white),
            ))),
            Expanded(
                child: Center(
                    child: Text("UOM", style: TextStyle(color: Colors.white)))),
            Expanded(
                child: Center(
                    child:
                        Text("Item", style: TextStyle(color: Colors.white)))),
            Expanded(
                child: Center(
              child: Text("Edit", style: TextStyle(color: Colors.white)),
            )),
          ]),
        ),
      ),
      Expanded(
        child: Container(
          child: ListView.builder(
            itemCount: transList == null ? 0 : transList.length,
            itemBuilder: (BuildContext context, int index) {
              DepReqItem depReqItem = transactionList[0];
              return ListTile(
                  //return new ListTile(
                  onTap: null,
                  title: Column(
                    children: [
                      Row(children: <Widget>[
                        Expanded(
                            child: Text(
                          depReqItem.itemDesc,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        )),
                        Expanded(
                            child: Center(
                          child: Text(
                            depReqItem.uomCode,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                          ),
                        )),
                        Expanded(
                            child: Text(
                          depReqItem.itemCode,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        )),
                        Expanded(
                            child: IconButton(
                          color: Colors.black,
                          icon: new Icon(Icons.edit),
                          onPressed: () {
                            print('helllllllo ${transactionList}');
                          },
                        )),
                      ]),
                      Divider(
                        color: Colors.black,
                      )
                    ],
                  ));
            }, //itemBuilder
          ),
        ),
      ),
    ]);
  }

/*SingleChildScrollView getDataTableofTransaction() {
    // Both Vertical and Horozontal Scrollview for the DataTable to
    // scroll both Vertical and Horizontal...
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          headingRowColor: MaterialStateColor.resolveWith(
              (states) => ReColors().appMainColor),
          dataRowColor:
              MaterialStateColor.resolveWith((states) => Colors.white),
          columns: [
            DataColumn(
                label: Text(
              'Description',
              style: TextStyle(color: Colors.white),
            )),
            DataColumn(
                label: Text(
              'UOM',
              style: TextStyle(color: Colors.white),
            )),
            */
/*  DataColumn(
                label: Text(
              'Qty',
              style: TextStyle(color: Colors.white),
            )),
            DataColumn(
                label: Text(
              'Edit',
              style: TextStyle(color: Colors.white),
            ))*/ /*
          ],
          rows: transactionList
              .map(
                (employee) => DataRow(cells: [
                  DataCell(
                    Expanded(
                      child: Text(
                        employee.itemDesc,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                    ),
                    // Add tap in the row and populate the
                    // textfields with the corresponding values to update
                    */ /*onTap: () {
                  _showValues(employee);
                  // Set the Selected employee to Update
                  _selectedEmployee = employee;
                  setState(() {
                    _isUpdating = true;
                  });
                },*/ /*
                  ),
                  DataCell(
                    Text(
                      employee.uomCode,
                    ),
                    // onTap: () {
                    //   _showValues(employee);
                    //   // Set the Selected employee to Update
                    //   _selectedEmployee = employee;
                    //   // Set flag updating to true to indicate in Update Mode
                    //   setState(() {
                    //     _isUpdating = true;
                    //   });
                    // },
                  ),
                  */ /* DataCell(
                Text(
                  employee.requiredQuantity.toString(),
                ),
                */ /* */ /*onTap: () {
                  _showValues(employee);
                  // Set the Selected employee to Update
                  _selectedEmployee = employee;
                  setState(() {
                    _isUpdating = true;
                  });
                },*/ /* */ /*
              ),
              DataCell(IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  print('helllllllo ${transactionList}');
                },
              )*/ /*
                ]),
              )
              .toList(),
        ),
      ),
    );
  }*/

/*Widget getDataTableofTransaction(transactionList){
    return DataTable(
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
        ])
      ],
    );

  }*/

/*Widget getListofTransactionByID(transactionList) {
    return Center(
      child: Container(
        child: ListView.builder(
            itemCount: null == transactionList ? 0 : transactionList.length,
            itemBuilder: (BuildContext context, int index) {
              DepReqItem depReqItem = transactionList[0];
              print('Result ${depReqItem}');
              return Card(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                          // border: Border.all(color: Color(0xff940D5A)),

                          color: Colors.white,
                          // borderRadius: BorderRadius.circular(17.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(1.0, 15.0),
                              blurRadius: 20.0,
                            ),
                          ]),
                      height: 70,
                      // color: Colors.white,
                      child: Row(
                        children: <Widget>[
                          Expanded(

                            child: Padding(
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text('${depReqItem.itemCode}'),
                                  Text('${depReqItem.itemDesc}',
                                      style: TextStyle(color: Colors.grey))
                                ],
                              ),
                            ),
                          ),
                          SizedBox(width: 10),
                          Container(
                              child: Center(
                                  child: IconButton(
                            color: Colors.black,
                            icon: new Icon(Icons.edit),
                            onPressed: () {
                              print('helllllllo ${transactionList}');
                              */ /*_displayPersonalDataDialog(context,
                                    'marital_status', 'CNICExpiry');*/ /*
                            },
                          )))
                          // Icon(Icons.arrow_forward_ios, color: Colors.blue),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
    );
  }*/
}
/*
*
*
*
*
* Padding(
        padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 5.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
              // border: Border.all(color: Color(0xff940D5A)),

                color: Colors.white,
                // borderRadius: BorderRadius.circular(17.0),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(1.0, 15.0),
                    blurRadius: 20.0,
                  ),
                ]),
            height: 70,
            // color: Colors.white,
            child: Row(
              children: <Widget>[
                Container(
                  decoration: Gradientbg().getbg(),

                  width: 70,
                  height: 70,
                  child: Icon(Icons.edit, color: Colors.white),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text('Test Title'),
                      Text('Test Video', style: TextStyle(color: Colors.grey))
                    ],
                  ),
                ),
                // Icon(Icons.arrow_forward_ios, color: Colors.blue),
              ],
            ),
          ),
        ),
      )*/
