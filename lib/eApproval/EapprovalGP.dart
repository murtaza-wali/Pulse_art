import 'package:art/InternetConnection/Offline.dart';
import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/Model/GPbyID.dart';
import 'package:art/ParsingJSON/GetJSONMethod.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ScreensWithData/EApprovalScreens/TransactionByID.dart';
import 'package:art/ScreensWithData/Menu/MainMenuPopup.dart';
import 'package:flutter/material.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

import 'eApproval.dart';

class EapprovalGP extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _EapprovalGPstate();
}

class _EapprovalGPstate extends State<EapprovalGP> {
  List<GPbyIDitem> _gplist = [];
  List<GPbyIDitem> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    MySharedPreferences.instance
        .getIntValue("UserId")
        .then((value) => setState(() {
              getID = value;
              print('USER ID : ${getID}');
              GetJSON().getGpItemsById(getID).then((name) => setState(() {
                    try {
                      _gplist = name;
                      if (_gplist.length == 0) {
                      } else {}
                    } catch (e) {
                      print(e.toString());
                    }
                  }));
            }));
  }

  Future<void> _refresh(BuildContext context) async {
    return GetJSON().getGpItemsById(getID);
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: BackButton(
            color: ReColors().appTextWhiteColor,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => MainMenuPopUp()),
              );
            },
          ),
          title: new Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/artlogo.png',
                fit: BoxFit.contain,
                height: 20,
              ),
              Container(
                  padding: const EdgeInsets.all(8.0), child: Text('E-Approval'))
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ),
          // leading: Image.asset("assets/images/artlogo.png"),// hides default back button
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.topRight,
                colors: [ReColors().appMainColor, Colors.black],
              ),
            ),
          ),
        ),
        body: ReuseOffline().getoffline(FutureBuilder<List<GPbyIDitem>>(
          future: GetJSON().getGpItemsById(getID),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _gplist = snapshot.data;
              print(snapshot.data);
              print(_gplist.length);
              if (_gplist.length == 0) {
                return Center(
                  child: Text(
                    "No Data Found",
                    style: TextStyle(fontSize: 20, color: Colors.black),
                  ),
                );
              } else {
                return _groupedListView(_gplist);
              }
            } else if (snapshot.hasError) {
              return Text(
                "No Data Found",
                style: TextStyle(fontSize: 20, color: Colors.black),
              );
            }
            return Center(
                child: CircularProgressIndicator(
              valueColor:
                  AlwaysStoppedAnimation<Color>(ReColors().appMainColor),
            ));
          },
        )));
  }

  RefreshIndicator _groupedListView(_gplist1) {
    return RefreshIndicator(
      onRefresh: () => _refresh(context),
      child: StickyGroupedListView<GPbyIDitem, DateTime>(
        elements: _gplist1,
        order: StickyGroupedListOrder.ASC,
        groupBy: (GPbyIDitem element) => DateTime(element.documentDate.year,
            element.documentDate.month, element.documentDate.day),
        groupComparator: (DateTime value1, DateTime value2) =>
            value2.compareTo(value1),
        itemComparator: (GPbyIDitem element1, GPbyIDitem element2) =>
            element1.documentDate.compareTo(element2.documentDate),
        floatingHeader: true,
        groupSeparatorBuilder: (GPbyIDitem element) => Container(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${getmonthName(element.documentDate.month)} ${element.documentDate.day}, ${element.documentDate.year}',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ReColors().appMainColor, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  flex: 5,
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Unit: ${element.unitName}',
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ReColors().appMainColor, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                  flex: 5,
                )
              ],
            ),
          ),
        ),
        itemBuilder: (_, GPbyIDitem element) {
          return Container(
            child: InkWell(
              onTap: () {
                print('Transaction ID${element.transactionId}');
                MySharedPreferences.instance.setIntValue("transactionID", element.transactionId);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TransactionByID()),
                );
              },
              child: Column(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                12.0, 12.0, 12.0, 6.0),
                            child: Text(
                              element.description,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(
                                12.0, 6.0, 12.0, 12.0),
                            child: Text(
                              element.deptName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              element.preparerRemarks,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(fontSize: 15.0),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Divider(
                    height: 2.0,
                    color: Colors.grey,
                  )
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
    var someDateTime = new DateTime.now();
    mon = someDateTime.month;
    print(months[mon - 1]);
    return months[mon - 1];
  }
}
