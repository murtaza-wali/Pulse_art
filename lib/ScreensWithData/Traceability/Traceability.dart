import 'package:art/APIUri/BaseUrl.dart';
import 'package:art/HexCodeConverter/Hexcode.dart';
import 'package:art/Model/TraceabilityModels/ArticleDropdownList.dart';
import 'package:art/Model/TraceabilityModels/BrandDropdownList.dart';
import 'package:art/Model/TraceabilityModels/OrderDropdownList.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../ReuseableWidget/CustomAppbarWidget.dart';
import '../../TaskModel.dart';
import '../Menu/MainMenuPopup.dart';

class TraceabilityPage extends StatefulWidget {
  final List<TaskModel> taskList;

  const TraceabilityPage({
    Key key,
    this.taskList,
  }) : super(key: key);

  @override
  _TraceabilityPageState createState() => new _TraceabilityPageState();
}

class _TraceabilityPageState extends State<TraceabilityPage> {
  bool _visible = false;
  int selectedOrderID;
  String selectedArticleID = '';
  String SelectedFancyName = '';
  String BrandName = '';
  int ArticleName;
  bool brandSpinnerVisibility = false;
  bool ArticleSpinnerVisibility = false;
  bool OrderSpinnerVisibility = false;
  String SelectedBrandName;
  String SelectedArticeName;
  String ArticleID;
  String ArticleFancyName;
  bool garmentvisibility = true;
  bool denimvisibility = true;
  bool spinningvisibility = true;
  Color color2 = HexColor("#055e8e");

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget chip(String label, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Text(
            '${label}',
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
    return new Scaffold(
        appBar: new CustomAppBar(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => MainMenuPopUp()),
            );
          },
          Title: 'Traceability',
          refreshonPressed: () {},
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _toggle,
          child: Icon(Icons.search),
        ),
        body: Willpopwidget().getWillScope(SingleChildScrollView(
          child: Container(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Container(
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: <Widget>[
                          Visibility(
                            visible: _visible,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                              child: Container(
                                  child: Column(
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                          /*image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/world_map.png'),
                                      fit: BoxFit.cover,
                                    ),*/
                                            color: ReColors().appMainColor,
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                color: Colors.grey,
                                                offset: Offset(1.0, 15.0),
                                                blurRadius: 20.0,
                                              ),
                                            ]),
                                        child: Padding(
                                          padding: EdgeInsets.all(4),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Align(
                                                alignment: Alignment.topLeft,
                                                child: Padding(
                                                  padding: EdgeInsets.all(3),
                                                  child: new Text(
                                                    'Search',
                                                    textAlign: TextAlign.left,
                                                    style: TextStyle(
                                                        color: ReColors()
                                                            .appTextWhiteColor,
                                                        fontSize: 16,
                                                        fontFamily: 'headerfont'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: ReColors().appTextWhiteColor,
                                            boxShadow: <BoxShadow>[
                                              BoxShadow(
                                                color: Colors.grey,
                                                offset: Offset(1.0, 15.0),
                                                blurRadius: 20.0,
                                              ),
                                            ]),
                                        child: Padding(
                                          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
                                          child: Column(
                                            children: [
                                              Visibility(
                                                visible: brandSpinnerVisibility,
                                                child: Padding(
                                                  padding:
                                                  EdgeInsets.fromLTRB(0, 5, 0, 0),
                                                  child: DropdownSearch<Branditems>(
                                                    mode: Mode.DIALOG,
                                                    onFind: (String filter) =>
                                                        getBrand(filter),
                                                    itemAsString: (Branditems u) =>
                                                        u.userAsString(),
                                                    dropdownSearchDecoration:
                                                    InputDecoration(
                                                      labelText: "Brand",
                                                      contentPadding:
                                                      EdgeInsets.fromLTRB(
                                                          12, 12, 0, 0),
                                                      border: OutlineInputBorder(),
                                                    ),
                                                    onChanged: (Branditems data) {
                                                      setState(() {
                                                        SelectedBrandName =
                                                            data.baseBrand;
                                                        print(
                                                            'Brand Name${SelectedBrandName}');
                                                        ArticleSpinnerVisibility = true;
                                                      });
                                                    },
                                                    showSearchBox: true,
                                                    searchFieldProps: TextFieldProps(
                                                      decoration: InputDecoration(
                                                        border: OutlineInputBorder(),
                                                        contentPadding:
                                                        EdgeInsets.fromLTRB(
                                                            12, 12, 8, 0),
                                                        labelText: "Brand",
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Divider(
                                                color: Colors.white,
                                              ),
                                              Visibility(
                                                visible: ArticleSpinnerVisibility,
                                                child: DropdownSearch<Articleitem>(
                                                  mode: Mode.DIALOG,
                                                  onFind: (String filter) => getArticle(
                                                      filter, SelectedBrandName),
                                                  itemAsString: (Articleitem u) =>
                                                      u.userAsString(),
                                                  dropdownSearchDecoration:
                                                  InputDecoration(
                                                    labelText: "Article",
                                                    contentPadding: EdgeInsets.fromLTRB(
                                                        12, 12, 0, 0),
                                                    border: OutlineInputBorder(),
                                                  ),
                                                  onChanged: (Articleitem data) {
                                                    setState(() {
                                                      SelectedArticeName = data.iid;
                                                      print(
                                                          'Article Name${SelectedArticeName}');
                                                      final split =
                                                      SelectedArticeName.split('/');
                                                      final Map<int, String> values = {
                                                        for (int i = 0;
                                                        i < split.length;
                                                        i++)
                                                          i: split[i]
                                                      };
                                                      print(
                                                          values); // {0: grubs, 1:  sheep}

                                                      ArticleID =
                                                          values[0].replaceAll('*', '');
                                                      ArticleFancyName = values[1];

                                                      print(
                                                          'Selected fancy id${ArticleID}');
                                                      print(
                                                          'Selected fancy Nmae${ArticleFancyName}');
                                                      OrderSpinnerVisibility = true;
                                                    });
                                                  },
                                                  showSearchBox: true,
                                                  searchFieldProps: TextFieldProps(
                                                    decoration: InputDecoration(
                                                      border: OutlineInputBorder(),
                                                      contentPadding:
                                                      EdgeInsets.fromLTRB(
                                                          12, 12, 8, 0),
                                                      labelText: "Article",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Divider(
                                                color: Colors.white,
                                              ),
                                              Visibility(
                                                visible: OrderSpinnerVisibility,
                                                child: DropdownSearch<Orderitem>(
                                                  mode: Mode.DIALOG,
                                                  onFind: (String filter) => getOrder(
                                                      filter,
                                                      ArticleID,
                                                      ArticleFancyName,
                                                      SelectedBrandName),
                                                  itemAsString: (Orderitem u) =>
                                                      u.userAsString(),
                                                  dropdownSearchDecoration:
                                                  InputDecoration(
                                                    labelText: "Order",
                                                    contentPadding: EdgeInsets.fromLTRB(
                                                        12, 12, 0, 0),
                                                    border: OutlineInputBorder(),
                                                  ),
                                                  onChanged: (Orderitem data) {
                                                    setState(() {
                                                      selectedOrderID =
                                                          data.orderNumber;
                                                    });
                                                  },
                                                  showSearchBox: true,
                                                  searchFieldProps: TextFieldProps(
                                                    decoration: InputDecoration(
                                                      border: OutlineInputBorder(),
                                                      contentPadding:
                                                      EdgeInsets.fromLTRB(
                                                          12, 12, 8, 0),
                                                      labelText: "Order",
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              Divider(
                                                color: Colors.white,
                                              ),
                                              Padding(
                                                padding:
                                                EdgeInsets.fromLTRB(5, 5, 5, 20),
                                                child: RaisedButton(
                                                    onPressed: () {
                                                      _toggle();
                                                    },
                                                    color: ReColors().appMainColor,
                                                    child: Padding(
                                                      padding: EdgeInsets.all(5),
                                                      child: Column(
                                                        children: [
                                                          Text(
                                                            "Search",
                                                            style: TextStyle(
                                                                color: Colors.white,
                                                                fontFamily:
                                                                'headerfont'),
                                                          )
                                                        ],
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )),
                            ),
                          ),
                          Container(
                            child: Container(
                              padding: EdgeInsets.all(20),
                              decoration: BoxDecoration(
                                  color: ReColors().traceabilityBGColor,
                                  boxShadow: <BoxShadow>[
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(1.0, 15.0),
                                      blurRadius: 20.0,
                                    ),
                                  ]),
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                                      child: new Text(
                                        'Discover your',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: ReColors().appTextWhiteColor,
                                            fontSize: 14,
                                            fontFamily: 'titlefont'),
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.topLeft,
                                    child: Padding(
                                      padding: EdgeInsets.fromLTRB(0, 5, 5, 5),
                                      child: new Text(
                                        'Product Journey',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            color: ReColors().appTextWhiteColor,
                                            fontSize: 24,
                                            fontFamily: 'headerfont'),
                                      ),
                                    ),
                                  ),
                                  Align(
                                      alignment: Alignment.topLeft,
                                      child: Padding(
                                        padding: EdgeInsets.fromLTRB(0, 10, 10, 10),
                                        child: new Text(
                                          'Step and Process',
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                              color: ReColors().appTextWhiteColor,
                                              fontSize: 14,
                                              fontFamily: 'titlefont'),
                                        ),
                                      )),
                                  Container(
                                    color: ReColors().appMainColor,
                                    child: Column(
                                      children: [
                                        Container(
                                          child: Padding(
                                            padding:
                                            EdgeInsets.fromLTRB(0, 20, 0, 20),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        EdgeInsets.fromLTRB(
                                                            5, 0, 5, 0),
                                                        child: CircleAvatar(
                                                          radius: 20,
                                                          backgroundColor:
                                                          Colors.grey,
                                                          child: ClipOval(
                                                            child: 'https://artlive.artisticmilliners.com:8081/ords/art/r/files/static/v183/icon/garment-icon.png' ==
                                                                null
                                                                ? Center(
                                                                child:
                                                                CircularProgressIndicator(
                                                                  valueColor: AlwaysStoppedAnimation<Color>(
                                                                      ReColors()
                                                                          .darkgreyColor),
                                                                ))
                                                                : CachedNetworkImage(
                                                              imageUrl:
                                                              'https://artlive.artisticmilliners.com:8081/ords/art/r/files/static/v183/icon/garment-icon.png',
                                                              height: 80,
                                                              width: 80,
                                                              fit: BoxFit
                                                                  .cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Column(
                                                        children: [
                                                          Align(
                                                            alignment:
                                                            Alignment.topLeft,
                                                            child: new Text(
                                                              'Garment',
                                                              textAlign:
                                                              TextAlign.left,
                                                              overflow: TextOverflow
                                                                  .ellipsis,
                                                              softWrap: false,
                                                              style: TextStyle(
                                                                  color: ReColors()
                                                                      .traceabilitytitletextColor,
                                                                  fontSize: 18,
                                                                  fontFamily:
                                                                  'headerfont'),
                                                            ),
                                                          ),
                                                          Text(
                                                              'Cutting, Sewing, Washing,Dry Processes',
                                                              overflow: TextOverflow
                                                                  .ellipsis,
                                                              maxLines: 3,
                                                              softWrap: true,
                                                              style: TextStyle(
                                                                  fontSize: 10,
                                                                  color:
                                                                  Colors.black,
                                                                  fontFamily:
                                                                  'headingfont')),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: InkWell(
                                                    onTap: _toggleGarment,
                                                    child: Icon(
                                                      Icons
                                                          .keyboard_arrow_down_rounded,
                                                      size: 30,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [Colors.grey, Colors.white],
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                            visible: garmentvisibility,
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                        begin: Alignment.bottomLeft,
                                                        end: Alignment.topRight,
                                                        colors: [
                                                          Colors.black,
                                                          ReColors().appMainColor,
                                                          ReColors().appMainColor,
                                                          Colors.black
                                                        ])),
                                                padding:
                                                EdgeInsets.fromLTRB(6, 5, 6, 5),
                                                child: ListView.builder(
                                                    physics:
                                                    NeverScrollableScrollPhysics(),
                                                    primary: false,
                                                    shrinkWrap: true,
                                                    itemCount: null == widget.taskList
                                                        ? 0
                                                        : widget.taskList.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                        int index) {
                                                      return Container(
                                                        // margin: new EdgeInsets.only(top: index == 0 ? 10 : 0),
                                                          child: Column(
                                                              children: <Widget>[
                                                                IntrinsicHeight(
                                                                    child: Row(children: [
                                                                      Container(
                                                                          width: 90,
                                                                          // margin: new EdgeInsets.only(left: 10, top: 10),
                                                                          child: Column(
                                                                              mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                              children: <Widget>[
                                                                                Padding(
                                                                                  padding: EdgeInsets.fromLTRB(
                                                                                      3,
                                                                                      0,
                                                                                      3,
                                                                                      15),
                                                                                  child: Text(
                                                                                    widget
                                                                                        .taskList[
                                                                                    index]
                                                                                        .time,
                                                                                    style: TextStyle(
                                                                                        color:
                                                                                        Colors.white),
                                                                                  ),
                                                                                ),
                                                                              ])),
                                                                      Stack(
                                                                          children: <Widget>[
                                                                            Container(
                                                                                margin: EdgeInsets
                                                                                    .only(
                                                                                    left:
                                                                                    10),
                                                                                height: double
                                                                                    .infinity,
                                                                                width: 0,
                                                                                decoration: BoxDecoration(
                                                                                    border: Border(
                                                                                        right: BorderSide(
                                                                                            color: index == widget.taskList.length - 1 ? Colors.transparent : Colors.red,
                                                                                            width: 2)))),
                                                                            Container(
                                                                                margin: new EdgeInsets
                                                                                    .only(
                                                                                    left: 1),
                                                                                height: 15.0,
                                                                                width: 15.0,

                                                                                //TODO CIRCLE DECORATION
                                                                                decoration: new BoxDecoration(
                                                                                    shape: BoxShape
                                                                                        .circle,
                                                                                    color: Colors
                                                                                        .red))
                                                                          ]),
                                                                      Expanded(
                                                                          child: Column(
                                                                              crossAxisAlignment:
                                                                              CrossAxisAlignment
                                                                                  .start,
                                                                              children: <
                                                                                  Widget>[
                                                                                Container(
                                                                                    child: Column(
                                                                                        crossAxisAlignment:
                                                                                        CrossAxisAlignment
                                                                                            .stretch,
                                                                                        children: <
                                                                                            Widget>[
                                                                                          Padding(
                                                                                            padding: EdgeInsets
                                                                                                .fromLTRB(
                                                                                                5,
                                                                                                0,
                                                                                                5,
                                                                                                5),
                                                                                            child:
                                                                                            Text(
                                                                                              widget
                                                                                                  .taskList[index]
                                                                                                  .title,
                                                                                              style: TextStyle(
                                                                                                  color:
                                                                                                  Colors.white,
                                                                                                  fontSize: 18),
                                                                                            ),
                                                                                          ),
                                                                                          Padding(
                                                                                              padding: EdgeInsets.fromLTRB(
                                                                                                  5,
                                                                                                  0,
                                                                                                  5,
                                                                                                  5),
                                                                                              child:
                                                                                              Container(
                                                                                                decoration:
                                                                                                new BoxDecoration(
                                                                                                  color:
                                                                                                  ReColors().shortBGColor,
                                                                                                  borderRadius:
                                                                                                  BorderRadius.circular(6),
                                                                                                ),
                                                                                                padding: EdgeInsets.fromLTRB(
                                                                                                    4,
                                                                                                    10,
                                                                                                    4,
                                                                                                    10),
                                                                                                child:
                                                                                                Text(
                                                                                                  widget.taskList[index].description,
                                                                                                  style:
                                                                                                  TextStyle(color: Colors.white),
                                                                                                ),
                                                                                              )),
                                                                                          SizedBox(
                                                                                              height:
                                                                                              30)
                                                                                        ]))
                                                                              ]))
                                                                    ]))
                                                              ]));
                                                    })))
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [Colors.grey, Colors.white],
                                            ),
                                          ),
                                          child: Padding(
                                            padding:
                                            EdgeInsets.fromLTRB(0, 20, 0, 20),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 5, 0),
                                                        child: CircleAvatar(
                                                          radius: 20,
                                                          backgroundColor:
                                                          Colors.grey,
                                                          child: ClipOval(
                                                            child: 'https://artlive.artisticmilliners.com:8081/ords/art/r/files/static/v183/icon/denim-fabricroll.png' ==
                                                                null
                                                                ? Center(
                                                                child:
                                                                CircularProgressIndicator(
                                                                  valueColor: AlwaysStoppedAnimation<
                                                                      Color>(
                                                                      ReColors()
                                                                          .darkgreyColor),
                                                                ))
                                                                : CachedNetworkImage(
                                                              imageUrl:
                                                              'https://artlive.artisticmilliners.com:8081/ords/art/r/files/static/v183/icon/denim-fabricroll.png',
                                                              height: 80,
                                                              width: 80,
                                                              fit: BoxFit
                                                                  .cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Column(
                                                        children: [
                                                          new Text(
                                                            'Denim',
                                                            style: TextStyle(
                                                                color: ReColors()
                                                                    .traceabilitytitletextColor,
                                                                fontSize: 18,
                                                                fontFamily:
                                                                'headerfont'),
                                                          ),
                                                          new Text(
                                                            'Warping, Dyeing, Weaving, Finishing',
                                                            style: TextStyle(
                                                                color: ReColors()
                                                                    .appTextBlackColor,
                                                                fontSize: 10,
                                                                fontFamily:
                                                                'headingfont'),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: InkWell(
                                                    onTap: _toggleDenim,
                                                    child: Icon(
                                                      Icons.keyboard_arrow_down_rounded,
                                                      size: 30,
                                                      color: Colors.white,
                                                    ),
                                                  )

                                                  /* RaisedButton.icon(
                                                    onPressed: () {
                                                      _toggle();
                                                    },
                                                    label: Text(''),
                                                    icon: Icon(
                                                      Icons
                                                          .keyboard_arrow_down_rounded,
                                                      size: 30,
                                                      color: Colors.white,
                                                    ),
                                                  )*/
                                                  ,
                                                )
                                              ],
                                            ),
                                          )),
                                      Visibility(
                                          visible: denimvisibility,
                                          child: Container(
                                              decoration: BoxDecoration(
                                                  gradient: LinearGradient(
                                                      begin: Alignment.bottomLeft,
                                                      end: Alignment.topRight,
                                                      colors: [
                                                        Colors.black,
                                                        ReColors().appMainColor,
                                                        ReColors().appMainColor,
                                                        Colors.black
                                                      ])),
                                              padding:
                                              EdgeInsets.fromLTRB(6, 5, 6, 5),
                                              child: ListView.builder(
                                                  physics:
                                                  NeverScrollableScrollPhysics(),
                                                  primary: false,
                                                  shrinkWrap: true,
                                                  itemCount: null == widget.taskList
                                                      ? 0
                                                      : widget.taskList.length,
                                                  itemBuilder:
                                                      (BuildContext context,
                                                      int index) {
                                                    return Container(
                                                      // margin: new EdgeInsets.only(top: index == 0 ? 10 : 0),
                                                        child: Column(
                                                            children: <Widget>[
                                                              IntrinsicHeight(
                                                                  child: Row(children: [
                                                                    Container(
                                                                        width: 90,
                                                                        // margin: new EdgeInsets.only(left: 10, top: 10),
                                                                        child: Column(
                                                                            mainAxisAlignment:
                                                                            MainAxisAlignment
                                                                                .center,
                                                                            children: <
                                                                                Widget>[
                                                                              Padding(
                                                                                padding: EdgeInsets
                                                                                    .fromLTRB(
                                                                                    3,
                                                                                    0,
                                                                                    3,
                                                                                    15),
                                                                                child: Text(
                                                                                  widget
                                                                                      .taskList[
                                                                                  index]
                                                                                      .time,
                                                                                  style: TextStyle(
                                                                                      color:
                                                                                      Colors.white),
                                                                                ),
                                                                              ),
                                                                            ])),
                                                                    Stack(
                                                                        children: <Widget>[
                                                                          Container(
                                                                              margin: EdgeInsets
                                                                                  .only(
                                                                                  left:
                                                                                  10),
                                                                              height: double
                                                                                  .infinity,
                                                                              width: 0,
                                                                              decoration: BoxDecoration(
                                                                                  border: Border(
                                                                                      right: BorderSide(
                                                                                          color: index == widget.taskList.length - 1 ? Colors.transparent : Colors.red,
                                                                                          width: 2)))),
                                                                          Container(
                                                                              margin: new EdgeInsets
                                                                                  .only(
                                                                                  left: 1),
                                                                              height: 15.0,
                                                                              width: 15.0,

                                                                              //TODO CIRCLE DECORATION
                                                                              decoration: new BoxDecoration(
                                                                                  shape: BoxShape
                                                                                      .circle,
                                                                                  color: Colors
                                                                                      .red))
                                                                        ]),
                                                                    Expanded(
                                                                        child: Column(
                                                                            crossAxisAlignment:
                                                                            CrossAxisAlignment
                                                                                .start,
                                                                            children: <
                                                                                Widget>[
                                                                              Container(
                                                                                  child: Column(
                                                                                      crossAxisAlignment:
                                                                                      CrossAxisAlignment
                                                                                          .stretch,
                                                                                      children: <
                                                                                          Widget>[
                                                                                        Padding(
                                                                                          padding: EdgeInsets
                                                                                              .fromLTRB(
                                                                                              5,
                                                                                              0,
                                                                                              5,
                                                                                              5),
                                                                                          child:
                                                                                          Text(
                                                                                            widget
                                                                                                .taskList[index]
                                                                                                .title,
                                                                                            style: TextStyle(
                                                                                                color:
                                                                                                Colors.white,
                                                                                                fontSize: 18),
                                                                                          ),
                                                                                        ),
                                                                                        Padding(
                                                                                            padding: EdgeInsets.fromLTRB(
                                                                                                5,
                                                                                                0,
                                                                                                5,
                                                                                                5),
                                                                                            child:
                                                                                            Container(
                                                                                              decoration:
                                                                                              new BoxDecoration(
                                                                                                color:
                                                                                                ReColors().shortBGColor,
                                                                                                borderRadius:
                                                                                                BorderRadius.circular(6),
                                                                                              ),
                                                                                              padding: EdgeInsets.fromLTRB(
                                                                                                  4,
                                                                                                  10,
                                                                                                  4,
                                                                                                  10),
                                                                                              child:
                                                                                              Text(
                                                                                                widget.taskList[index].description,
                                                                                                style:
                                                                                                TextStyle(color: Colors.white),
                                                                                              ),
                                                                                            )),
                                                                                        SizedBox(
                                                                                            height:
                                                                                            30)
                                                                                      ]))
                                                                            ]))
                                                                  ]))
                                                            ]));
                                                  })))
                                    ],
                                  ),
                                  Container(
                                    color: ReColors().appMainColor,
                                    child: Column(
                                      children: [
                                        Container(
                                          child: Padding(
                                            padding:
                                            EdgeInsets.fromLTRB(0, 20, 0, 20),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Align(
                                                  alignment: Alignment.topLeft,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                        EdgeInsets.fromLTRB(
                                                            0, 0, 5, 0),
                                                        child: CircleAvatar(
                                                          radius: 20,
                                                          backgroundColor:
                                                          Colors.grey,
                                                          child: ClipOval(
                                                            child: 'https://artlive.artisticmilliners.com:8081/ords/art/r/files/static/v183/icon/spinning.png' ==
                                                                null
                                                                ? Center(
                                                                child:
                                                                CircularProgressIndicator(
                                                                  valueColor: AlwaysStoppedAnimation<
                                                                      Color>(
                                                                      ReColors()
                                                                          .darkgreyColor),
                                                                ))
                                                                : CachedNetworkImage(
                                                              imageUrl:
                                                              'https://artlive.artisticmilliners.com:8081/ords/art/r/files/static/v183/icon/spinning.png',
                                                              height: 80,
                                                              width: 80,
                                                              fit: BoxFit
                                                                  .cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      Column(
                                                        children: [
                                                          new Text(
                                                            'Spinning',
                                                            style: TextStyle(
                                                                color: ReColors()
                                                                    .traceabilitytitletextColor,
                                                                fontSize: 18,
                                                                fontFamily:
                                                                'headerfont'),
                                                          ),
                                                          new Text(
                                                            'Warping, Dyeing, Weaving, Finishing',
                                                            style: TextStyle(
                                                                color: ReColors()
                                                                    .appTextBlackColor,
                                                                fontSize: 10,
                                                                fontFamily:
                                                                'headingfont'),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Align(
                                                  alignment: Alignment.topRight,
                                                  child: InkWell(
                                                    onTap: _toggleSpinning,
                                                    child: Icon(
                                                      Icons
                                                          .keyboard_arrow_down_rounded,
                                                      size: 30,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              begin: Alignment.topCenter,
                                              end: Alignment.bottomCenter,
                                              colors: [Colors.grey, Colors.white],
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                            visible: spinningvisibility,
                                            child: Container(
                                                decoration: BoxDecoration(
                                                    gradient: LinearGradient(
                                                        begin: Alignment.bottomLeft,
                                                        end: Alignment.topRight,
                                                        colors: [
                                                          Colors.black,
                                                          ReColors().appMainColor,
                                                          ReColors().appMainColor,
                                                          Colors.black
                                                        ])),
                                                padding:
                                                EdgeInsets.fromLTRB(6, 5, 6, 5),
                                                child: ListView.builder(
                                                    physics:
                                                    NeverScrollableScrollPhysics(),
                                                    primary: false,
                                                    shrinkWrap: true,
                                                    itemCount: null == widget.taskList
                                                        ? 0
                                                        : widget.taskList.length,
                                                    itemBuilder:
                                                        (BuildContext context,
                                                        int index) {
                                                      return Container(
                                                        // margin: new EdgeInsets.only(top: index == 0 ? 10 : 0),
                                                          child: Column(
                                                              children: <Widget>[
                                                                IntrinsicHeight(
                                                                    child: Row(children: [
                                                                      Container(
                                                                          width: 90,
                                                                          // margin: new EdgeInsets.only(left: 10, top: 10),
                                                                          child: Column(
                                                                              mainAxisAlignment:
                                                                              MainAxisAlignment
                                                                                  .center,
                                                                              children: <
                                                                                  Widget>[
                                                                                Padding(
                                                                                  padding: EdgeInsets
                                                                                      .fromLTRB(
                                                                                      3,
                                                                                      0,
                                                                                      3,
                                                                                      15),
                                                                                  child: Text(
                                                                                    widget
                                                                                        .taskList[
                                                                                    index]
                                                                                        .time,
                                                                                    style: TextStyle(
                                                                                        color:
                                                                                        Colors.white),
                                                                                  ),
                                                                                ),
                                                                              ])),
                                                                      Stack(
                                                                          children: <Widget>[
                                                                            Container(
                                                                                margin: EdgeInsets
                                                                                    .only(
                                                                                    left:
                                                                                    10),
                                                                                height: double
                                                                                    .infinity,
                                                                                width: 0,
                                                                                decoration: BoxDecoration(
                                                                                    border: Border(
                                                                                        right: BorderSide(
                                                                                            color: index == widget.taskList.length - 1 ? Colors.transparent : Colors.red,
                                                                                            width: 2)))),
                                                                            Container(
                                                                                margin: new EdgeInsets
                                                                                    .only(
                                                                                    left: 1),
                                                                                height: 15.0,
                                                                                width: 15.0,

                                                                                //TODO CIRCLE DECORATION
                                                                                decoration: new BoxDecoration(
                                                                                    shape: BoxShape
                                                                                        .circle,
                                                                                    color: Colors
                                                                                        .red))
                                                                          ]),
                                                                      Expanded(
                                                                          child: Column(
                                                                              crossAxisAlignment:
                                                                              CrossAxisAlignment
                                                                                  .start,
                                                                              children: <
                                                                                  Widget>[
                                                                                Container(
                                                                                    child: Column(
                                                                                        crossAxisAlignment:
                                                                                        CrossAxisAlignment
                                                                                            .stretch,
                                                                                        children: <
                                                                                            Widget>[
                                                                                          Padding(
                                                                                            padding: EdgeInsets
                                                                                                .fromLTRB(
                                                                                                5,
                                                                                                0,
                                                                                                5,
                                                                                                5),
                                                                                            child:
                                                                                            Text(
                                                                                              widget
                                                                                                  .taskList[index]
                                                                                                  .title,
                                                                                              style: TextStyle(
                                                                                                  color:
                                                                                                  Colors.white,
                                                                                                  fontSize: 18),
                                                                                            ),
                                                                                          ),
                                                                                          Padding(
                                                                                              padding: EdgeInsets.fromLTRB(
                                                                                                  5,
                                                                                                  0,
                                                                                                  5,
                                                                                                  5),
                                                                                              child:
                                                                                              Container(
                                                                                                decoration:
                                                                                                new BoxDecoration(
                                                                                                  color:
                                                                                                  ReColors().shortBGColor,
                                                                                                  borderRadius:
                                                                                                  BorderRadius.circular(6),
                                                                                                ),
                                                                                                padding: EdgeInsets.fromLTRB(
                                                                                                    4,
                                                                                                    10,
                                                                                                    4,
                                                                                                    10),
                                                                                                child:
                                                                                                Text(
                                                                                                  widget.taskList[index].description,
                                                                                                  style:
                                                                                                  TextStyle(color: Colors.white),
                                                                                                ),
                                                                                              )),
                                                                                          SizedBox(
                                                                                              height:
                                                                                              30)
                                                                                        ]))
                                                                              ]))
                                                                    ]))
                                                              ]));
                                                    })))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )),
              ],
            ),
          ),
        )));
  }

  void _toggle() {
    setState(() {
      _visible = !_visible;
      brandSpinnerVisibility = true;
    });
  }

  void _toggleGarment() {
    setState(() {
      garmentvisibility = !garmentvisibility;
      // garmentvisibility = false;
    });
  }

  void _toggleDenim() {
    setState(() {
      denimvisibility = !denimvisibility;
      // denimvisibility = false;
    });
  }

  void _toggleSpinning() {
    setState(() {
      spinningvisibility = !spinningvisibility;
      //spinningvisibility = false;
    });
  }

  Future<List<Branditems>> getBrand(filter) async {
    var result = await Dio().get(
      BaseURL().NewAuth + "traceability/brands",
      queryParameters: {"filter": filter},
    );
    var parse = result.data;
    var data = parse["items"] as List;
    if (data != null) {
      return Branditems.fromJsonList(data);
    }

    return [];
  }

  Future<List<Articleitem>> getArticle(filter, baseBrand) async {
    var result = await Dio().get(
      BaseURL().NewAuth + "traceability/articles/" + baseBrand,
      queryParameters: {"filter": filter},
    );
    var parse = result.data;
    var data = parse["items"] as List;
    if (data != null) {
      return Articleitem.fromJsonList(data);
    }

    return [];
  }

  Future<List<Orderitem>> getOrder(
      filter, String id, String fancyName, String baseBrand) async {
    var result = await Dio().get(
      BaseURL().NewAuth +
          'traceability/orders/' +
          id.toString() +
          '/' +
          fancyName +
          '/' +
          baseBrand,
      queryParameters: {"filter": filter},
    );
    var parse = result.data;
    var data = parse["items"] as List;
    if (data != null) {
      return Orderitem.fromJsonList(data);
    }

    return [];
  }

  _buildExpandableContent(Websites policies) {
    List<Widget> columnContent = [];

    for (String content in policies.contents)
      columnContent.add(new Column(
        children: [
          ListTile(
              title: Row(
                children: [
                  Icon(
                    Icons.circle,
                    color: Colors.red,
                    size: 10,
                  ),
                  new Text(
                    '    ',
                  ),
                  new Text(
                    content,
                    style: TextStyle(
                        color: ReColors().appTextWhiteColor,
                        fontSize: 16,
                        fontFamily: 'headingfont'),
                  )
                ],
              ),
              onTap: () {}),
          /* Icon(
            Icons.,
            color: Colors.red,
            size: 10,
          ),*/
        ],
      ));

    return columnContent;
  }

/*_openWebUrl(String url, String title) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => GeneralWebScreen(url: url, item: title),
      ),
    );
  }*/
}

class Websites {
  final String title;
  final String image;
  List<String> contents = [];

  static final Map<String, String> endpoints = const {
    "git": "https://github.com/",
    "google": "https://www.google.com/",
    "flutter": "https://flutter.dev/docs/get-started/install",
    "swift": "https://developer.apple.com/swift/"
  };

  Websites(this.title, this.image, this.contents);
}

List<Websites> policies = [
  new Websites(
      'Garment',
      'https://artlive.artisticmilliners.com:8081/ords/art/r/files/static/v183/icon/garment-icon.png',
      [
        'OMS',
        'MRP',
        'SCM',
        'Manufacturing',
        'Dispatch',
      ]),
  new Websites(
      'Denim',
      'https://artlive.artisticmilliners.com:8081/ords/art/r/files/static/v183/icon/denim-fabricroll.png',
      [
        'OMS',
        'MRP',
        'SCM',
        'Manufacturing',
        'Dispatch',
      ]),
  new Websites(
      'Spinning',
      'https://artlive.artisticmilliners.com:8081/ords/art/r/files/static/v183/icon/spinning.png',
      [
        'OMS',
        'MRP',
        'SCM',
        'Manufacturing',
        'Dispatch',
      ]),
];

class GeneralWebScreen extends StatelessWidget {
  final String url;
  final String item;

  GeneralWebScreen({Key key, @required this.url, @required this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(item),
        ),
        body: WebView(
          initialUrl: url,
          javascriptMode: JavascriptMode.unrestricted,
        ));
  }
}
