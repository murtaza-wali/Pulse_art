/*
import 'package:art/HexCodeConverter/Hexcode.dart';
import 'package:art/InternetConnection/Offline.dart';
import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/Model/GPItemModel.dart';
import 'package:art/Model/LoginAuthenticationModel.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/appbar.dart';
import 'package:art/eApproval/eApproval.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sticky_grouped_list/sticky_grouped_list.dart';

import 'eApprovalTabs.dart';

class EapprovalGPTabs extends StatefulWidget {
  @override
  _EapprovalGPTabsState createState() => _EapprovalGPTabsState();
}

class _EapprovalGPTabsState extends State<EapprovalGPTabs> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: choices.length,
        child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              color: ReColors().appTextWhiteColor,
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
                    padding: const EdgeInsets.all(8.0),
                    child: Text('E-Approval GP'))
              ],
            ),
            automaticallyImplyLeading: true,
            // hides default back button
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [ReColors().appMainColor, Colors.black],
                ),
              ),
            ),
            bottom: TabBar(
              isScrollable: true,
              tabs: choices.map((Choice choice) {
                return Tab(
                  text: choice.title,
                );
              }).toList(),
            ),
          ),
          body: TabBarView(
            children: choices.map((Choice choice) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: GP(
                  choice: choice,
                  key: null,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({this.title});

  final String title;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Open'),
  const Choice(title: 'Approved'),
  const Choice(title: 'Reject'),
  const Choice(title: 'All'),
];

class GP extends StatefulWidget {
  const GP({Key key, this.choice}) : super(key: key);
  final Choice choice;

  @override
  State<StatefulWidget> createState() => new _GPState();
}

class _GPState extends State<GP> {
  List<GPItem> _gplist = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('WIDGET${widget.choice}');
    EapprovalGPItem().getGpItem().then((name) => setState(() {
          try {
            _gplist = name;
            print('lenght${_gplist.length}');
          } catch (e) {
            print(e.toString());
          }
        }));
  }

  Future<void> _refresh(BuildContext context) async {
    return EapprovalGPItem().getGpItem();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ReuseOffline().getoffline(FutureBuilder<List<GPItem>>(
      future: EapprovalGPItem().getGpItem(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          _gplist = snapshot.data;
          return _groupedListView(context, _gplist, widget.choice);
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return Center(
            child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(ReColors().appMainColor),
        ));
      },
    )));
  }

  Widget _groupedListView(BuildContext context, _gplist1, choice) {
    print('check${widget.choice}');
    if (choice.title == 'Open') {
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
                  MySharedPreferences.instance
                      .setStringValue("partyname", element.partyname);
                  MySharedPreferences.instance
                      .setStringValue("sno", element.sno);

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
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 6.0, 12.0, 12.0),
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    element.deptname,
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    style: TextStyle(fontSize: 15.0),
                                  )),
                            ),
                          ],
                        ),
                        Expanded(
                            child: Padding(
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
                            ],
                          ),
                        )),
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
    } else if (choice.title == 'All') {
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
                  MySharedPreferences.instance
                      .setStringValue("partyname", element.partyname);
                  MySharedPreferences.instance
                      .setStringValue("sno", element.sno);

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
                                overflow: TextOverflow.fade,
                                softWrap: false,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(
                                  12.0, 6.0, 12.0, 12.0),
                              child: Align(
                                  alignment: Alignment.topRight,
                                  child: Text(
                                    element.deptname,
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                    style: TextStyle(fontSize: 15.0),
                                  )),
                            ),
                          ],
                        ),
                        Expanded(
                            child: Padding(
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
                            ],
                          ),
                        )),
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
    } else {
      return Container(
        child: Center(
          child: Text(
            'No Data Found',
            style: TextStyle(fontSize: 15.0, color: Colors.black),
          ),
        ),
      );
    }
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
*/
