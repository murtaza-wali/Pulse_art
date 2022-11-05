import 'dart:convert';
import 'dart:io';

import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/Model/Count.dart';
import 'package:art/Model/WorkBoard/ticket_workboard_list.dart';
import 'package:art/Model/ticket/assign.dart';
import 'package:art/Model/ticket/department.dart';
import 'package:art/ParsingJSON/GetJSONMethod.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/StaticDropdown.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:art/ScreensWithData/Menu/MainMenuPopup.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;

import 'DetailsTicket.dart';
import 'eitMain.dart';

class WorkboardEIT extends StatefulWidget {
  const WorkboardEIT();

  @override
  _WorkboardEITState createState() => new _WorkboardEITState();
}

class _WorkboardEITState extends State<WorkboardEIT>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      new GlobalKey<ScaffoldState>();

  TextEditingController _searchQuery;
  bool _isSearching = false;

  List<TicketWorkboarditem> filteredRecored;
  int spinnerId;
  String selectedSpinnerItem;
  bool visible = false;
  int getID;
  bool status_check = false;
  List<Totalcount> countList = [];
  int total_count;

  ErrorPopup(
      BuildContext dialogContext, String title, String msg, String okbtn) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      overlayColor: Colors.black87,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      titleStyle: TextStyle(
          fontWeight: FontWeight.bold, fontSize: 18, fontFamily: 'titlefont'),
      descStyle: TextStyle(
          fontWeight: FontWeight.w500, fontSize: 16, fontFamily: 'titlefont'),
      animationDuration: Duration(milliseconds: 400),
    );
    Alert(
        context: dialogContext,
        style: alertStyle,
        title: title,
        desc: msg,
        buttons: [
          DialogButton(
            child: Text(
              okbtn,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => MainMenuPopUp()),
              );
            },
            color: ReColors().appMainColor,
          ),
        ]).show();
  }

  @override
  void initState() {
    super.initState();
    _searchQuery = new TextEditingController();
    if (!mounted) return;
    MySharedPreferences.instance
        .getIntValue("UserId")
        .then((value) => setState(() {
              getID = value;
              print(getID);
              GetJSON()
                  .fetchTicketWorkboard(context, new http.Client(), getID)
                  .then((String) {
                print('hello string2123 : ${String}');
                visible = true;
                parseData(String);
              });
            }));
  }

  Future<dynamic> _refreshMenu() async {
    return await GetJSON()
        .fetcheApprovaldepRequestList(
            context, new http.Client(), getID, spinnerId)
        .then((String) {
      parseData(String);
    });
  }

  Widget chip(String label, int count, Color color) {
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
        CircleAvatar(
          radius: 20,
          backgroundColor: Colors.red,
          child: Center(
            child: Text(count.toString(),
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                )),
          ),
        ),
      ],
    );
  }

  bool backtapped = false;
  bool forwardtapped = false;
  bool loading = false;
  String nextURL, prevURL;
  int offset = 0;
  int total;

  /*Widget BottomNav() {
    return hasMore == false
        ? Container()
        : Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () {
                    setState(() {
                      backtapped = true;
                      loading = true;
                      GetJSON()
                          .fetchTicketWorkboard(
                              context, new http.Client(), getID)
                          .then((String) {
                        print('hello string2123 : ${String}');
                        parseData(String);
                      });
                    });
                  },
                  child: Padding(
                    child: Icon(
                      Icons.arrow_back_ios,
                      color: backtapped == true
                          ? Colors.grey
                          : ReColors().appMainColor,
                      size: 25,
                    ),
                    padding: EdgeInsets.all(15),
                  )),
              loading == true
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Total Pendings: ${total}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 12,
                          fontFamily: 'titlefont',
                        ),
                      ),
                    ),
              InkWell(
                  onTap: () {
                    setState(() {
                      forwardtapped = true;
                      loading = true;
                      GetJSON()
                          .fetchTicketWorkboard(
                              context, new http.Client(), getID)
                          .then((String) {
                        print('hello string2123 : ${String}');
                        parseData(String);
                      });
                    });
                  },
                  child: Padding(
                    child: Icon(
                      Icons.arrow_forward_ios,
                      color: forwardtapped == true
                          ? Colors.grey
                          : ReColors().appMainColor,
                      size: 25,
                    ),
                    padding: EdgeInsets.all(15),
                  )),
            ],
          );
  }*/

  Widget CompleteWidget() {
    return Column(
      children: [
        Expanded(child: profileView()), /*BottomNav()*/
      ],
    );
  }

  Widget profileView() {
    return Container(
      child: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(5),
        child: visible == false
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Visibility(
                visible: visible,
                child: Column(
                  children: [
                    filteredRecored != null && filteredRecored.length > 0
                        ? buildListView(filteredRecored)
                        : allRecord == null
                            ? new Center(child: new CircularProgressIndicator())
                            : new Center(
                                child: new Text("No records match!"),
                              ),
                  ],
                )),
      )),
    );
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
  /*  var someDateTime = new DateTime.now();
    mon = someDateTime.month;
    print(months[mon - 1]);*/
    return months[mon - 1];
  }

  List<TicketWorkboarditem> allRecord;
  List<WorkboardLinks> offsetList;
  List<WorkboardLinks> allOffsetList;

