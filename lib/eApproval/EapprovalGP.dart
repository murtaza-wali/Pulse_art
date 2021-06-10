import 'package:art/InternetConnection/Offline.dart';
import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/Model/GPItemModel.dart';
import 'package:art/Model/LoginAuthenticationModel.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/appbar.dart';
import 'package:art/eApproval/eApprovalTabs.dart';
import 'package:flutter/material.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

import 'eApproval.dart';

class EapprovalGP extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _EapprovalGPstate();
}

class _EapprovalGPstate extends State<EapprovalGP> {
  List<GPItem> _gplist = [];
  List<GPItem> list = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    EapprovalGPItem().getGpItem().then((name) => setState(() {
          try {
            _gplist = name;
            print(_gplist.length);
          } catch (e) {
            print(e.toString());
          }
        }));
  }

  Future<void> _refresh(BuildContext context) async {
    return EapprovalGPItem().getGpItem();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new ReusableWidgets().getAppBar('GP'),
        body: ReuseOffline().getoffline(FutureBuilder<List<GPItem>>(
          future: EapprovalGPItem().getGpItem(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              _gplist = snapshot.data;
              return _groupedListView(_gplist);
            } else if (snapshot.hasError) {
              return Text("No Data Found",style: TextStyle(fontSize: 20,color: Colors.black),);
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
      child: StickyGroupedListView<GPItem, DateTime>(
        elements: _gplist1,
        order: StickyGroupedListOrder.ASC,
        groupBy: (GPItem element) => DateTime(
            element.outdate.year, element.outdate.month, element.outdate.day),
        groupComparator: (DateTime value1, DateTime value2) =>
            value2.compareTo(value1),
        itemComparator: (GPItem element1, GPItem element2) =>
            element1.outdate.compareTo(element2.outdate),
        floatingHeader: true,
        groupSeparatorBuilder: (GPItem element) => Container(
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
                          '${getmonthName(element.outdate.month)} ${element.outdate.day}, ${element.outdate.year}',
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
                          'Unit: ${element.orgCode}',
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
        itemBuilder: (_, GPItem element) {
          return Container(
            child: InkWell(
              onTap: () {
                print(element.serialnopk);
                MySharedPreferences.instance
                    .setIntValue("serialnopk", element.serialnopk);

                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => eApproval()),
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
                              element.sno,
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
                              element.deptname,
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
                              element.requestedBy,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              softWrap: false,
                              style: TextStyle(fontSize: 15.0),
                            ),
/*Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.star_border,
                              size: 35.0,
                              color: Colors.grey,
                            ),
                          )*/
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

          return Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.0),
            ),
            elevation: 8.0,
            margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              child: ListTile(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                leading: Text(
                  element.sno,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
                title: Text(
                  element.deptname,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
                trailing: Text(
                  element.requestedBy,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  softWrap: false,
                ),
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
