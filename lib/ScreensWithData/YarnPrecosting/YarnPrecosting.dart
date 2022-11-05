import 'package:art/HexCodeConverter/Hexcode.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/CustomAppBarDrawer.dart';
import 'package:art/ReuseableWidget/CustomAppbarWidget.dart';
import 'package:art/ReuseableWidget/CustomDrawerAppBar.dart';
import 'package:art/ReuseableWidget/StaticDropdown.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:art/ScreensWithData/Menu/MainMenuPopup.dart';
import 'package:flutter/material.dart';

class Yarnprecosting extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _YarnprecostingState();
}

class _YarnprecostingState extends State<Yarnprecosting> {
  @override
  void initState() {
    super.initState();
  }

  bool inisChecked = false;
  bool correctionVisibility = false;
  Color color2 = HexColor("#055e8e");
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
        Title: 'Yarn Pre Costing',
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
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 0, 0),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: new Text(
                                                      'Cotton',
                                                      textAlign: TextAlign.left,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      softWrap: false,
                                                      style: TextStyle(
                                                          color: ReColors()
                                                              .appTextWhiteColor,
                                                          fontSize: 18,
                                                          fontFamily:
                                                              'headerfont'),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: InkWell(
                                          onTap: _toggleCotton,
                                          child: Icon(
                                            Icons.add,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: ReColors().appMainColor,
                                  borderRadius: BorderRadius.circular(17.0),
                                )),
                            Visibility(
                                visible: cottonvisibility,
                                child: Container(
                                    /*decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                          Colors.black,
                                          ReColors().appMainColor,
                                          ReColors().appMainColor,
                                          Colors.black
                                        ]))*/
                                    padding: EdgeInsets.fromLTRB(6, 5, 6, 5),
                                    child: SingleChildScrollView(
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              child: Column(
                                                children: [
                                                  new Text(
                                                    'Cotton Price / Maund',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: ReColors()
                                                            .appTextBlackColor,
                                                        fontSize: 18,
                                                        fontFamily:
                                                            'headerfont'),
                                                  ),
                                                  new Padding(
                                                      padding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 0),
                                                      child: new TextField(
                                                          decoration:
                                                              new InputDecoration(
                                                            hintText: "0",
                                                            hintStyle:
                                                                TextStyle(
                                                              fontSize: 18,
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  'headingfont',
                                                            ),
                                                            fillColor:
                                                                Colors.white,
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
                                                                          .white,
                                                                      width:
                                                                          2.0),
                                                            ),
                                                          ),
                                                          style: TextStyle(
                                                            fontSize: 18,
                                                            color: Colors.black,
                                                            fontFamily:
                                                                'headingfont',
                                                          ),
                                                          textAlign:
                                                              TextAlign.right,
                                                          controller:
                                                              textControllerInput,
                                                          onTap: () => {})),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              child: Column(
                                                children: [
                                                  new Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      new Text(
                                                        'Margin Basis',
                                                        style: new TextStyle(
                                                          fontSize: 18.0,
                                                          fontFamily:
                                                              'headerfont',
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height: 10,
                                                            //Make it equal to height of radio button
                                                            width: 10,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 6),
                                                            //Apply margins and(or) paddings as per requirement

                                                            //Make it equal to width of radio button
                                                            child: new Radio(
                                                              value: 1,
                                                              groupValue:
                                                                  _groupValue,
                                                              onChanged: (newValue) =>
                                                                  setState(() =>
                                                                      _groupValue =
                                                                          newValue),
                                                            ),
                                                          ),
                                                          new Text(
                                                            '%',
                                                            style:
                                                                new TextStyle(
                                                              fontSize: 16.0,
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  'headingfont',
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                            height: 10,
                                                          ),
                                                          Container(
                                                            height: 10,
                                                            width: 10,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 6),
                                                            //Apply margins and(or) paddings as per requirement

                                                            child: new Radio(
                                                              value: 2,
                                                              groupValue:
                                                                  _groupValue,
                                                              onChanged: (newValue) =>
                                                                  setState(() =>
                                                                      _groupValue =
                                                                          newValue),
                                                            ),
                                                          ),
                                                          new Text(
                                                            'Fixed',
                                                            style:
                                                                new TextStyle(
                                                              fontSize: 16.0,
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  'headingfont',
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              child: Dropdown('Unit',
                                                  ['AM3', 'AM8', 'AM17']),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              child: Dropdown('Yarn Process', [
                                                'OE',
                                                'Ring',
                                              ]),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              child: Dropdown('Count', [
                                                '6/1',
                                                '6.4/1',
                                                '6.5/1',
                                                '6.3/1',
                                              ]),
                                            ),
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              child: Column(
                                                children: [
                                                  new Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      new Text(
                                                        'Yarn Type',
                                                        style: new TextStyle(
                                                          fontSize: 18.0,
                                                          fontFamily:
                                                              'headerfont',
                                                        ),
                                                      ),
                                                      Row(
                                                        children: [
                                                          Container(
                                                            height: 10,
                                                            //Make it equal to height of radio button
                                                            width: 10,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 6),
                                                            //Apply margins and(or) paddings as per requirement

                                                            //Make it equal to width of radio button
                                                            child: new Radio(
                                                              value: 1,
                                                              groupValue:
                                                                  _groupValue,
                                                              onChanged: (newValue) =>
                                                                  setState(() =>
                                                                      _groupValue =
                                                                          newValue),
                                                            ),
                                                          ),
                                                          new Text(
                                                            'Plain',
                                                            style:
                                                                new TextStyle(
                                                              fontSize: 16.0,
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  'headingfont',
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: 10,
                                                            height: 10,
                                                          ),
                                                          Container(
                                                            height: 10,
                                                            width: 10,
                                                            margin:
                                                                EdgeInsets.only(
                                                                    right: 6),
                                                            //Apply margins and(or) paddings as per requirement

                                                            child: new Radio(
                                                              value: 2,
                                                              groupValue:
                                                                  _groupValue,
                                                              onChanged: (newValue) =>
                                                                  setState(() =>
                                                                      _groupValue =
                                                                          newValue),
                                                            ),
                                                          ),
                                                          new Text(
                                                            'Slub',
                                                            style:
                                                                new TextStyle(
                                                              fontSize: 16.0,
                                                              color:
                                                                  Colors.black,
                                                              fontFamily:
                                                                  'headingfont',
                                                            ),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10,
                                            ),
                                            Container(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                          child: FlatButton(
                                                              // here toggle the bool value so that when you click
                                                              // on the whole item, it will reflect changes in Checkbox
                                                              onPressed: () =>
                                                                  setState(() =>
                                                                      inisChecked =
                                                                          !inisChecked),
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    SizedBox(
                                                                        height:
                                                                            10.0,
                                                                        width:
                                                                            10.0,
                                                                        child: Checkbox(
                                                                            value: inisChecked,
                                                                            onChanged: (value) {
                                                                              setState(() => inisChecked = value);
                                                                            })),
                                                                    // You can play with the width to adjust your
                                                                    // desired spacing
                                                                    SizedBox(
                                                                        width:
                                                                            10.0),
                                                                    Text(
                                                                        "Siro  ",
                                                                        style: TextStyle(
                                                                            color:
                                                                                ReColors().appTextBlackColor,
                                                                            fontFamily: 'headingfont')),
                                                                  ]))),
                                                      Container(
                                                          child: FlatButton(
                                                              // here toggle the bool value so that when you click
                                                              // on the whole item, it will reflect changes in Checkbox
                                                              onPressed: () =>
                                                                  setState(() =>
                                                                      inisChecked =
                                                                          !inisChecked),
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    SizedBox(
                                                                        height:
                                                                            10.0,
                                                                        width:
                                                                            10.0,
                                                                        child: Checkbox(
                                                                            value: inisChecked,
                                                                            onChanged: (value) {
                                                                              setState(() => inisChecked = value);
                                                                            })),
                                                                    // You can play with the width to adjust your
                                                                    // desired spacing
                                                                    SizedBox(
                                                                        width:
                                                                            10.0),
                                                                    Text("Q",
                                                                        style: TextStyle(
                                                                            color:
                                                                                ReColors().appTextBlackColor,
                                                                            fontFamily: 'headingfont')),
                                                                  ]))),
                                                      Container(
                                                          child: FlatButton(
                                                              // here toggle the bool value so that when you click
                                                              // on the whole item, it will reflect changes in Checkbox
                                                              onPressed: () =>
                                                                  setState(() =>
                                                                      inisChecked =
                                                                          !inisChecked),
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    SizedBox(
                                                                        height:
                                                                            10.0,
                                                                        width:
                                                                            10.0,
                                                                        child: Checkbox(
                                                                            value: inisChecked,
                                                                            onChanged: (value) {
                                                                              setState(() => inisChecked = value);
                                                                            })),
                                                                    // You can play with the width to adjust your
                                                                    // desired spacing
                                                                    SizedBox(
                                                                        width:
                                                                            10.0),
                                                                    Text(
                                                                        "CC    ",
                                                                        style: TextStyle(
                                                                            color:
                                                                                ReColors().appTextBlackColor,
                                                                            fontFamily: 'headingfont')),
                                                                  ]))),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Container(
                                                          child: FlatButton(
                                                              // here toggle the bool value so that when you click
                                                              // on the whole item, it will reflect changes in Checkbox
                                                              onPressed: () =>
                                                                  setState(() =>
                                                                      inisChecked =
                                                                          !inisChecked),
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    SizedBox(
                                                                        height:
                                                                            10.0,
                                                                        width:
                                                                            10.0,
                                                                        child: Checkbox(
                                                                            value: inisChecked,
                                                                            onChanged: (value) {
                                                                              setState(() => inisChecked = value);
                                                                            })),
                                                                    // You can play with the width to adjust your
                                                                    // desired spacing
                                                                    SizedBox(
                                                                        width:
                                                                            10.0),
                                                                    Text(
                                                                        "Compact",
                                                                        style: TextStyle(
                                                                            color:
                                                                                ReColors().appTextBlackColor,
                                                                            fontFamily: 'headingfont')),
                                                                  ]))),
                                                      Container(
                                                          child: FlatButton(
                                                              // here toggle the bool value so that when you click
                                                              // on the whole item, it will reflect changes in Checkbox
                                                              onPressed: () =>
                                                                  setState(() =>
                                                                      inisChecked =
                                                                          !inisChecked),
                                                              child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    SizedBox(
                                                                        height:
                                                                            10.0,
                                                                        width:
                                                                            10.0,
                                                                        child: Checkbox(
                                                                            value: inisChecked,
                                                                            onChanged: (value) {
                                                                              setState(() => inisChecked = value);
                                                                            })),
                                                                    // You can play with the width to adjust your
                                                                    // desired spacing
                                                                    SizedBox(
                                                                        width:
                                                                            10.0),
                                                                    Text(
                                                                        "S Twist",
                                                                        style: TextStyle(
                                                                            color:
                                                                                ReColors().appTextBlackColor,
                                                                            fontFamily: 'headingfont')),
                                                                  ]))),
                                                    ],
                                                  ),
                                                  Container(
                                                      child: FlatButton(
                                                          // here toggle the bool value so that when you click
                                                          // on the whole item, it will reflect changes in Checkbox
                                                          onPressed: () =>
                                                              setState(() =>
                                                                  inisChecked =
                                                                      !inisChecked),
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                SizedBox(
                                                                    height:
                                                                        10.0,
                                                                    width: 10.0,
                                                                    child: Checkbox(
                                                                        value: inisChecked,
                                                                        onChanged: (value) {
                                                                          setState(() =>
                                                                              inisChecked = value);
                                                                        })),
                                                                // You can play with the width to adjust your
                                                                // desired spacing
                                                                SizedBox(
                                                                    width:
                                                                        10.0),
                                                                Text(
                                                                    "Lycra Slub",
                                                                    style: TextStyle(
                                                                        color: ReColors()
                                                                            .appTextBlackColor,
                                                                        fontFamily:
                                                                            'headingfont')),
                                                              ]))),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    )))
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: Column(
                          children: [
                            Container(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 0, 0),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: new Text(
                                                      'Fiber',
                                                      textAlign: TextAlign.left,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      softWrap: false,
                                                      style: TextStyle(
                                                          color: ReColors()
                                                              .appTextWhiteColor,
                                                          fontSize: 18,
                                                          fontFamily:
                                                              'headerfont'),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: InkWell(
                                          onTap: _toggleFiber,
                                          child: Icon(
                                            Icons.add,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: ReColors().appMainColor,
                                  borderRadius: BorderRadius.circular(17.0),
                                )),
                            Visibility(
                                visible: fibervisibility,
                                child: Container(
                                    /*decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                          Colors.black,
                                          ReColors().appMainColor,
                                          ReColors().appMainColor,
                                          Colors.black
                                        ])),*/
                                    padding: EdgeInsets.fromLTRB(6, 5, 6, 5),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            child: Dropdown('Unit', [
                                              'BIO CREORA ',
                                              'HFLAX FIBER',
                                              'LINEN FIBER',
                                              'LYRCA 110-D',
                                              'DYNEEMA FIBER'
                                            ]),
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
                                                        hintText: "Ratio %",
                                                        hintStyle: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.black,
                                                          fontFamily:
                                                              'headingfont',
                                                        ),
                                                        fillColor: Colors.white,
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
                                                                      .white,
                                                                  width: 2.0),
                                                        ),
                                                      ),
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black,
                                                        fontFamily:
                                                            'headingfont',
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
                                                        hintText: "Fiber Price",
                                                        hintStyle: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.black,
                                                          fontFamily:
                                                              'headingfont',
                                                        ),
                                                        fillColor: Colors.white,
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
                                                                      .white,
                                                                  width: 2.0),
                                                        ),
                                                      ),
                                                      style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.black,
                                                        fontFamily:
                                                            'headingfont',
                                                      ),
                                                      textAlign: TextAlign.left,
                                                      controller:
                                                          textControllerInput,
                                                      onTap: () => {})),
                                            ],
                                          )
                                        ],
                                      ),
                                    )))
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: Column(
                          children: [
                            Container(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 0, 0),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: new Text(
                                                      'Stretch Filament',
                                                      textAlign: TextAlign.left,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      softWrap: false,
                                                      style: TextStyle(
                                                          color: ReColors()
                                                              .appTextWhiteColor,
                                                          fontSize: 18,
                                                          fontFamily:
                                                              'headerfont'),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: InkWell(
                                          onTap: _toggleStretchFilament,
                                          child: Icon(
                                            Icons.add,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: ReColors().appMainColor,
                                  borderRadius: BorderRadius.circular(17.0),
                                )),
                            Visibility(
                                visible: StretchFilamentvisibility,
                                child: Container(
                                    /* decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                          Colors.black,
                                          ReColors().appMainColor,
                                          ReColors().appMainColor,
                                          Colors.black
                                        ])),*/
                                    padding: EdgeInsets.fromLTRB(6, 5, 6, 5),
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: 130,
                                                child: Dropdown('Type', [
                                                  'lyrca',
                                                  'Creora',
                                                  'G Roica',
                                                  'C Roica',
                                                ]),
                                              ),
                                              Container(
                                                width: 130,
                                                child: Dropdown('Denier', [
                                                  '40D',
                                                  '50D',
                                                ]),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Container(
                                              child: new TextField(
                                                  decoration:
                                                      new InputDecoration(
                                                    hintText: "Price",
                                                    hintStyle: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontFamily: 'headingfont',
                                                    ),
                                                    fillColor: Colors.white,
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
                                                              color:
                                                                  Colors.white,
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
                                          SizedBox(height: 15),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Container(
                                                width: 130,
                                                child: Dropdown('Type', [
                                                  'lyrca',
                                                  'Creora',
                                                  'G Roica',
                                                  'C Roica',
                                                ]),
                                              ),
                                              Container(
                                                width: 130,
                                                child: Dropdown('Denier', [
                                                  '40D',
                                                  '50D',
                                                ]),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 10),
                                          Container(
                                              child: new TextField(
                                                  decoration:
                                                      new InputDecoration(
                                                    hintText: "Price",
                                                    hintStyle: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.black,
                                                      fontFamily: 'headingfont',
                                                    ),
                                                    fillColor: Colors.white,
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
                                                              color:
                                                                  Colors.white,
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
                                    )))
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: Column(
                          children: [
                            Container(
                                child: Padding(
                                  padding: EdgeInsets.fromLTRB(0, 20, 20, 20),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(20, 0, 0, 0),
                                        child: Align(
                                          alignment: Alignment.topLeft,
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Column(
                                                children: [
                                                  Align(
                                                    alignment:
                                                        Alignment.topLeft,
                                                    child: new Text(
                                                      'Hard Filament',
                                                      textAlign: TextAlign.left,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      softWrap: false,
                                                      style: TextStyle(
                                                          color: ReColors()
                                                              .appTextWhiteColor,
                                                          fontSize: 18,
                                                          fontFamily:
                                                              'headerfont'),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      Align(
                                        alignment: Alignment.topRight,
                                        child: InkWell(
                                          onTap: _toggleHardFilament,
                                          child: Icon(
                                            Icons.add,
                                            size: 30,
                                            color: Colors.white,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                  color: ReColors().appMainColor,
                                  borderRadius: BorderRadius.circular(17.0),
                                )),
                            Visibility(
                                visible: HardFilamentvisibility,
                                child: Container(
                                  /*  decoration: BoxDecoration(
    gradient: LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [
    Colors.black,
    ReColors().appMainColor,
    ReColors().appMainColor,
    Colors.black
    ])),*/
                                  padding: EdgeInsets.fromLTRB(6, 5, 6, 5),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: 130,
                                            child: Dropdown('Type', [
                                              'T-400',
                                              'Poly Filament',
                                              'Ciclo',
                                            ]),
                                          ),
                                          Container(
                                            width: 130,
                                            child: Dropdown('Denier', [
                                              '40D',
                                              '50D',
                                            ]),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                          child: new TextField(
                                              decoration: new InputDecoration(
                                                hintText: "Price",
                                                hintStyle: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontFamily: 'headingfont',
                                                ),
                                                fillColor: Colors.white,
                                                enabledBorder:
                                                    new OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: ReColors()
                                                          .appMainColor),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.white,
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
                                      SizedBox(height: 15),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Container(
                                            width: 130,
                                            child: Dropdown('Type', [
                                              'T-400',
                                              'Poly Filament',
                                              'Ciclo',
                                            ]),
                                          ),
                                          Container(
                                            width: 130,
                                            child: Dropdown('Denier', [
                                              '40D',
                                              '50D',
                                            ]),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 10),
                                      Container(
                                          child: new TextField(
                                              decoration: new InputDecoration(
                                                hintText: "Price",
                                                hintStyle: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.black,
                                                  fontFamily: 'headingfont',
                                                ),
                                                fillColor: Colors.white,
                                                enabledBorder:
                                                    new OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: ReColors()
                                                          .appMainColor),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      color: Colors.white,
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
                                    ],
                                  ),
                                )
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                      Container(
                          child: Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                              child: RaisedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    },
                                  color: ReColors().appMainColor,
                                  child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Search",
                                          style: TextStyle(
                                              color: Colors.white, fontFamily: 'headerfont'),
                                        )
                                      ],
                                    ),
                                  )),
                            ),
                          )),
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
          Container(
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      'Cotton',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontFamily: 'headerfont'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
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
                                        'OPS',
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
                                          '28',
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
                                        'Price/Lbs',
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
                                          '212.6768',
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
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            '1 Lbs. of Yarn from Cotton',
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
                                              '1.1905',
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
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            'Cotton Price/Lbs',
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
                                              '253.19',
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
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            'Conversion Cost',
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
                                              '21.00',
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
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            'Yarn Rate/lbs',
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
                                              '274.19',
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
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            'Profit',
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
                                              'Rs.5',
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
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            'Total Amount',
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
                                              '279.1900',
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
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            'Total Price',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey,
                                                fontFamily: 'headerfont'),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              '285',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontFamily: 'headerfont'),
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
            ,
          ),
          Container(
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      'Fiber',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                          fontFamily: 'headerfont'),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Container(
                      decoration:
                          BoxDecoration(border: Border.all(color: Colors.grey)),
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
                                        'OPS',
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
                                          '28',
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
                                        'Price/Lbs',
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
                                          '212.6768',
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
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            '1 Lbs. of Yarn from Fiber',
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
                                              '1.1905',
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
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            'Fiber Price/Lbs',
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
                                              '253.19',
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
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            'Per Spindle Cost',
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
                                              '21.00',
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
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            'Fiber Rate/lbs',
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
                                              '274.19',
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
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            'Profit',
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
                                              'Rs.5',
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
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            'Total Amount',
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
                                              '279.1900',
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
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            'Total Price',
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey,
                                                fontFamily: 'headerfont'),
                                          ),
                                        ),
                                        Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.all(5.0),
                                            child: Text(
                                              '285',
                                              textAlign: TextAlign.right,
                                              style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontFamily: 'headerfont'),
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
            ),
          ),
          Container(
              child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'Stretch Filament',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontFamily: 'headerfont'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
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
                                      'Conversion1 into count',
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
                                        '28',
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
                                      'Conversion2 into count',
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
                                        '212.6768',
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
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Yarn Count',
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
                                            '1.1905',
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
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Draft 1: ',
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
                                            'Draft 2: ',
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
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Lycra1 %age in yarn',
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
                                            '21.00',
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
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Lycra2 %age in yarn',
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
                                            '274.19',
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
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Lycra1 Consumption (KGS)/LBS of Yarn',
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
                                            'Rs.5',
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
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Lycra2 Consumption (KGS)/LBS of Yarn',
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
                                            '279.1900',
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
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Lycra1 Cost/LBS Of Yarn',
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
                                            '279.1900',
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
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Lycra2 Cost/LBS Of Yarn',
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
                                            '279.1900',
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
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Total Lycra Cost',
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
                                            '279.1900',
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
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Total Price',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey,
                                              fontFamily: 'headerfont'),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            '285',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontFamily: 'headerfont'),
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
          )),
          Container(
              child: Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Text(
                    'Hard Filament',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontFamily: 'headerfont'),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Container(
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
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
                                      'Conversion1 into count',
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
                                        '28',
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
                                      'Conversion2 into count',
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
                                        '212.6768',
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
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Yarn Count',
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
                                            '1.1905',
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
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Lycra Draft',
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
                                            '',
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
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Lycra1 %age in yarn',
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
                                            '21.00',
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
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Lycra2 %age in yarn',
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
                                            '274.19',
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
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Lycra1 Consumption (KGS)/LBS of Yarn',
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
                                            'Rs.5',
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
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Lycra2 Consumption (KGS)/LBS of Yarn',
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
                                            '279.1900',
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
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Lycra1 Cost/LBS Of Yarn',
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
                                            '279.1900',
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
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Lycra2 Cost/LBS Of Yarn',
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
                                            '279.1900',
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
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Total Cost/LBS Of Yarn',
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
                                            '279.1900',
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
                            )
                          ],
                        ),
                        /*Column(
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
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          'Total Price',
                                          style: TextStyle(
                                              fontSize: 16,
                                              color: Colors.grey,
                                              fontFamily: 'headerfont'),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(5.0),
                                          child: Text(
                                            '285',
                                            textAlign: TextAlign.right,
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.black,
                                                fontFamily: 'headerfont'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),*/
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
          ),

        ],
      ),
    );
  }
}
