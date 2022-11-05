import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/CustomAppbarWithImage.dart';
import 'package:art/ReuseableWidget/StaticDropdown.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:art/ScreensWithData/Menu/MainMenuPopup.dart';
import 'package:flutter/material.dart';

import 'HexCodeConverter/Hexcode.dart';

class Visualization extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _VisualizationState();
}

class _VisualizationState extends State<Visualization> {
  @override
  void initState() {
    super.initState();

  }

  Color color2 = HexColor("#055e8e");

  @override
  Widget build(BuildContext context) {
    return Willpopwidget().getWillScope(
      Scaffold(
        appBar: new CustomAppBarImage(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => MainMenuPopUp()),
            );
          },
          Title: 'Visualization',
          image_bar: 'assets/images/hrms_logo2.png',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(5),
            child: Container(
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'AM5-Finish Goods Warehouse',
                      style: TextStyle(
                          color: ReColors().appMainColor, fontSize: 20),
                    ),
                  ),
                  //..............................//
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Card(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(-0.6, -1),
                                    end: Alignment(-1, -0),
                                    colors: [Colors.white, Colors.white],
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(1.0),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        Text(
                                          'Ware House',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontFamily: 'headingfont',
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Container(
                                            margin: const EdgeInsets.only(
                                                left: 20.0, right: 10.0),
                                            child: Divider(
                                              color: Colors.black,
                                              height: 36,
                                            )),

                                      ],
                                    ),
                                    Text(
                                      '00',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 60.0,
                                        fontFamily: 'headingfont',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17.0),
                              ),
                              elevation: 5,
                              margin: EdgeInsets.fromLTRB(10, 0, 0, 0),
                            ),
                          ),
                          VerticalDivider(width: 1.0),
                          Container(
                            width: MediaQuery.of(context).size.width * 0.45,
                            child: Card(
                              child: Container(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(-0.6, -1),
                                    end: Alignment(-1, -0),
                                    colors: [Colors.white, Colors.white],
                                  ),
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(1.0),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Column(
                                      children: [
                                        Text(
                                          'Ware House',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 20.0,
                                            fontFamily: 'headingfont',
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        Container(
                                            margin: const EdgeInsets.only(
                                                left: 20.0, right: 10.0),
                                            child: Divider(
                                              color: Colors.black,
                                              height: 36,
                                            )),

                                      ],
                                    ),
                                    Text(
                                      '00',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 60.0,
                                        fontFamily: 'headingfont',
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(17.0),
                              ),
                              elevation: 5,
                              margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  //..............................//
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Dropdown('B1', ['B2', 'B3', 'B4']),
                  ),

                  Container(
                      child: Center(
                          child: Column(children: <Widget>[
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Table(
                        defaultColumnWidth: FixedColumnWidth(30.0),
                        border: TableBorder.all(
                            color: Colors.black,
                            style: BorderStyle.solid,
                            width: 2),
                        children: [
                          TableRow(children: [
                            Container(
                              color: ReColors().BlueGreyColor,
                              child: Column(children: [
                                Text('0', style: TextStyle(fontSize: 16.0))
                              ]),
                            ),
                            Container(
                              color: ReColors().BlueGreyColor,
                              child: Column(children: [
                                Text('I', style: TextStyle(fontSize: 16.0))
                              ]),
                            ),
                            Container(
                              color: ReColors().BlueGreyColor,
                              child: Column(children: [
                                Text('II', style: TextStyle(fontSize: 16.0))
                              ]),
                            ),
                            Container(
                              color: ReColors().BlueGreyColor,
                              child: Column(children: [
                                Text('III', style: TextStyle(fontSize: 16.0))
                              ]),
                            ),
                            Container(
                              color: ReColors().BlueGreyColor,
                              child: Column(children: [
                                Text('IV', style: TextStyle(fontSize: 16.0))
                              ]),
                            ),
                            Container(
                              color: ReColors().BlueGreyColor,
                              child: Column(children: [
                                Text('V', style: TextStyle(fontSize: 16.0))
                              ]),
                            ),
                            Container(
                              color: ReColors().BlueGreyColor,
                              child: Column(children: [
                                Text('VI', style: TextStyle(fontSize: 16.0))
                              ]),
                            ),
                            Container(
                              color: ReColors().BlueGreyColor,
                              child: Column(children: [
                                Text('VII', style: TextStyle(fontSize: 16.0))
                              ]),
                            ),
                            Container(
                              color: ReColors().BlueGreyColor,
                              child: Column(children: [
                                Text('VIII', style: TextStyle(fontSize: 16.0))
                              ]),
                            ),
                          ]),
                          TableRow(children: [
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                          ]),
                          TableRow(children: [
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                          ]),
                          TableRow(children: [
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                          ]),
                          TableRow(children: [
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                          ]),
                          TableRow(children: [
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                          ]),
                          TableRow(children: [
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                          ]),
                          TableRow(children: [
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                          ]),
                          TableRow(children: [
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                          ]),
                          TableRow(children: [
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                          ]),
                          TableRow(children: [
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                          ]),
                          TableRow(children: [
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                            Container(
                              color: ReColors().lightgreenColor,
                              child: Column(children: [Text('123')]),
                            ),
                          ]),
                        ],
                      ),
                    ),
                  ])))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
