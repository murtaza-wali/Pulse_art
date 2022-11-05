import 'package:art/Model/DAM/DAMunitlist.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/CustomAppbarWithImage.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:art/ScreensWithData/DigitalHR/LMS/Attendance.dart';
import 'package:art/ScreensWithData/Menu/MainMenuPopup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:unicorndial/unicorndial.dart';

class LMSGroup extends StatefulWidget {
  _LMSGroupState createState() => _LMSGroupState();
}

Widget showError(String message, key) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Center(
        child: Icon(
          key,
          size: 70,
        ),
      ),
      SizedBox(
        height: 10,
      ),
      Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 20),
      )
    ],
  );
}

class _LMSGroupState extends State<LMSGroup> {
  List<DamUnitListitem> dam_unit_list = [];
  String selectedSpinnerItem;
  int selected_unit_id;
  int getID;
  String employeCode;
  int InProcess, UserFeedback, closed, pending;
  bool visible = false;
  bool boxesvisible = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget chip(String label) {
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
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    var childButtons = List<UnicornButton>();

    childButtons.add(UnicornButton(
        hasLabel: false,
        labelText: "Trainer",
        labelColor: ReColors().appMainColor,
        currentButton: FloatingActionButton.extended(
          heroTag: "Trainer",
          backgroundColor: ReColors().appMainColor,
          // icon: Icon(Icons.edit),
         /* child: Text('Trainer',
              style: TextStyle(
                  color: Colors.black, fontSize: 18, fontFamily: 'headerfont')),*/
          onPressed: () {
            /*Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Trainer()),
                    (Route<dynamic> route) => false);*/
          }, label: Text('Trainer'),
        )));
    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Training",
        labelColor: ReColors().appMainColor,
        currentButton: FloatingActionButton(
          heroTag: "Training",
          backgroundColor: ReColors().appMainColor,
          mini: true,
          child: Text('Training',
              style: TextStyle(
                  color: Colors.black, fontSize: 18, fontFamily: 'headerfont')),
          onPressed: () {
            /*Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Training()),
                    (Route<dynamic> route) => false);*/
          },
        )));
    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Enrollment",
        labelColor: ReColors().appMainColor,
        currentButton: FloatingActionButton(
          heroTag: "Enrollment",
          backgroundColor: ReColors().appMainColor,
          mini: true,
          child: Text('Enrollment',
              style: TextStyle(
                  color: Colors.black, fontSize: 18, fontFamily: 'headerfont')),
          onPressed: () {
            /*Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Enrollment()),
                    (Route<dynamic> route) => false);*/
          },
        )));
    childButtons.add(UnicornButton(
        hasLabel: true,
        labelText: "Attendance",
        labelColor: ReColors().appMainColor,
        currentButton: FloatingActionButton(
          heroTag: "Attendance",
          backgroundColor: ReColors().appMainColor,
          mini: true,
          child: Text('Attendance',
              style: TextStyle(
                  color: Colors.black, fontSize: 18, fontFamily: 'headerfont')),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => Attendance()),
                (Route<dynamic> route) => false);
          },
        )));
    return Scaffold(
        floatingActionButton: UnicornDialer(
            backgroundColor: Color.fromRGBO(255, 255, 255, 0.6),
            parentButtonBackground: ReColors().appMainColor,
            orientation: UnicornOrientation.VERTICAL,
            parentButton: Icon(Icons.menu),
            childButtons: childButtons),
        appBar: new CustomAppBarImage(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => MainMenuPopUp()),
            );
          },
          Title: 'Digital HR',
          image_bar: 'assets/images/hrms_logo2.png',
          refreshonPressed: () {},
        ),
        body: Willpopwidget().getWillScope(SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Container(),
          ),
        )));
  }
}

class chlidDAMain extends StatefulWidget {
  int in_process, user_feedback, closed, pending;
  bool boxesvisible = false;

  chlidDAMain(
      {Key key,
      this.in_process,
      this.user_feedback,
      this.closed,
      this.pending,
      this.boxesvisible})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChildDAMState();
}

class _ChildDAMState extends State<chlidDAMain> {
  @override
  Widget build(BuildContext context) {
    return boxesVisibility(widget.in_process, widget.user_feedback,
        widget.closed, widget.pending, widget.boxesvisible);
  }

