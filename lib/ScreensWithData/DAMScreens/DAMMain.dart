import 'dart:io';

import 'package:art/Error/Error.dart';
import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/Model/DAM/DAMunitlist.dart';
import 'package:art/ParsingJSON/GetJSONMethod.dart';
import 'package:art/ParsingJSON/PostJSONMethod.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/CustomAppbarWithImage.dart';
import 'package:art/ReuseableWidget/CustomDropdown.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:art/ScreensWithData/Menu/MainMenuPopup.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DamMain extends StatefulWidget {
  _DamMainState createState() => _DamMainState();
}

class _DamMainState extends State<DamMain> {
  List<DamUnitListitem> dam_unit_list = [];
  bool boxesvisible = false;
  int getID;
  String selectedSpinnerItem;
  int selected_unit_id;
  String employeCode;
  int asset, components, accessories, consumables;
  int asset1, components2, accessories3, consumables4;

  @override
  void initState() {
    super.initState();

    MySharedPreferences.instance
        .getIntValue("UserId")
        .then((value) => setState(() {
              getID = value;
              print(getID);
              GetJSON().getDAMUnitList(getID).then((DAMData) {
                setState(() {
                  dam_unit_list = DAMData;
                  if (dam_unit_list.length == 0) {
                    // visible = false;
                    return showError(
                        'No data found', Icons.assignment_late_outlined);
                  } else {
                    selected_unit_id = dam_unit_list.first.orgId;
                    // visible = true;
                  }
                });
              });
            }));
    MySharedPreferences.instance.getStringValue("employeecode").then((name) {
      setState(() {
        if (mounted == true) {
          employeCode = name;
          print('Main MEnu${employeCode}');
        }
      });
    });
  }

