import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/CustomAppbarWithImage.dart';
import 'package:art/ReuseableWidget/StaticDropdown.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'eitMain.dart';

class CategoriesModel {
  String sub = "";
  String from = "";
  String complaint_by = "";
  String assign_to = "";
  String _status = "";
  String severity = "";
  String ticket_date = "";

  CategoriesModel(String subject, String from, String complaint_by,
      String assign_to, String status, String severity, String date) {
    this.sub = subject;
    this.from = from;
    this.complaint_by = complaint_by;
    this.assign_to = assign_to;
    this._status = status;
    this.severity = severity;
    this.ticket_date = date;
  }
}

class CategoryRepository {
  Future<List<CategoriesModel>> findAllAsync() {
    return Future.value([
      new CategoriesModel('Subject', "From", "Complaint by", 'Assign to',
          'Status', 'Severity', 'Ticket Date'),
      new CategoriesModel(
          'Testing 12', "ERP Dept", "CO", 'Taha', 'active', 'low', '2-3-2021'),
      new CategoriesModel(
          'Testing 34', "ERP Dept", "CO", 'Hamza', 'active', 'low', '2-3-2021'),
      new CategoriesModel(
          'Testing 45', "IT Dept", "CO", 'Yamna', 'active', 'low', '2-3-2021'),
      new CategoriesModel(
          'Testing 67', "IT Dept", "CO", 'Uroosa', 'active', 'low', '2-3-2021'),
    ]);
  }
}

class Report extends StatefulWidget {
  @override
  _ReportState createState() => _ReportState();
}

class _ReportState extends State<Report> {
  String _tosetDate;
  String _fromsetDate;

  String todateTime;
  String fromdateTime;

  DateTime toselectedDate = DateTime.now();
  DateTime fromselectedDate = DateTime.now();

  TextEditingController _todateController = TextEditingController();
  TextEditingController _fromdateController = TextEditingController();

  @override
  void initState() {
    _todateController.text = DateFormat.yMd().format(DateTime.now());
    _fromdateController.text = DateFormat.yMd().format(DateTime.now());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: new CustomAppBarImage(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (BuildContext context) => eitMain()),
            );
          },
          Title: 'SERVICE DESK',
          image_bar: 'assets/images/EIT_logo.png',
          refreshonPressed: () {},
        ),
        body: Willpopwidget().getWillScope(FutureBuilder<List<CategoriesModel>>(
          future: CategoryRepository().findAllAsync(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return reportView(snapshot.data);
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        )));
  }

  Future<Null> _toselectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: toselectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        toselectedDate = picked;
        _todateController.text = DateFormat.yMd().format(toselectedDate);
      });
  }

  Future<Null> _fromselectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: fromselectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        fromselectedDate = picked;
        _fromdateController.text = DateFormat.yMd().format(fromselectedDate);
      });
  }

  Widget reportView(List<CategoriesModel> categories) {
    return Container(
      color: ReColors().appTextWhiteColor,
      child: Padding(
        padding: EdgeInsets.all(5),
        child: Column(
          children: [
            Expanded(
                child: SingleChildScrollView(
                    child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(5),
                            child: Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'To',
                                style: TextStyle(
                                  color: ReColors().appMainColor,
                                  fontFamily: 'headingfont',
                                ),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              _toselectDate(context);
                            },
                            child: Container(
                                padding: EdgeInsets.all(5.0),
                                child: TextFormField(
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontFamily: 'headingfont',
                                      fontSize: 15.0,
                                      color: Colors.white),
                                  enabled: false,
                                  keyboardType: TextInputType.text,
                                  controller: _todateController,
                                  onSaved: (String val) {
                                    _tosetDate = val;
                                  },
                                  autocorrect: true,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(
                                      Icons.calendar_today_rounded,
                                      color: ReColors().appTextWhiteColor,
                                    ),
                                    hintStyle: TextStyle(color: Colors.grey),
                                    filled: true,
                                    fillColor: ReColors().appMainColor,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0)),
                                      borderSide: BorderSide(
                                          color: Colors.green, width: 2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0)),
                                      borderSide: BorderSide(
                                          color: Colors.green, width: 2),
                                    ),
                                  ),
                                )),
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.all(5),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'From',
                              style: TextStyle(
                                color: ReColors().appMainColor,
                                fontFamily: 'headingfont',
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _fromselectDate(context);
                          },
                          child: Container(
                              padding: EdgeInsets.all(5.0),
                              child: TextFormField(
                                textAlign: TextAlign.center,
                                enabled: false,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                    fontFamily: 'headingfont',
                                    fontSize: 15.0,
                                    color: Colors.white),
                                controller: _fromdateController,
                                onSaved: (String val) {
                                  _fromsetDate = val;
                                },
                                autocorrect: true,
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.calendar_today_rounded,
                                      color: ReColors().appTextWhiteColor),
                                  hintStyle: TextStyle(color: Colors.grey),
                                  filled: true,
                                  fillColor: ReColors().appMainColor,
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12.0)),
                                    borderSide: BorderSide(
                                        color: Colors.green, width: 2),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10.0)),
                                    borderSide: BorderSide(
                                        color: Colors.green, width: 2),
                                  ),
                                ),
                              )),
                        )
                      ],
                    )),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child:
                          Dropdown('Unit', ['CO', 'AM3', 'AM8', 'AM6', 'AM7']),
                    ),
                    Expanded(
                      child: Dropdown('Type', ['In-process', 'Closed']),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        primary: false,
                        shrinkWrap: true,
                        itemCount: categories == null ? 0 : categories.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          return listText(categories[index]);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            )))
          ],
        ),
      ),
    );
  }

  ListView buildListView(List<CategoriesModel> categories) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: categories == null ? 0 : categories.length,
      itemBuilder: (BuildContext ctx, int index) {
        return listText(categories[index]);
      },
    );
  }

  Widget listText(CategoriesModel category) {
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    '${category.sub}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'headingfont'),
                                  ),
                                  Text('${category.from}',
                                      style: TextStyle(
                                          fontFamily: 'titlefont',
                                          color: Colors.white)),
                                ],
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Expanded(
                                        child: Text(
                                      '${category.complaint_by}',
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                          fontFamily: 'titlefont',
                                          color: Colors.white),
                                    )),
                                    Expanded(
                                        child: Text('${category.assign_to}',
                                            textAlign: TextAlign.right,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            style: TextStyle(
                                                fontFamily: 'titlefont',
                                                color: Colors.white))),
                                  ],
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
                                      '${category.severity}',
                                      textAlign: TextAlign.left,
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                          fontFamily: 'titlefont',
                                          color: Colors.white),
                                    )),
                                    Expanded(
                                        child: Text('${category.ticket_date}',
                                            textAlign: TextAlign.right,
                                            overflow: TextOverflow.ellipsis,
                                            softWrap: false,
                                            style: TextStyle(
                                                fontFamily: 'titlefont',
                                                color: Colors.white))),
                                  ],
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                                child: Text('${category._status}',
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: false,
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
    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}