  Widget boxesVisibility(
      inprocess, userfeedback, closed, pending, boxesvisible) {
    return Visibility(
        visible: boxesvisible,
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Column(
            children: [
              Card(
                // semanticContainer: true,
                // yeh shadow dekhata hai
                // clipBehavior: Clip.antiAlias,
                child: Container(
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                  decoration: BoxDecoration(
                    // border: Border.all(color: Color(0xff940D5A)),
                    gradient: LinearGradient(
                      begin: Alignment(-0.6, -1),
                      end: Alignment(-1, -0),
                      colors: [
                        ReColors().eit_in_process_color,
                        ReColors().eit_in_process_color
                      ],
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Center(
                            child: Text(
                          "In Process",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              fontFamily: 'headerfont',
                              color: ReColors().appTextWhiteColor),
                        )),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.sync,
                              color: Colors.white,
                              size: 40,
                            ),
                            Text(
                              '${inprocess == null ? 'loading...' : inprocess}',
                              style: TextStyle(
                                color: ReColors().appTextWhiteColor,
                                fontSize: 30.0,
                                fontFamily: 'headingfont',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17.0),
                ),
                elevation: 5,
                margin: EdgeInsets.all(10),
              ),
              Card(
                // semanticContainer: true,
                // yeh shadow dekhata hai
                // clipBehavior: Clip.antiAlias,
                child: Container(
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                  decoration: BoxDecoration(
                    // border: Border.all(color: Color(0xff940D5A)),
                    gradient: LinearGradient(
                      begin: Alignment(-0.6, -1),
                      end: Alignment(-1, -0),
                      colors: [
                        ReColors().eit_pending_color,
                        ReColors().eit_pending_color
                      ],
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Center(
                            child: Text(
                          "Pending",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              fontFamily: 'headerfont',
                              color: ReColors().appTextWhiteColor),
                        )),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.hourglass,
                              color: Colors.white,
                              size: 40,
                            ),
                            Text(
                              '${pending == null ? 'loading...' : pending}',
                              style: TextStyle(
                                color: ReColors().appTextWhiteColor,
                                fontSize: 30.0,
                                fontFamily: 'headingfont',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17.0),
                ),
                elevation: 5,
                margin: EdgeInsets.all(10),
              ),
              Card(
                // semanticContainer: true,
                // yeh shadow dekhata hai
                // clipBehavior: Clip.antiAlias,
                child: Container(
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                  decoration: BoxDecoration(
                    // border: Border.all(color: Color(0xff940D5A)),
                    gradient: LinearGradient(
                      begin: Alignment(-0.6, -1),
                      end: Alignment(-1, -0),
                      colors: [
                        ReColors().eit_user_feedback_color,
                        ReColors().eit_user_feedback_color
                      ],
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Center(
                            child: Text(
                          "User Feedback",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              fontFamily: 'headerfont',
                              color: ReColors().appTextWhiteColor),
                        )),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.user,
                              color: Colors.white,
                              size: 40,
                            ),
                            Text(
                              '${userfeedback == null ? 'loading...' : userfeedback}',
                              style: TextStyle(
                                color: ReColors().appTextWhiteColor,
                                fontSize: 30.0,
                                fontFamily: 'headingfont',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17.0),
                ),
                elevation: 5,
                margin: EdgeInsets.all(10),
              ),
              Card(
                // semanticContainer: true,
                // yeh shadow dekhata hai
                // clipBehavior: Clip.antiAlias,
                child: Container(
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                  decoration: BoxDecoration(
                    // border: Border.all(color: Color(0xff940D5A)),
                    gradient: LinearGradient(
                      begin: Alignment(-0.6, -1),
                      end: Alignment(-1, -0),
                      colors: [
                        ReColors().eit_closed_color,
                        ReColors().eit_closed_color
                      ],
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(17.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Center(
                            child: Text(
                          "Closed",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          style: TextStyle(
                              fontFamily: 'headerfont',
                              color: ReColors().appTextWhiteColor),
                        )),
                      ),
                      Divider(
                        color: Colors.white,
                      ),
                      Padding(
                        padding: EdgeInsets.all(5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.checkCircle,
                              color: Colors.white,
                              size: 40,
                            ),
                            Text(
                              '${closed == null ? 'loading...' : closed}',
                              style: TextStyle(
                                color: ReColors().appTextWhiteColor,
                                fontSize: 30.0,
                                fontFamily: 'headingfont',
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17.0),
                ),
                elevation: 5,
                margin: EdgeInsets.all(10),
              ),
            ],
          ),
        ));
  }
}