  Future<dynamic> _refreshMenu() async {
    return await GetJSON().getDAMUnitList(getID);
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
    return Willpopwidget().getWillScope(Scaffold(
      appBar: new CustomAppBarImage(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MainMenuPopUp()),
          );
        },
        Title: 'DAM',
        image_bar: 'assets/images/dam.png',
        refreshonPressed: () {
          _refreshMenu().then((list) {
            setState(() {
              dam_unit_list = list;
              if (dam_unit_list.length == 0) {
                // visible = false;
                return showError(
                    'No data found', Icons.assignment_late_outlined);
              } else {
                selected_unit_id = dam_unit_list.first.orgId;
                // visible = true;
              }
            });
          });
        },
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.all(5),
                        child: FutureBuilder<List<DamUnitListitem>>(
                          future: GetJSON().getDAMUnitList(getID),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return CustomDropdown(
                                dropdownMenuItemList:
                                dam_unit_list.map((item) {
                                  return DropdownMenuItem(
                                    child: chip(item.companycode),
                                    value: item.companycode,
                                    onTap: () {
                                      selected_unit_id = item.orgId;
                                      print(
                                          'Selected UNit ID: ${selected_unit_id}');
                                      print(
                                          'selectedSpinnerItem3293: ${selectedSpinnerItem.toString()}');
                                    },
                                  );
                                }).toList() ??
                                    [],
                                onChanged: (newVal) {
                                  setState(() {
                                    selectedSpinnerItem = newVal;
                                    boxesvisible = true;
                                    print(
                                        'selected_unit_id test: ${selected_unit_id.toString()}');
                                    print(
                                        'selectedSpinnerItem test: ${selectedSpinnerItem.toString()}');
                                    postJSON().PostAssets(selected_unit_id, employeCode, 1).then((value) {
                                      asset = value;
                                      print('asset: ${asset}');
                                      _refreshMenu().then((list) {
                                        setState(() {
                                          dam_unit_list = list;
                                          if (dam_unit_list.length == 0) {
                                            // visible = false;
                                            return showError('No data found', Icons.assignment_late_outlined);
                                          }
                                          else {
                                            selected_unit_id =
                                                dam_unit_list.first.orgId;
                                            // visible = true;
                                          }
                                        });
                                      });
                                    });
                                    postJSON().PostAssets(
                                        selected_unit_id, employeCode, 2)
                                        .then((value) {
                                      components = value;
                                      print('components: ${components}');
                                      _refreshMenu().then((list) {
                                        setState(() {
                                          dam_unit_list = list;
                                          if (dam_unit_list.length == 0) {
                                            // visible = false;
                                            return showError(
                                                'No data found',
                                                Icons
                                                    .assignment_late_outlined);
                                          } else {
                                            selected_unit_id =
                                                dam_unit_list.first.orgId;
                                            // visible = true;
                                          }
                                        });
                                      });
                                    });
                                    postJSON()
                                        .PostAssets(
                                        selected_unit_id, employeCode, 3)
                                        .then((value) {
                                      accessories = value;
                                      print('accessories: ${accessories}');
                                      _refreshMenu().then((list) {
                                        setState(() {
                                          dam_unit_list = list;
                                          if (dam_unit_list.length == 0) {
                                            // visible = false;
                                            return showError(
                                                'No data found',
                                                Icons
                                                    .assignment_late_outlined);
                                          }
                                          else {
                                            selected_unit_id =
                                                dam_unit_list.first.orgId;
                                            // visible = true;
                                          }
                                        });
                                      });
                                    });
                                    postJSON()
                                        .PostAssets(
                                        selected_unit_id, employeCode, 4)
                                        .then((value) {
                                      consumables = value;
                                      print('consumables: ${consumables}');
                                      _refreshMenu().then((list) {
                                        setState(() {
                                          dam_unit_list = list;
                                          if (dam_unit_list.length == 0) {
                                            // visible = false;
                                            return showError(
                                                'No data found',
                                                Icons
                                                    .assignment_late_outlined);
                                          } else {
                                            selected_unit_id =
                                                dam_unit_list.first.orgId;
                                            // visible = true;
                                          }
                                        });
                                      });
                                    });
                                  });
                                },
                                value: selectedSpinnerItem,
                                isEnabled: true,
                                color: ReColors().appMainColor,
                                hint: 'Unit',
                              );
                            }
                            else if (snapshot.hasError) {
                              if (snapshot.error is HttpException) {
                                HttpException httpException =
                                snapshot.error as HttpException;
                                return showError(
                                    'An http error occurred.Page not found. Please try again.',
                                    Icons.error);
                              }
                              if (snapshot.error is NoInternetException) {
                                NoInternetException noInternetException =
                                snapshot.error as NoInternetException;
                                return showError(
                                    'Please check your internet connection',
                                    Icons
                                        .signal_wifi_connected_no_internet_4_sharp);
                              }
                              if (snapshot.error is NoServiceFoundException) {
                                NoServiceFoundException noServiceFoundException =
                                snapshot.error as NoServiceFoundException;
                                return showError(
                                    'Server Error.', Icons.error);
                              }
                              if (snapshot.error is InvalidFormatException) {
                                InvalidFormatException invalidFormatException =
                                snapshot.error as InvalidFormatException;
                                return showError(
                                    'There is a problem with your request.',
                                    Icons.error);
                              }
                              if (snapshot.error is SocketException) {
                                SocketException socketException =
                                snapshot.error as SocketException;
                                print(
                                    'Socket checking: ${socketException.message}');
                                return showError(
                                    'Please check your internet connection',
                                    Icons.signal_wifi_connected_no_internet_4_sharp);
                              } else {
                                UnknownException unknownException =
                                snapshot.error as UnknownException;
                                return showError(
                                    'An Unknown error occurred.', Icons.error);
                              }
                            }
                            return Center(
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      ReColors().appMainColor),
                                ));
                          },
                        )),
                    Container(
                        child: chlidDAMain(
                          asset: asset,
                          accessories: accessories,
                          consumables: consumables,
                          components: components,
                          boxesvisible: boxesvisible,
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

class chlidDAMain extends StatefulWidget {
  int asset, consumables, components, accessories;
  bool boxesvisible = false;

  chlidDAMain(
      {Key key,
      this.asset,
      this.consumables,
      this.components,
      this.accessories,
      this.boxesvisible})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _ChildDAMState();
}

class _ChildDAMState extends State<chlidDAMain> {
  @override
  Widget build(BuildContext context) {
    return boxesVisibility(widget.asset, widget.consumables, widget.components,
        widget.accessories, widget.boxesvisible);
  }

  Widget boxesVisibility(
      asset, consumables, components, accessories, boxesvisible) {
    return Visibility(
        visible: boxesvisible,
        child: Padding(
          padding: EdgeInsets.all(0),
          child: Column(
            children: [
              Card(
                child: Container(
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                  decoration: BoxDecoration(
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
                          "Total\n Assets",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          textAlign: TextAlign.center,
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
                              FontAwesomeIcons.laptop,
                              color: Colors.white,
                              size: 40,
                            ),
                            Text(
                              '${asset == null ? 'loading...' : asset}',
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

                child: Container(
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                  decoration: BoxDecoration(
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
                          "Total\n Component",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          textAlign: TextAlign.center,
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
                              FontAwesomeIcons.server,
                              color: Colors.white,
                              size: 40,
                            ),
                            Text(
                              '${components == null ? 'loading...' : components}',
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

                child: Container(
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                  decoration: BoxDecoration(
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
                          "Total\n Accessories",
                          textAlign: TextAlign.center,
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
                            Icon(
                              Icons.keyboard,
                              color: Colors.white,
                              size: 40,
                            ),
                            Text(
                              '${accessories == null ? 'loading...' : accessories}',
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

                child: Container(
                  padding: EdgeInsets.fromLTRB(40, 10, 40, 10),
                  decoration: BoxDecoration(
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
                          "Total\n Consumables",
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                          textAlign: TextAlign.center,
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
                            Icon(
                              Icons.assignment_sharp,
                              color: Colors.white,
                              size: 40,
                            ),
                            Text(
                              '${consumables == null ? 'loading...' : consumables}',
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
              )
            ],
          ),
        ));
  }
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
