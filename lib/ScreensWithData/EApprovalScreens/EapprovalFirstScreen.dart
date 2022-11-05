import 'dart:convert';
import 'dart:io';

import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/Model/Count.dart';
import 'package:art/Model/databy_type.dart';
import 'package:art/Model/typeModel.dart';
import 'package:art/ParsingJSON/GetJSONMethod.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/CustomDropdown.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:art/ScreensWithData/DAMScreens/DAMMain.dart';
import 'package:art/ScreensWithData/Menu/MainMenuPopup.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:http/http.dart' as http;

import 'TransactionDetailsScreen.dart';
///main screen of eapproval
class EapprovalPage extends StatefulWidget {
  const EapprovalPage();

  @override
  _EapprovalPageState createState() => new _EapprovalPageState();
}

class _EapprovalPageState extends State<EapprovalPage>
    with SingleTickerProviderStateMixin {
  static final GlobalKey<ScaffoldState> scaffoldKey =
      new GlobalKey<ScaffoldState>();

  TextEditingController _searchQuery;
  bool _isSearching = false;

  List<DataByTypeitem> filteredRecored;
  List<Typeitem> eApprovalTypelist = [];
  int spinnerId;
  String selectedSpinnerItem;
  bool visible = false;
  int getID;
  bool status_check = false;
  List<Totalcount> countList = [];
  int total_count;
  String url;

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
              GetJSON().getTotalCount(context, getID).then((count) {
                setState(() {
                  countList = count;
                  total_count = countList[0].totCount;
                  if (countList[0].totCount == 0) {
                    print('Count2: ${countList[0].totCount}');
                    ErrorPopup(context, 'Pending Approval',
                        'You have no pending approvals at this time.', 'OK');
                  } else {
                    print('Count3: ${countList[0].totCount}');
                    GetJSON().gettypeItem(context, getID).then((list) {
                      eApprovalTypelist = list;
                      print(
                          'eApprovaldepRequestList item: ${eApprovalTypelist.length}');
                      if (eApprovalTypelist.length == 0) {
                        visible = false;
                        return showError(
                            'No data found', Icons.assignment_late_outlined);
                      } else {
                        selectedSpinnerItem = eApprovalTypelist.first.type;
                        spinnerId = eApprovalTypelist.first.typeId;
                        print('spinnerId: ${spinnerId}');
                        print('selectedSpinnerItem: ${selectedSpinnerItem}');

                        GetJSON()
                            .fetcheApprovaldepRequestList(
                                context, new http.Client(), getID, spinnerId)
                            .then((String) {
                          print('hello string : ${String}');
                          parseData(String);
                        });
                        if (spinnerId == 14) {
                          print('typeID${spinnerId}');
                          MySharedPreferences.instance
                              .setIntValue("typeID", spinnerId);
                        }
                        _refreshMenu().then((list) => setState(() {
                              eApprovalTypelist = list;
                            }));
                        visible = true;
                      }
                    });
                  }
                });
              });
            }));
  }

  Future<dynamic> _refreshMenu() async {
    return await GetJSON().gettypeItem(context, getID);
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
  String nextURL, prevURL, firstURL;
  int offset = 0;
  int total;

  Widget BottomNav() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        InkWell(
            onTap: () {
              setState(() {
                /*  backtapped == true;
                loading = true;*/
                backtapped
                    ? Colors.grey.shade200
                    : GetJSON()
                        .ONCLICKfetcheApprovaldepRequestList(
                            context,
                            new http.Client(),
                            getID,
                            spinnerId,
                            offset,
                            prevURL)
                        .then((String) {
                        print('hello prevURL : ${String}');
                        parseData(String);
                      });
              });
            },
            child: Padding(
              child: Icon(
                Icons.arrow_back_ios,
                color: backtapped ? Colors.grey : ReColors().appMainColor,
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
                /*forwardtapped = true;
                loading = true;*/
                forwardtapped
                    ? Colors.grey.shade200
                    : GetJSON()
                        .ONCLICKfetcheApprovaldepRequestList(
                            context,
                            new http.Client(),
                            getID,
                            spinnerId,
                            offset,
                            nextURL)
                        .then((String) {
                        print('hello nextURL : ${String}');
                        parseData(String);
                      });
              });
            },
            child: Padding(
              child: Icon(
                Icons.arrow_forward_ios,
                color: forwardtapped ? Colors.grey : ReColors().appMainColor,
                size: 25,
              ),
              padding: EdgeInsets.all(15),
            )),
      ],
    );
  }

  Widget CompleteWidget() {
    return Column(
      children: [Expanded(child: profileView()), BottomNav()],
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
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(17.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(1.0, 15.0),
                              blurRadius: 20.0,
                            ),
                          ]),
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              child: Column(
                                children: [
                                  CustomDropdown(
                                    dropdownMenuItemList:
                                        eApprovalTypelist.map((item) {
                                              return DropdownMenuItem(
                                                child: chip(
                                                    item.type,
                                                    item.typecount,
                                                    Colors.grey),
                                                value: item.type,
                                                onTap: () {
                                                  filteredRecored.clear();
                                                  spinnerId = item.typeId;
                                                  print(
                                                      'Selected UNit ID: ${spinnerId}');
                                                  print(
                                                      'selectedSpinnerItem3293: ${selectedSpinnerItem.toString()}');
                                                },
                                              );
                                            }).toList() ??
                                            [],
                                    onChanged: (newVal) {
                                      setState(() {
                                        selectedSpinnerItem = newVal;
                                        print(
                                            'spinnerID: ${selectedSpinnerItem}');
                                        print(
                                            'spinnerID12312: ${spinnerId.toString()}');
                                        print(
                                            'DataLIst: ${filteredRecored.length}');
                                        GetJSON()
                                            .fetcheApprovaldepRequestList(
                                                context,
                                                new http.Client(),
                                                getID,
                                                spinnerId)
                                            .then((String) {
                                          print('hello string2123 : ${String}');
                                          parseData(String);
                                        });
                                        visible = true;
                                        _refreshMenu()
                                            .then((list) => setState(() {
                                                  eApprovalTypelist = list;
                                                }));
                                        print(
                                            'check parsed data${allRecord.length}');
                                      });
                                    },
                                    value: selectedSpinnerItem,
                                    isEnabled: true,
                                    color: ReColors().appMainColor,
                                    hint: '',
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    filteredRecored != null && filteredRecored.length > 0
                        ? ApprovalList(filteredRecored)
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

  Widget ApprovalList(requestlist) {
    return new ListView.builder(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
        physics: NeverScrollableScrollPhysics(),
        primary: false,
        shrinkWrap: true,
        itemCount: requestlist == null ? 0 : requestlist.length,
        itemBuilder: (BuildContext context, int index) {
          DataByTypeitem depReqItem = requestlist[index];

          return new GestureDetector(
              onTap: () {
                print('notify id : ${depReqItem.notificationId}');
                MySharedPreferences.instance
                    .setIntValue("notificationID", depReqItem.notificationId);
                MySharedPreferences.instance
                    .setStringValue("doc_number", depReqItem.documentNumber);
                MySharedPreferences.instance
                    .setStringValue("department", depReqItem.departmentName);
                MySharedPreferences.instance
                    .setStringValue("description", depReqItem.subject);
                MySharedPreferences.instance.setStringValue(
                    "forwarder_remarks", depReqItem.forwarderRemarks);
                MySharedPreferences.instance.setIntValue("hID", depReqItem.hid);

                // new update ...
                MySharedPreferences.instance
                    .setStringValue("fromUserName", depReqItem.fromUserName);
                MySharedPreferences.instance
                    .setStringValue("toUserName", depReqItem.toUserName);
                //prompt...

                MySharedPreferences.instance.setStringValue(
                    "attribute1_prompt",
                    depReqItem.attribute1Prompt == null
                        ? 'null'
                        : depReqItem.attribute1Prompt);
                MySharedPreferences.instance.setStringValue(
                    "attribute2_prompt",
                    depReqItem.attribute2Prompt == null
                        ? 'null'
                        : depReqItem.attribute2Prompt);
                MySharedPreferences.instance.setStringValue(
                    "attribute3_prompt",
                    depReqItem.attribute3Prompt == null
                        ? 'null'
                        : depReqItem.attribute3Prompt);
                MySharedPreferences.instance.setStringValue(
                    "attribute4_prompt",
                    depReqItem.attribute4Prompt == null
                        ? 'null'
                        : depReqItem.attribute4Prompt);
                MySharedPreferences.instance.setStringValue(
                    "attribute5_prompt",
                    depReqItem.attribute5Prompt == null
                        ? 'null'
                        : depReqItem.attribute5Prompt);
                MySharedPreferences.instance.setStringValue(
                    "attribute6_prompt",
                    depReqItem.attribute6Prompt == null
                        ? 'null'
                        : depReqItem.attribute6Prompt);
                MySharedPreferences.instance.setStringValue(
                    "attribute7_prompt",
                    depReqItem.attribute7Prompt == null
                        ? 'null'
                        : depReqItem.attribute7Prompt);
                MySharedPreferences.instance.setStringValue(
                    "attribute8_prompt",
                    depReqItem.attribute8Prompt == null
                        ? 'null'
                        : depReqItem.attribute8Prompt);
                MySharedPreferences.instance.setStringValue(
                    "attribute9_prompt",
                    depReqItem.attribute9Prompt == null
                        ? 'null'
                        : depReqItem.attribute9Prompt);
                MySharedPreferences.instance.setStringValue(
                    "attribute10_prompt",
                    depReqItem.attribute10Prompt == null
                        ? 'null'
                        : depReqItem.attribute10Prompt);

                //value..
                MySharedPreferences.instance.setStringValue(
                    "attribute1_Value",
                    depReqItem.attribute1Value == null
                        ? 'null'
                        : depReqItem.attribute1Value);
                MySharedPreferences.instance.setStringValue(
                    "attribute2_Value",
                    depReqItem.attribute2Value == null
                        ? 'null'
                        : depReqItem.attribute2Value);
                MySharedPreferences.instance.setStringValue(
                    "attribute3_Value",
                    depReqItem.attribute3Value == null
                        ? 'null'
                        : depReqItem.attribute3Value);
                MySharedPreferences.instance.setStringValue(
                    "attribute4_Value",
                    depReqItem.attribute4Value == null
                        ? 'null'
                        : depReqItem.attribute4Value);
                MySharedPreferences.instance.setStringValue(
                    "attribute5_Value",
                    depReqItem.attribute5Value == null
                        ? 'null'
                        : depReqItem.attribute5Value);
                MySharedPreferences.instance.setStringValue(
                    "attribute6_Value",
                    depReqItem.attribute6Value == null
                        ? 'null'
                        : depReqItem.attribute6Value);
                MySharedPreferences.instance.setStringValue(
                    "attribute7_Value",
                    depReqItem.attribute7Value == null
                        ? 'null'
                        : depReqItem.attribute7Value);
                MySharedPreferences.instance.setStringValue(
                    "attribute8_Value",
                    depReqItem.attribute8Value == null
                        ? 'null'
                        : depReqItem.attribute8Value);
                MySharedPreferences.instance.setStringValue(
                    "attribute9_Value",
                    depReqItem.attribute9Value == null
                        ? 'null'
                        : depReqItem.attribute9Value);
                MySharedPreferences.instance.setStringValue(
                    "attribute10_Value",
                    depReqItem.attribute10Value == null
                        ? 'null'
                        : depReqItem.attribute10Value);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TransactionDetails()),
                );
              },
              child: Container(
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Card(
                    elevation: 25,
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
                      child: ClipRRect(borderRadius: BorderRadius.circular(5),
                        child: Container(decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment(-0.9, -1),
                              end: Alignment(-0.1, -0),
                              colors: [
                                ReColors().appMainColor,
                                ReColors().lightappMainColor1
                              ],
                            ),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                          child: Padding(padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: <Widget>[
                                            Text(
                                              '${depReqItem.fromUserName == null ? '' : depReqItem.fromUserName}',
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                                  style: TextStyle(
                                                  color: Colors.white,
                                                  fontFamily: 'headingfont'),
                                            ),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                  '${depReqItem.sentDate}',
                                                  textAlign: TextAlign.right,
                                                  maxLines: 2,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  softWrap: false,
                                                  style: TextStyle(
                                                      fontFamily: 'titlefont',
                                                      color: Colors.white)),
                                            )
                                          ],
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 5, 0, 5),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Expanded(
                                                  child: Text(
                                                '',
                                                textAlign: TextAlign.left,
                                                overflow: TextOverflow.ellipsis,
                                                softWrap: false,
                                                style: TextStyle(
                                                    fontFamily: 'titlefont',
                                                    color: Colors.white),
                                              )),
                                              Expanded(
                                                  child: Text(
                                                      '${depReqItem.documentNumber == null ? '' : depReqItem.documentNumber}',
                                                      textAlign:
                                                          TextAlign.right,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      softWrap: false,
                                                      style: TextStyle(
                                                          fontFamily:
                                                              'titlefont',
                                                          color:
                                                              Colors.white))),
                                            ],
                                          ),
                                        ),
                                        Divider(
                                          height: 1,
                                          color: Colors.grey,
                                        ),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(0, 5, 0, 5),
                                          child: Text(
                                              '${depReqItem.subject == null ? '' : depReqItem.subject}',
                                              style: TextStyle(
                                                  fontFamily: 'titlefont',
                                                  color: Colors.white)),
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
              ));
        });
  }

  String getmonthName(int mon) {
    print('month ${mon}');
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
/*    var someDateTime = new DateTime.now();
    mon = someDateTime.month;*/
  /*  print('month ${mon}');
    print('month ${months[mon - 1]}');
    print('month ${months}');*/
    return months[mon - 1];
  }

  List<DataByTypeitem> allRecord;
  List<Links> offsetList;
  List<Links> allOffsetList;

  bool hasMore;
  int count = 0;

  parseData(String responseBody) {
    // final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    var parse = json.decode(responseBody);
    hasMore = parse["hasMore"];
    offset = parse["offset"];
    count = parse["count"];
    print('offset: ${offset}');
    print('count: ${count}');
    print('hasMore: ${hasMore}');
    var link = parse["links"] as List;
    var data = parse["items"] as List;
    setState(() {
      allRecord = data
          .map<DataByTypeitem>((json) => new DataByTypeitem.fromJson(json))
          .toList();
    });
    setState(() {
      offsetList = link.map<Links>((json) => new Links.fromJson(json)).toList();
    });
    filteredRecored = new List<DataByTypeitem>();
    allOffsetList = new List<Links>();
    filteredRecored.addAll(allRecord);
    offsetList.addAll(allOffsetList);
    print('check parsed allRecord${allRecord.length}');
    print('check parsed filteredRecored${filteredRecored.length}');
    // print('check parsed offsetList${offsetList.length}');
    firstURL = null == offsetList ? 0 : offsetList[2].rel;
    print('condition check URL ${offset == 0 && hasMore == true}');
    print('condition check URL 01${offset == 0 && hasMore == false}');
    print('condition check URL 11${offset > 0 && hasMore == true}');
    print('condition check URL 12${offset > 0 && hasMore == false}');
    if (offset == 0 && hasMore == true) {
      backtapped = true;
      forwardtapped = false;
      total = offset + count;
      loading = false;
      nextURL = offsetList[3].href;
      prevURL = null == offsetList ? 0 : offsetList[4].href;
    } else if (offset == 0 && hasMore == false) {
      backtapped = false;
      forwardtapped = false;
      total = offset + count;
      loading = false;
      nextURL = offsetList[3].href;
      prevURL = null == offsetList ? 0 : offsetList[4].href;
    } else if (offset > 0 && hasMore == true) {
      backtapped = false;
      forwardtapped = false;
      total = offset + count;
      loading = false;
      nextURL = offsetList[3].href;
      prevURL = null == offsetList ? 0 : offsetList[4].href;
    } else if (offset > 0 && hasMore == false) {
      backtapped = false;
      forwardtapped = true;
      total = offset + count;
      loading = false;
      nextURL = offsetList[3].href;
      prevURL = null == offsetList ? 0 : offsetList[3].href;
    }
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
                  'assets/images/eapprovals.png',
                  fit: BoxFit.contain,
                  height: 40,
                ),
                Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'E-Approval',
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
      Set<DataByTypeitem> set = Set.from(allRecord);
      set.forEach((element) => filterList(element, newQuery));
    }

    if (newQuery.isEmpty) {
      filteredRecored.addAll(allRecord);
    }

    setState(() {});
  }

  String depName;
  String subject;
  String fromUserName;
  String documentNumber;
  String attribute1Value, attribute2Value, attribute3Value, attribute4Value;
  String attribute1prompt, attribute2prompt, attribute3prompt, attribute4prompt;

  filterList(DataByTypeitem requestlist, String searchQuery) {
    setState(() {
      depName = requestlist.departmentName?.toLowerCase() ?? 'null';
      attribute1Value = requestlist.attribute1Value?.toLowerCase() ?? 'null';
      attribute2Value = requestlist.attribute2Value?.toLowerCase() ?? 'null';
      attribute3Value = requestlist.attribute3Value?.toLowerCase() ?? 'null';
      attribute4Value = requestlist.attribute4Value?.toLowerCase() ?? 'null';
      attribute4prompt = requestlist.attribute4Prompt?.toLowerCase() ?? 'null';
      attribute3prompt = requestlist.attribute3Prompt?.toLowerCase() ?? 'null';
      attribute2prompt = requestlist.attribute2Prompt?.toLowerCase() ?? 'null';
      attribute1prompt = requestlist.attribute1Prompt?.toLowerCase() ?? 'null';
      subject = requestlist.subject?.toLowerCase() ?? 'null';
      fromUserName = requestlist.fromUserName?.toLowerCase() ?? 'null';
      documentNumber = requestlist.documentNumber?.toLowerCase() ?? 'null';
      if (subject.toLowerCase().contains(searchQuery) ||
          subject.contains(searchQuery) ||
          fromUserName.contains(searchQuery) ||
          fromUserName.toLowerCase().contains(searchQuery) ||
          depName.contains(searchQuery) ||
          documentNumber.contains(searchQuery) ||
          documentNumber.toLowerCase().contains(searchQuery) ||
          attribute1prompt.contains(searchQuery) ||
          attribute1prompt.toLowerCase().contains(searchQuery) ||
          attribute2prompt.contains(searchQuery) ||
          attribute2prompt.toLowerCase().contains(searchQuery) ||
          attribute3prompt.contains(searchQuery) ||
          attribute3prompt.toLowerCase().contains(searchQuery) ||
          attribute4prompt.contains(searchQuery) ||
          attribute4prompt.toLowerCase().contains(searchQuery) ||
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
                eApprovalTypelist = list;
                print(
                    'eApprovaldepRequestList item: ${eApprovalTypelist.length}');
                if (eApprovalTypelist.length == 0) {
                  visible = false;
                  return showError(
                      'No data found', Icons.assignment_late_outlined);
                } else {
                  selectedSpinnerItem = eApprovalTypelist.first.type;
                  spinnerId = eApprovalTypelist.first.typeId;

                  GetJSON()
                      .fetcheApprovaldepRequestList(
                          context, new http.Client(), getID, spinnerId)
                      .then((String) {
                    parseData(String);
                  });
                  if (spinnerId == 14) {
                    MySharedPreferences.instance
                        .setIntValue("typeID", spinnerId);
                  }
                  _refreshMenu().then((list) => setState(() {
                        eApprovalTypelist = list;
                      }));
                  visible = true;
                }
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
                          builder: (BuildContext context) => EapprovalPage()),
                    );
                  },
                )
              : new BackButton(
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MainMenuPopUp()),
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
}