/*
  bool hasMore;
  int count;*/

  parseData(String responseBody) {
    // final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    var parse = json.decode(responseBody);
    /*hasMore = parse["hasMore"];
    offset = parse["offset"];
    count = parse["count"];
    var link = parse["links"] as List;*/
    var data = parse["items"] as List;
    setState(() {
      allRecord = data
          .map<TicketWorkboarditem>(
              (json) => new TicketWorkboarditem.fromJson(json))
          .toList();
    });
    /* setState(() {
      offsetList = link
          .map<WorkboardLinks>((json) => new WorkboardLinks.fromJson(json))
          .toList();
    });*/
    filteredRecored = new List<TicketWorkboarditem>();
    allOffsetList = new List<WorkboardLinks>();
    filteredRecored.addAll(allRecord);
    offsetList.addAll(allOffsetList);
    print('check parsed allRecord${allRecord.length}');
    print('check parsed filteredRecored${filteredRecored.length}');
    // print('check parsed offsetList${offsetList.length}');
    print('check parsed allOffsetList${allOffsetList.length}');
    /*   if (hasMore == true) {
      backtapped = false;
      forwardtapped = false;
      total = offset + count;
      loading = false;
      nextURL = offsetList[3].href;
      prevURL = null == offsetList ? 0 : offsetList[4].href;
    }*/
  }

  void _startSearch() {
    ModalRoute.of(context)
        .addLocalHistoryEntry(new LocalHistoryEntry(onRemove: _stopSearching));

    setState(() {
      _isSearching = true;
    });
  }

  void _stopSearching() {
    _clearSearchQuery();

    setState(() {
      _isSearching = false;
      filteredRecored.addAll(allRecord);
    });
  }

  void _clearSearchQuery() {
    setState(() {
      _searchQuery.clear();
      updateSearchQuery("Search query");
    });
  }

  Widget _buildTitle(BuildContext context) {
    var horizontalTitleAlignment =
        Platform.isIOS ? CrossAxisAlignment.center : CrossAxisAlignment.start;

    return new InkWell(
      onTap: () => scaffoldKey.currentState.openDrawer(),
      child: new Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: horizontalTitleAlignment,
          children: <Widget>[
            new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/EIT_logo.png',
                  fit: BoxFit.contain,
                  height: 40,
                ),
                Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '',
                      style: TextStyle(fontFamily: 'headerfont', fontSize: 16),
                    ))
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchField() {
    return new TextField(
      controller: _searchQuery,
      autofocus: true,
      decoration: const InputDecoration(
        hintText: 'Search...',
        border: InputBorder.none,
        hintStyle: const TextStyle(color: Colors.white30),
      ),
      style: const TextStyle(color: Colors.white, fontSize: 16.0),
      onChanged: updateSearchQuery,
    );
  }

  void updateSearchQuery(String newQuery) {
    filteredRecored.clear();
    if (newQuery.length > 0) {
      Set<TicketWorkboarditem> set = Set.from(allRecord);
      set.forEach((element) => filterList(element, newQuery));
    }

    if (newQuery.isEmpty) {
      filteredRecored.addAll(allRecord);
    }

    setState(() {});
  }

  String depName;
  String subject;
  String attribute1Value, attribute2Value, attribute3Value, attribute4Value;

  filterList(TicketWorkboarditem requestlist, String searchQuery) {
    setState(() {
      depName = requestlist.fromDepartment?.toLowerCase() ?? 'null';
      attribute1Value = requestlist.ticketBy?.toLowerCase() ?? 'null';
      attribute2Value = requestlist.statusId?.toLowerCase() ?? 'null';
      attribute3Value = requestlist.assignTo?.toLowerCase() ?? 'null';
      attribute4Value = requestlist.unit?.toLowerCase() ?? 'null';
      subject = requestlist.subject?.toLowerCase() ?? 'null';
      if (subject.toLowerCase().contains(searchQuery) ||
          subject.contains(searchQuery) ||
          depName.contains(searchQuery) ||
          depName.toLowerCase().contains(searchQuery) ||
          attribute4Value.contains(searchQuery) ||
          attribute4Value.toLowerCase().contains(searchQuery) ||
          attribute3Value.contains(searchQuery) ||
          attribute3Value.toLowerCase().contains(searchQuery) ||
          attribute2Value.contains(searchQuery) ||
          attribute2Value.toLowerCase().contains(searchQuery) ||
          attribute1Value.contains(searchQuery) ||
          attribute1Value.toLowerCase().contains(searchQuery)) {
        filteredRecored.add(requestlist);
      }
    });
  }

  List<Widget> _buildActions() {
    if (_isSearching) {
      return <Widget>[
        new IconButton(
          icon: const Icon(
            Icons.clear,
            color: Colors.white,
          ),
          onPressed: () {
            if (_searchQuery == null || _searchQuery.text.isEmpty) {
              Navigator.pop(context);
              return;
            }
            _clearSearchQuery();
          },
        ),
      ];
    }

    return <Widget>[
      new IconButton(
        icon: const Icon(
          Icons.search,
          color: Colors.white,
        ),
        onPressed: _startSearch,
      ),
      new IconButton(
        icon: Icon(Icons.refresh),
        onPressed: () {
          _refreshMenu().then((list) => setState(() {
                filteredRecored = list;
              }));
        },
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Willpopwidget().getWillScope(Scaffold(
        key: scaffoldKey,
        appBar: new AppBar(
          actions: _buildActions(),
          automaticallyImplyLeading: false,
          leading: _isSearching
              ? new BackButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => WorkboardEIT()),
                    );
                  },
                )
              : new BackButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => eitMain()),
                    );
                  },
                ),

          title: _isSearching ? _buildSearchField() : _buildTitle(context),
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
        body: CompleteWidget()));
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
}
