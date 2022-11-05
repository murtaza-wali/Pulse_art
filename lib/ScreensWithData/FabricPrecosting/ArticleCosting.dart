import 'package:art/HexCodeConverter/Hexcode.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/CustomDrawerAppBar.dart';
import 'package:art/ReuseableWidget/StaticDropdown.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:art/ScreensWithData/Menu/MainMenuPopup.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';

class ArticleCosting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ArticleCostingState();
}

class _ArticleCostingState extends State<ArticleCosting> {
  @override
  void initState() {
    super.initState();
  }

  bool inisChecked = false;
  bool correctionVisibility = false;
  Color color2 = HexColor("#055e8e");
  Color color1 = HexColor("#06283a");
  Color color3 = HexColor("#d5980b");
  Color color4 = HexColor("#725002");
  bool bodyVisibility = true;
  final textControllerInput = TextEditingController();
  final textControllerResult = TextEditingController();
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  bool cottonvisibility = false;
  bool fibervisibility = false;
  bool StretchFilamentvisibility = false;
  bool HardFilamentvisibility = false;
  int _groupValue = -1;

  @override
  Widget build(BuildContext context) {
    return Willpopwidget().getWillScope(Scaffold(
      key: scaffoldKey,
      appBar: new CustomDrawerAppBar(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MainMenuPopUp()),
          );
        },
        refreshonPressed: () {
          scaffoldKey.currentState.openEndDrawer();
        },
        Title: 'Article Costing',
      ),
      endDrawer: Drawer(child: DrawerView()),
      body: bodyVisibility == true
          ? BodyView()
          : Container(
              child: showError('No Data Available', Icons.error),
            ),
    ));
  }

  void _toggleCotton() {
    setState(() {
      cottonvisibility = !cottonvisibility;
      // garmentvisibility = false;
    });
  }

  void _toggleFiber() {
    setState(() {
      fibervisibility = !fibervisibility;
      // garmentvisibility = false;
    });
  }

  void _toggleHardFilament() {
    setState(() {
      HardFilamentvisibility = !HardFilamentvisibility;
      // garmentvisibility = false;
    });
  }

  void _toggleStretchFilament() {
    setState(() {
      StretchFilamentvisibility = !StretchFilamentvisibility;
      // garmentvisibility = false;
    });
  }

  Widget showError(String message, key) {
    return Column(
      children: <Widget>[
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: Icon(
                  key,
                  size: 70,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                message,
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
      ],
    );
  }

  var _tabTextIndexSelected = 1;

  Widget DrawerView() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
      width: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        children: <Widget>[
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Container(
                                padding: EdgeInsets.fromLTRB(6, 5, 6, 5),
                                child: SingleChildScrollView(
                                  child: Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: 130,
                                              child: Dropdown('Article', [
                                                'AMX-380-I-MR-Flash Blue OD',
                                                'AMX-50235-C-FF-Flash Blue OD',
                                              ]),
                                            ),
                                            Container(
                                              width: 130,
                                              child: Dropdown('Fancy Name', []),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Container(
                                              width: 130,
                                              child: Dropdown('Brand', [
                                                'ABILITY',
                                                'AEO',
                                                'AERO JEANS',
                                              ]),
                                            ),
                                            Container(
                                              width: 130,
                                              child: Dropdown('Sales Person', [
                                                'Abid Rizvi',
                                                'Adil Amir',
                                              ]),
                                            ),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            new Container(
                                                width: 120,
                                                child: new TextField(
                                                    decoration:
                                                        new InputDecoration(
                                                      labelText: "Wastage %",
                                                      labelStyle: TextStyle(
                                                        fontSize: 14,
                                                        color: ReColors()
                                                            .appMainColor,
                                                        fontFamily:
                                                            'headingfont',
                                                      ),
                                                      fillColor: ReColors()
                                                          .appMainColor,
                                                      enabledBorder:
                                                          new OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: ReColors()
                                                                .appMainColor),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .black,
                                                                width: 2.0),
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontFamily: 'headingfont',
                                                    ),
                                                    textAlign: TextAlign.left,
                                                    controller:
                                                        textControllerInput,
                                                    onTap: () => {})),
                                            new Container(
                                                width: 120,
                                                child: new TextField(
                                                    decoration:
                                                        new InputDecoration(
                                                      labelText: "Rejection %",
                                                      labelStyle: TextStyle(
                                                        fontSize: 14,
                                                        color: ReColors()
                                                            .appMainColor,
                                                        fontFamily:
                                                            'headingfont',
                                                      ),
                                                      fillColor: ReColors()
                                                          .appMainColor,
                                                      enabledBorder:
                                                          new OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: ReColors()
                                                                .appMainColor),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .black,
                                                                width: 2.0),
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontFamily: 'headingfont',
                                                    ),
                                                    textAlign: TextAlign.left,
                                                    controller:
                                                        textControllerInput,
                                                    onTap: () => {})),
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Container(
                                          child: Dropdown('Customer', [
                                            'TUSUKA JEANS LTD.',
                                            '4 CREATIONS',
                                          ]),
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        FlutterToggleTab(
                                          width: 50,
                                          borderRadius: 15,
                                          selectedBackgroundColors: [
                                            Colors.blue,
                                            Colors.blueAccent
                                          ],
                                          selectedTextStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600),
                                          unSelectedTextStyle: TextStyle(
                                              color: Colors.blue,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400),
                                          labels: ["USD", "PKR"],
                                          selectedLabelIndex: (index) {
                                            setState(() {
                                              _tabTextIndexSelected = index;
                                              print(
                                                  "Selected Index $_tabTextIndexSelected");
                                            });
                                          },
                                          selectedIndex: _tabTextIndexSelected,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        _tabTextIndexSelected == 0
                                            ? new Container(
                                                child: new TextField(
                                                    decoration:
                                                        new InputDecoration(
                                                      labelText:
                                                          "Exchange Rate",
                                                      labelStyle: TextStyle(
                                                        fontSize: 14,
                                                        color: ReColors()
                                                            .appMainColor,
                                                        fontFamily:
                                                            'headingfont',
                                                      ),
                                                      fillColor: ReColors()
                                                          .appMainColor,
                                                      enabledBorder:
                                                          new OutlineInputBorder(
                                                        borderSide: BorderSide(
                                                            color: ReColors()
                                                                .appMainColor),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Colors
                                                                    .black,
                                                                width: 2.0),
                                                      ),
                                                    ),
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontFamily: 'headingfont',
                                                    ),
                                                    textAlign: TextAlign.left,
                                                    controller:
                                                        textControllerInput,
                                                    onTap: () => {}))
                                            : Container(),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        new Container(
                                            child: new TextField(
                                                decoration: new InputDecoration(
                                                  labelText: 'Cotton Price/Lbs',
                                                  labelStyle: TextStyle(
                                                    fontSize: 14,
                                                    color:
                                                        ReColors().appMainColor,
                                                    fontFamily: 'headingfont',
                                                  ),
                                                  fillColor:
                                                      ReColors().appMainColor,
                                                  enabledBorder:
                                                      new OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                        color: ReColors()
                                                            .appMainColor),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide:
                                                        const BorderSide(
                                                            color: Colors.black,
                                                            width: 2.0),
                                                  ),
                                                ),
                                                style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontFamily: 'headingfont',
                                                ),
                                                textAlign: TextAlign.left,
                                                controller: textControllerInput,
                                                onTap: () => {})),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Expanded(
                                                child: Container(
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    5, 5, 5, 5),
                                                child: RaisedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    color:
                                                        ReColors().appMainColor,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            "Calculate",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontFamily:
                                                                    'headerfont'),
                                                          )
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                            )),
                                            Expanded(
                                                child: Container(
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    5, 5, 5, 5),
                                                child: RaisedButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                    color:
                                                        ReColors().appMainColor,
                                                    child: Padding(
                                                      padding:
                                                          EdgeInsets.all(5),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            "Post",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontFamily:
                                                                    'headerfont'),
                                                          )
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                            )),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(6),
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            'Composition',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                                fontFamily: 'headingfont'),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              '100% Cotton',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontFamily: 'headingfont'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Divider(
                                height: 1,
                                color: Colors.grey,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            'Weight',
                                            style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey,
                                                fontFamily: 'headingfont'),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              '11.00 Oz.',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.black,
                                                  fontFamily: 'headingfont'),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              Column(
                                children: [
                                  Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                'Shade',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                    fontFamily: 'headingfont'),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  'TOPPING/Obsidian',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontFamily:
                                                          'headingfont'),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                'Weave+Twill',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                    fontFamily: 'headingfont'),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  '3/1RHT',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontFamily:
                                                          'headingfont'),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                'Rope Ends / Ball',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                    fontFamily: 'headingfont'),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  '419',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontFamily:
                                                          'headingfont'),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                'Reed',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                    fontFamily: 'headingfont'),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  '7.4',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontFamily:
                                                          'headingfont'),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                'Ends/Inch',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                    fontFamily: 'headingfont'),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  '84',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontFamily:
                                                          'headingfont'),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                'Picks/Inch',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                    fontFamily: 'headingfont'),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  '46.5',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontFamily:
                                                          'headingfont'),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                'Std Width',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                    fontFamily: 'headingfont'),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  '61"',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontFamily:
                                                          'headingfont'),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                'Shrinkage Warp',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                    fontFamily: 'headingfont'),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  '0 to -3%',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontFamily:
                                                          'headingfont'),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                'Shrinkage Weft',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                    fontFamily: 'headingfont'),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  '0 to -3%',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontFamily:
                                                          'headingfont'),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Column(
                                children: [
                                  Divider(
                                    height: 1,
                                    color: Colors.grey,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Container(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(5.0),
                                              child: Text(
                                                'Finish Route',
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                    fontFamily: 'headingfont'),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5.0),
                                                child: Text(
                                                  'SINGE + MR + OD + SANFOR',
                                                  textAlign: TextAlign.right,
                                                  style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.black,
                                                      fontFamily:
                                                          'headingfont'),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }

  Widget BodyView() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color1, color2],
                                begin: Alignment.topLeft,
                                end: Alignment(0.8, 0.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Container(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Warp1',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontFamily: 'headerfont'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color1, color2],
                                begin: Alignment.topLeft,
                                end: Alignment(0.8, 0.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text(
                                    'Rs.0',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: 'headerfont'),
                                  ),
                                  Text(
                                    'Rate',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: 'headerfont'),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color1, color2],
                                begin: Alignment.topLeft,
                                end: Alignment(0.8, 0.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Container(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Warp2',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontFamily: 'headerfont'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color1, color2],
                                begin: Alignment.topLeft,
                                end: Alignment(0.8, 0.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text(
                                    'Rs.0',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: 'headerfont'),
                                  ),
                                  Text(
                                    'Rate',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: 'headerfont'),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color1, color2],
                                begin: Alignment.topLeft,
                                end: Alignment(0.8, 0.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Container(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Warp3',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontFamily: 'headerfont'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color1, color2],
                                begin: Alignment.topLeft,
                                end: Alignment(0.8, 0.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Container(
                              width: double.infinity,
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text(
                                    'Rs.0',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: 'headerfont'),
                                  ),
                                  Text(
                                    'Rate',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: 'headerfont'),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [color1, color2],
                          begin: Alignment.topLeft,
                          end: Alignment(0.8, 0.0),
                        ),
                        color: Colors.white,
                      ),
                      child: Container(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: [
                            Text(
                              'Rs.0',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: 'headerfont'),
                            ),
                            Text(
                              'Total Warp Cost',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: 'headerfont'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //................
          SizedBox(
            height: 10,
          ),
          //.................
          Row(
            children: [
              Expanded(
                child: Container(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color1, color2],
                                begin: Alignment.topLeft,
                                end: Alignment(0.8, 0.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Container(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Weft1',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontFamily: 'headerfont'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color1, color2],
                                begin: Alignment.topLeft,
                                end: Alignment(0.8, 0.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text(
                                    'Rs.0',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: 'headerfont'),
                                  ),
                                  Text(
                                    'Rate',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: 'headerfont'),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color1, color2],
                                begin: Alignment.topLeft,
                                end: Alignment(0.8, 0.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Container(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Weft2',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontFamily: 'headerfont'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color1, color2],
                                begin: Alignment.topLeft,
                                end: Alignment(0.8, 0.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text(
                                    'Rs.0',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: 'headerfont'),
                                  ),
                                  Text(
                                    'Rate',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: 'headerfont'),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color1, color2],
                                begin: Alignment.topLeft,
                                end: Alignment(0.8, 0.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Container(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Weft3',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontFamily: 'headerfont'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color1, color2],
                                begin: Alignment.topLeft,
                                end: Alignment(0.8, 0.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text(
                                    'Rs.0',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: 'headerfont'),
                                  ),
                                  Text(
                                    'Rate',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: 'headerfont'),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
            height: 10,
          ),
          Container(
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [color1, color2],
                          begin: Alignment.topLeft,
                          end: Alignment(0.8, 0.0),
                        ),
                        color: Colors.white,
                      ),
                      child: Container(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: [
                            Text(
                              'Rs.0',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: 'headerfont'),
                            ),
                            Text(
                              'Total Weft Cost',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: 'headerfont'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //................
          SizedBox(
            height: 10,
          ),
          //................
          //GOLD

          Row(
            children: [
              Expanded(
                child: Container(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color3, color4],
                                begin: Alignment.topLeft,
                                end: Alignment(0.8, 0.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Container(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Dyeing',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontFamily: 'headerfont'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color3, color4],
                                begin: Alignment.topLeft,
                                end: Alignment(0.8, 0.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text(
                                    'Rs.4',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: 'headerfont'),
                                  ),
                                  Text(
                                    'Rate',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: 'headerfont'),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color3, color4],
                                begin: Alignment.topLeft,
                                end: Alignment(0.8, 0.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Container(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Sizing',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontFamily: 'headerfont'
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color3, color4],
                                begin: Alignment.topLeft,
                                end: Alignment(0.8, 0.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text(
                                    'Rs.4',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: 'headerfont'),
                                  ),
                                  Text(
                                    'Rate',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: 'headerfont'),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color3, color4],
                                begin: Alignment.topLeft,
                                end: Alignment(0.8, 0.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Container(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Finishing',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontFamily: 'headerfont'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color3, color4],
                                begin: Alignment.topLeft,
                                end: Alignment(0.8, 0.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text(
                                    'Rs.3.50',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: 'headerfont'),
                                  ),
                                  Text(
                                    'Rate',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: 'headerfont'),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
            height: 10,
          ),
          Container(
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [color3, color4],
                          begin: Alignment.topLeft,
                          end: Alignment(0.8, 0.0),
                        ),
                        color: Colors.white,
                      ),
                      child: Container(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: [
                            Text(
                              'Rs.57.5',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: 'headerfont'),
                            ),
                            Text(
                              'Total Chemical Cost',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: 'headerfont'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //................
          SizedBox(
            height: 10,
          ),
          //.................

          Row(
            children: [
              Expanded(
                child: Container(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color3, color4],
                                begin: Alignment.topLeft,
                                end: Alignment(0.8, 0.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Container(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Manufacturing',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontFamily: 'headerfont'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color3, color4],
                                begin: Alignment.topLeft,
                                end: Alignment(0.8, 0.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text(
                                    'Rs.102.01',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: 'headerfont'),
                                  ),
                                  Text(
                                    'Rate',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: 'headerfont'),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color3, color4],
                                begin: Alignment.topLeft,
                                end: Alignment(0.8, 0.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Container(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Admin',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontFamily: 'headerfont'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color3, color4],
                                begin: Alignment.topLeft,
                                end: Alignment(0.8, 0.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text(
                                    'Rs.3.99',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: 'headerfont'),
                                  ),
                                  Text(
                                    'Rate',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: 'headerfont'),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color3, color4],
                                begin: Alignment.topLeft,
                                end: Alignment(0.8, 0.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Container(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Selling',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontFamily: 'headerfont'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color3, color4],
                                begin: Alignment.topLeft,
                                end: Alignment(0.8, 0.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text(
                                    'Rs.17.34',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: 'headerfont'),
                                  ),
                                  Text(
                                    'Rate',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: 'headerfont'),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color3, color4],
                                begin: Alignment.topLeft,
                                end: Alignment(0.8, 0.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Container(
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Finance/Others',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontFamily: 'headerfont'),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Divider(
                          height: 1,
                          color: Colors.grey,
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [color3, color4],
                                begin: Alignment.topLeft,
                                end: Alignment(0.8, 0.0),
                              ),
                              color: Colors.white,
                            ),
                            child: Container(
                              padding: EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Text(
                                    'Rs.9.33',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: 'headerfont'),
                                  ),
                                  Text(
                                    'Rate',
                                    style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                        fontFamily: 'headerfont'),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(
            height: 10,
          ),
          Container(
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 5, 5, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [color3, color4],
                          begin: Alignment.topLeft,
                          end: Alignment(0.8, 0.0),
                        ),
                        color: Colors.white,
                      ),
                      child: Container(
                        width: double.infinity,
                        child: Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Texation',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontFamily: 'headerfont'),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [color3, color4],
                          begin: Alignment.topLeft,
                          end: Alignment(0.8, 0.0),
                        ),
                        color: Colors.white,
                      ),
                      child: Container(
                        padding: EdgeInsets.all(20),
                        child: Column(
                          children: [
                            Text(
                              'Rs.6.96',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: 'headerfont'),
                            ),
                            Text(
                              'Rate',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: 'headerfont'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [color3, color4],
                          begin: Alignment.topLeft,
                          end: Alignment(0.8, 0.0),
                        ),
                        color: Colors.white,
                      ),
                      child: Container(
                        padding: EdgeInsets.all(30),
                        child: Column(
                          children: [
                            Text(
                              'Rs.139.36',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: 'headerfont'),
                            ),
                            Text(
                              'Total Overheads',
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: 'headerfont'),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          //................
          SizedBox(
            height: 20,
          ),
          //..............null
          //....................null
          Container(
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.fromLTRB(5, 0, 5, 0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [color1, color2],
                          begin: Alignment.topLeft,
                          end: Alignment(0.8, 0.0),
                        ),
                        color: Colors.white,
                      ),
                      child: Container(
                        padding: EdgeInsets.all(30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Text(
                                  'Rs.208.96/Meter',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontFamily: 'headerfont'),
                                ),
                                Text(
                                  'Rs.191.07/Yards',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontFamily: 'headerfont'),
                                )
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  '\$1.19/Meter',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontFamily: 'headerfont'),
                                ),
                                Text(
                                  '\$1.09/Yards',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                      fontFamily: 'headerfont'),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
