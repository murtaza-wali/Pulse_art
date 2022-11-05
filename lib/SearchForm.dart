import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:art/ScreensWithData/Menu/MainMenuPopup.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'APIUri/BaseUrl.dart';
import 'Model/fabric_library/fabric_lib_card_items.dart';
import 'Model/fabric_library/fabric_lib_unit_list_model.dart';
import 'ParsingJSON/GetJSONMethod.dart';
import 'ReuseableValues/ReColors.dart';
import 'ReuseableWidget/CustomAppBarDrawer.dart';
import 'ReuseableWidget/CustomDrawerAppBar.dart';

class SearchForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  List<Fabric_lib_items> FabricLibList = [];
  List<FabricCarditems> FabricLibcardList = [];
  bool unitlistloader = false;
  int SelectedorgCode;

  @override
  void initState() {
    super.initState();
  }

  String description_String,
      finish_string,
      sampleRef_string,
      noOfEnds_String,
      shrinkafewarp_string,
      dyeArt_string,
      loomType_string,
      stdWidth_string,
      endsInch_String;
  String shrinkageWeft_string,
      weaveArt_String,
      shade_String,
      cutWidth_string,
      reedWidth_string,
      picksInch_string,
      article_string,
      warpColor_string,
      weigth_string,
      reedCount_string,
      weaveTwill_string;
  TextEditingController descriptionController = TextEditingController();
  TextEditingController finishController = TextEditingController();
  TextEditingController sampleRefrenseController = TextEditingController();
  TextEditingController no_of_endsController = TextEditingController();
  TextEditingController shrinkagewarpController = TextEditingController();
  TextEditingController dyeArtController = TextEditingController();
  TextEditingController loomTypeController = TextEditingController();
  TextEditingController STDwIdthController = TextEditingController();
  TextEditingController ends_inchController = TextEditingController();
  TextEditingController Shrinkage_WeftController = TextEditingController();
  TextEditingController Weave_Art_NoController = TextEditingController();
  TextEditingController ShadeController = TextEditingController();
  TextEditingController CUT_WidthController = TextEditingController();
  TextEditingController Reed_WidthController = TextEditingController();
  TextEditingController Picks_InchController = TextEditingController();
  TextEditingController ArticleController = TextEditingController();
  TextEditingController Warp_ColorController = TextEditingController();
  TextEditingController WeightController = TextEditingController();
  TextEditingController Reed_CountController = TextEditingController();
  TextEditingController Weave_TwillController = TextEditingController();
  bool bodyVisibility = false;
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

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
        Title: 'Search',
      ),
      endDrawer: Drawer(child: DrawerView()),
      body: bodyVisibility == true
          ? Container(
              child: ListView.builder(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  physics: const AlwaysScrollableScrollPhysics(),
                  primary: false,
                  shrinkWrap: true,
                  itemCount:
                      FabricLibcardList == null ? 0 : FabricLibcardList.length,
                  itemBuilder: (BuildContext context, int index) {
                    FabricCarditems cardResultitems = FabricLibcardList[index];

                    return BodyView(cardResultitems, index, FabricLibcardList);
                  }),
            )
          : Container(
              child: showError('No Data Available', Icons.error),
            ),
    ));
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

  String organizationCode = '';

  Future<List<Fabric_lib_items>> getfabriclibunitlist(filter) async {
    var result = await Dio().get(
      BaseURL().NewAuth + "fabric-library/orgs/",
      queryParameters: {"filter": filter},
    );
    var parse = result.data;
    var data = parse["items"] as List;
    if (data != null) {
      return Fabric_lib_items.fromJsonList(data);
    }

    return [];
  }

  Widget DrawerView() {
    return Container(
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
                              padding: const EdgeInsets.fromLTRB(20, 5, 20, 4),
                              child: Container(
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Expanded(
                                            child: Align(
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                10, 8, 10, 0),
                                            child: Text(
                                              'Search Criteria',
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 18,
                                                  fontFamily: 'headerfont'),
                                            ),
                                          ),
                                        )),
                                      ],
                                    ),
                                    Padding(
                                      padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                                      child: DropdownSearch<Fabric_lib_items>(
                                        mode: Mode.DIALOG,
                                        onFind: (String filter) =>
                                            getfabriclibunitlist(filter),
                                        itemAsString: (Fabric_lib_items u) =>
                                            u.userAsString(),
                                        dropdownSearchDecoration:
                                            InputDecoration(
                                          labelText: "Unit",
                                          contentPadding: EdgeInsets.fromLTRB(
                                              10, 10, 10, 0),
                                          fillColor: ReColors().appMainColor,
                                          enabledBorder: new OutlineInputBorder(
                                            borderRadius:
                                                new BorderRadius.circular(5.0),
                                            borderSide: BorderSide(
                                                color: ReColors().appMainColor),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Color(0xff055e8e),
                                                width: 2.0),
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          labelStyle: TextStyle(color: Color(0xff055e8e),
                                              fontFamily: 'titlefont'),
                                        ),
                                        onChanged: (Fabric_lib_items data) {
                                          setState(() {
                                            SelectedorgCode = data.orgId;
                                            print('Brand Name${SelectedorgCode}');
                                          });
                                        },
                                        showSearchBox: true,
                                        searchFieldProps: TextFieldProps(
                                          decoration: InputDecoration(
                                            contentPadding: EdgeInsets.fromLTRB(
                                                10, 10, 10, 0),
                                            fillColor: ReColors().appMainColor,
                                            enabledBorder: new OutlineInputBorder(
                                              borderRadius: new BorderRadius.circular(5.0),
                                              borderSide: BorderSide(color: ReColors().appMainColor),
                                            ),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: const BorderSide(
                                                  color: Color(0xff055e8e),
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            labelText: 'Units',
                                            labelStyle: TextStyle(
                                                color: Color(0xff055e8e),
                                                fontFamily: 'titlefont'),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Container(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextField(
                                            style: TextStyle(
                                                color: ReColors().appMainColor,
                                                fontFamily: 'titlefont'),
                                            controller: Weave_TwillController,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      10, 10, 10, 0),
                                              fillColor:
                                                  ReColors().appMainColor,
                                              enabledBorder:
                                                  new OutlineInputBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        5.0),
                                                borderSide: BorderSide(
                                                    color: ReColors()
                                                        .appMainColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0xff055e8e),
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              labelText: 'Weave + Twill',
                                              labelStyle: TextStyle(
                                                  color: Color(0xff055e8e),
                                                  fontFamily: 'titlefont'),
                                            ),
                                            onChanged: (addresstext) {
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 7,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: TextField(
                                                    style: TextStyle(
                                                        color: ReColors()
                                                            .appMainColor,
                                                        fontFamily:
                                                            'titlefont'),
                                                    controller:
                                                        Reed_CountController,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 10, 10, 0),
                                                      fillColor: ReColors()
                                                          .appMainColor,
                                                      enabledBorder:
                                                          new OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                        borderSide: BorderSide(color: ReColors().appMainColor),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(color: Color(0xff055e8e), width: 2.0),
                                                        borderRadius: BorderRadius.circular(5.0),
                                                      ),
                                                      labelText: 'Reed Count',
                                                      labelStyle: TextStyle(color: Color(0xff055e8e), fontFamily: 'titlefont'),
                                                    ),
                                                    onChanged: (addresstext) {
                                                      setState(() {});
                                                    },
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 7,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: TextField(
                                                    style: TextStyle(
                                                        color: ReColors()
                                                            .appMainColor,
                                                        fontFamily:
                                                            'titlefont'),
                                                    controller:
                                                        WeightController,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 10, 10, 0),
                                                      fillColor: ReColors().appMainColor,
                                                      enabledBorder:
                                                          new OutlineInputBorder(
                                                        borderRadius: new BorderRadius.circular(5.0),
                                                        borderSide: BorderSide(color: ReColors().appMainColor),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: const BorderSide(color: Color(0xff055e8e), width: 2.0),
                                                        borderRadius: BorderRadius.circular(5.0),
                                                      ),
                                                      labelText: 'Weight',
                                                      labelStyle: TextStyle(
                                                          color:
                                                              Color(0xff055e8e),
                                                          fontFamily:
                                                              'titlefont'),
                                                    ),
                                                    onChanged: (addresstext) {
                                                      setState(() {});
                                                    },
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Container(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextField(
                                            style: TextStyle(
                                                color: ReColors().appMainColor,
                                                fontFamily: 'titlefont'),
                                            controller: Warp_ColorController,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      10, 10, 10, 0),
                                              fillColor:
                                                  ReColors().appMainColor,
                                              enabledBorder:
                                                  new OutlineInputBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        5.0),
                                                borderSide: BorderSide(
                                                    color: ReColors()
                                                        .appMainColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0xff055e8e),
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              labelText: 'Warp Color',
                                              labelStyle: TextStyle(
                                                  color: Color(0xff055e8e),
                                                  fontFamily: 'titlefont'),
                                            ),
                                            onChanged: (addresstext) {
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Container(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextField(
                                            style: TextStyle(
                                                color: ReColors().appMainColor,
                                                fontFamily: 'titlefont'),
                                            controller: ArticleController,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                              fillColor: ReColors().appMainColor,
                                              enabledBorder: new OutlineInputBorder(
                                                borderRadius: new BorderRadius.circular(5.0),
                                                borderSide: BorderSide(color: ReColors().appMainColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(color: Color(0xff055e8e), width: 2.0),
                                                borderRadius: BorderRadius.circular(5.0),
                                              ),
                                              labelText: 'Article #',
                                              labelStyle: TextStyle(
                                                  color: Color(0xff055e8e),
                                                  fontFamily: 'titlefont'),
                                            ),
                                            onChanged: (addresstext) {
                                              setState(() {

                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Container(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextField(
                                            style: TextStyle(
                                                color: ReColors().appMainColor,
                                                fontFamily: 'titlefont'),
                                            controller: Picks_InchController,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      10, 10, 10, 0),
                                              fillColor:
                                                  ReColors().appMainColor,
                                              enabledBorder:
                                                  new OutlineInputBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        5.0),
                                                borderSide: BorderSide(
                                                    color: ReColors()
                                                        .appMainColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0xff055e8e),
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              labelText: 'Picks/Inch',
                                              labelStyle: TextStyle(
                                                  color: Color(0xff055e8e),
                                                  fontFamily: 'titlefont'),
                                            ),
                                            onChanged: (addresstext) {
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 7,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: TextField(
                                                    style: TextStyle(
                                                        color: ReColors()
                                                            .appMainColor,
                                                        fontFamily:
                                                            'titlefont'),
                                                    controller:
                                                        Reed_WidthController,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 10, 10, 0),
                                                      fillColor: ReColors()
                                                          .appMainColor,
                                                      enabledBorder:
                                                          new OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                        borderSide: BorderSide(
                                                            color: ReColors()
                                                                .appMainColor),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Color(
                                                                    0xff055e8e),
                                                                width: 2.0),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      labelText: 'Reed Width',
                                                      labelStyle: TextStyle(
                                                          color:
                                                              Color(0xff055e8e),
                                                          fontFamily:
                                                              'titlefont'),
                                                    ),
                                                    onChanged: (addresstext) {
                                                      setState(() {});
                                                    },
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 7,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: TextField(
                                                    style: TextStyle(
                                                        color: ReColors()
                                                            .appMainColor,
                                                        fontFamily:
                                                            'titlefont'),
                                                    controller:
                                                        CUT_WidthController,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 10, 10, 0),
                                                      fillColor: ReColors()
                                                          .appMainColor,
                                                      enabledBorder:
                                                          new OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                        borderSide: BorderSide(
                                                            color: ReColors()
                                                                .appMainColor),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Color(
                                                                    0xff055e8e),
                                                                width: 2.0),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      labelText: 'CUT Width',
                                                      labelStyle: TextStyle(
                                                          color:
                                                              Color(0xff055e8e),
                                                          fontFamily:
                                                              'titlefont'),
                                                    ),
                                                    onChanged: (addresstext) {
                                                      setState(() {});
                                                    },
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Container(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextField(
                                            style: TextStyle(
                                                color: ReColors().appMainColor,
                                                fontFamily: 'titlefont'),
                                            controller: ShadeController,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      10, 10, 10, 0),
                                              fillColor:
                                                  ReColors().appMainColor,
                                              enabledBorder:
                                                  new OutlineInputBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        5.0),
                                                borderSide: BorderSide(
                                                    color: ReColors()
                                                        .appMainColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0xff055e8e),
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              labelText: 'Shade',
                                              labelStyle: TextStyle(
                                                  color: Color(0xff055e8e),
                                                  fontFamily: 'titlefont'),
                                            ),
                                            onChanged: (addresstext) {
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Container(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextField(
                                            style: TextStyle(
                                                color: ReColors().appMainColor,
                                                fontFamily: 'titlefont'),
                                            controller: Weave_Art_NoController,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      10, 10, 10, 0),
                                              fillColor:
                                                  ReColors().appMainColor,
                                              enabledBorder:
                                                  new OutlineInputBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        5.0),
                                                borderSide: BorderSide(
                                                    color: ReColors()
                                                        .appMainColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0xff055e8e),
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              labelText: 'Weave Art No',
                                              labelStyle: TextStyle(
                                                  color: Color(0xff055e8e),
                                                  fontFamily: 'titlefont'),
                                            ),
                                            onChanged: (addresstext) {
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Container(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextField(
                                            style: TextStyle(
                                                color: ReColors().appMainColor,
                                                fontFamily: 'titlefont'),
                                            controller:
                                                Shrinkage_WeftController,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      10, 10, 10, 0),
                                              fillColor:
                                                  ReColors().appMainColor,
                                              enabledBorder:
                                                  new OutlineInputBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        5.0),
                                                borderSide: BorderSide(
                                                    color: ReColors()
                                                        .appMainColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0xff055e8e),
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              labelText: 'Shrinkage Weft',
                                              labelStyle: TextStyle(
                                                  color: Color(0xff055e8e),
                                                  fontFamily: 'titlefont'),
                                            ),
                                            onChanged: (addresstext) {
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 7,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: TextField(
                                                    style: TextStyle(
                                                        color: ReColors()
                                                            .appMainColor,
                                                        fontFamily:
                                                            'titlefont'),
                                                    controller:
                                                        ends_inchController,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 10, 10, 0),
                                                      fillColor: ReColors()
                                                          .appMainColor,
                                                      enabledBorder:
                                                          new OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                        borderSide: BorderSide(
                                                            color: ReColors()
                                                                .appMainColor),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Color(
                                                                    0xff055e8e),
                                                                width: 2.0),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      labelText:
                                                          'Ends/Inch (Dent/CM)',
                                                      labelStyle: TextStyle(
                                                          color:
                                                              Color(0xff055e8e),
                                                          fontFamily:
                                                              'titlefont'),
                                                    ),
                                                    onChanged: (addresstext) {
                                                      setState(() {});
                                                    },
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 7,
                                                child: Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: TextField(
                                                    style: TextStyle(
                                                        color: ReColors()
                                                            .appMainColor,
                                                        fontFamily:
                                                            'titlefont'),
                                                    controller:
                                                        STDwIdthController,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          EdgeInsets.fromLTRB(
                                                              10, 10, 10, 0),
                                                      fillColor: ReColors()
                                                          .appMainColor,
                                                      enabledBorder:
                                                          new OutlineInputBorder(
                                                        borderRadius:
                                                            new BorderRadius
                                                                .circular(5.0),
                                                        borderSide: BorderSide(
                                                            color: ReColors()
                                                                .appMainColor),
                                                      ),
                                                      focusedBorder:
                                                          OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                color: Color(
                                                                    0xff055e8e),
                                                                width: 2.0),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                      ),
                                                      labelText: 'STD Width',
                                                      labelStyle: TextStyle(
                                                          color:
                                                              Color(0xff055e8e),
                                                          fontFamily:
                                                              'titlefont'),
                                                    ),
                                                    onChanged: (addresstext) {
                                                      setState(() {});
                                                    },
                                                  ),
                                                )
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Container(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextField(
                                            style: TextStyle(
                                                color: ReColors().appMainColor,
                                                fontFamily: 'titlefont'),
                                            controller: loomTypeController,
                                            decoration: InputDecoration(
                                              contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                              fillColor: ReColors().appMainColor,
                                              enabledBorder: new OutlineInputBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        5.0),
                                                borderSide: BorderSide(
                                                    color: ReColors()
                                                        .appMainColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0xff055e8e),
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              labelText: 'Loom Type',
                                              labelStyle: TextStyle(
                                                  color: Color(0xff055e8e),
                                                  fontFamily: 'titlefont'),
                                            ),
                                            onChanged: (addresstext) {
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Container(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextField(
                                            style: TextStyle(
                                                color: ReColors().appMainColor,
                                                fontFamily: 'titlefont'),
                                            controller: dyeArtController,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      10, 10, 10, 0),
                                              fillColor:
                                                  ReColors().appMainColor,
                                              enabledBorder:
                                                  new OutlineInputBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        5.0),
                                                borderSide: BorderSide(
                                                    color: ReColors()
                                                        .appMainColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0xff055e8e),
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              labelText: 'Dye Art No',
                                              labelStyle: TextStyle(
                                                  color: Color(0xff055e8e),
                                                  fontFamily: 'titlefont'),
                                            ),
                                            onChanged: (addresstext) {
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Container(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextField(
                                            style: TextStyle(
                                                color: ReColors().appMainColor,
                                                fontFamily: 'titlefont'),
                                            controller: shrinkagewarpController,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(
                                                      10, 10, 10, 0),
                                              fillColor:
                                                  ReColors().appMainColor,
                                              enabledBorder:
                                                  new OutlineInputBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        5.0),
                                                borderSide: BorderSide(
                                                    color: ReColors().appMainColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0xff055e8e),
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              labelText: 'Shrinkage Warp',
                                              labelStyle: TextStyle(
                                                  color: Color(0xff055e8e),
                                                  fontFamily: 'titlefont'),
                                            ),
                                            onChanged: (addresstext) {
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Container(
                                        child: Row(
                                          children: [
                                            Expanded(
                                                flex: 7,
                                                child: Align(
                                                  alignment: Alignment.centerLeft,
                                                  child: TextField(
                                                    style: TextStyle(
                                                        color: ReColors().appMainColor,
                                                        fontFamily: 'titlefont'),
                                                    controller:
                                                        no_of_endsController,
                                                    decoration: InputDecoration(
                                                      contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 0),
                                                      fillColor: ReColors().appMainColor,
                                                      enabledBorder: new OutlineInputBorder(
                                                        borderRadius: new BorderRadius.circular(5.0),
                                                        borderSide: BorderSide(color: ReColors().appMainColor),
                                                      ),
                                                      focusedBorder: OutlineInputBorder(
                                                        borderSide: const BorderSide(
                                                                color: Color(0xff055e8e),
                                                                width: 2.0),
                                                        borderRadius: BorderRadius.circular(5.0),
                                                      ),
                                                      labelText: 'Total No Of Ends',
                                                      labelStyle: TextStyle(
                                                          color: Color(0xff055e8e),
                                                          fontFamily: 'titlefont'
                                                      ),
                                                    ),
                                                    onChanged: (addresstext) {
                                                      setState(() {});
                                                    },
                                                  ),
                                                ))
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Container(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextField(
                                            style: TextStyle(
                                                color: ReColors().appMainColor,
                                                fontFamily: 'titlefont'),
                                            controller:
                                                sampleRefrenseController,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(10, 10, 10, 0),
                                              fillColor: ReColors().appMainColor,
                                              enabledBorder: new OutlineInputBorder(
                                                borderRadius: new BorderRadius.circular(5.0),
                                                borderSide: BorderSide(color: ReColors().appMainColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0xff055e8e),
                                                    width: 2.0),
                                                borderRadius: BorderRadius.circular(5.0),
                                              ),
                                              labelText: 'Sample Refrence',
                                              labelStyle: TextStyle(
                                                  color: Color(0xff055e8e),
                                                  fontFamily: 'titlefont'
                                              ),
                                            ),
                                            onChanged: (addresstext) {
                                              setState(() {});
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.fromLTRB(0, 5, 0, 5),
                                      child: Container(
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: TextField(
                                            style: TextStyle(
                                                color: ReColors().appMainColor,
                                                fontFamily: 'titlefont'),
                                            controller: finishController,
                                            decoration: InputDecoration(
                                              contentPadding:
                                                  EdgeInsets.fromLTRB(10, 10, 10, 0),
                                              fillColor:
                                                  ReColors().appMainColor,
                                              enabledBorder:
                                                  new OutlineInputBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(5.0),
                                                borderSide: BorderSide(
                                                    color: ReColors()
                                                        .appMainColor),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    color: Color(0xff055e8e),
                                                    width: 2.0),
                                                borderRadius: BorderRadius.circular(5.0),
                                              ),
                                              labelText: 'Finish',
                                              labelStyle: TextStyle(
                                                  color: Color(0xff055e8e),
                                                  fontFamily: 'titlefont'
                                              ),
                                            ),
                                            onChanged: (addresstext) {
                                              setState(() {});
                                            },
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
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          child: Row(children: <Widget>[
                        Expanded(
                            child: Padding(
                          padding: EdgeInsets.fromLTRB(5, 5, 5, 20),
                          child: RaisedButton(
                              onPressed: () {
                                article_string = ArticleController.text;
                                sampleRef_string =
                                    sampleRefrenseController.text;
                                weaveArt_String = Weave_Art_NoController.text;
                                dyeArt_string = dyeArtController.text;
                                warpColor_string = Warp_ColorController.text;
                                shade_String = ShadeController.text;
                                weaveTwill_string = Weave_TwillController.text;
                                picksInch_string = Picks_InchController.text;
                                reedCount_string = Reed_CountController.text;
                                reedWidth_string = Reed_WidthController.text;
                                endsInch_String = ends_inchController.text;
                                noOfEnds_String = no_of_endsController.text;
                                loomType_string = loomTypeController.text;
                                finish_string = finishController.text;
                                weigth_string = WeightController.text;
                                cutWidth_string = CUT_WidthController.text;
                                stdWidth_string = STDwIdthController.text;
                                shrinkageWeft_string =
                                    Shrinkage_WeftController.text;
                                shrinkafewarp_string =
                                    shrinkagewarpController.text;
                                GetJSON()
                                    .getFabricLibCardResult(
                                        context,
                                        SelectedorgCode,
                                        '',
                                        article_string,
                                        sampleRef_string,
                                        weaveArt_String,
                                        dyeArt_string,
                                        warpColor_string,
                                        shade_String,
                                        weaveTwill_string,
                                        picksInch_string,
                                        reedCount_string,
                                        reedWidth_string,
                                        endsInch_String,
                                        noOfEnds_String,
                                        loomType_string,
                                        finish_string,
                                        weigth_string,
                                        cutWidth_string,
                                        stdWidth_string,
                                        shrinkageWeft_string,
                                        shrinkafewarp_string,
                                        '')
                                    .then((value) {
                                  setState(() {
                                    FabricLibcardList = value;
                                    if (FabricLibcardList.length > 0) {
                                      bodyVisibility = true;
                                      scaffoldKey.currentState.openDrawer();
                                    } else {
                                      bodyVisibility = false;
                                      scaffoldKey.currentState.openDrawer();
                                    }
                                  });
                                });
                              },
                              color: ReColors().appMainColor,
                              child: Padding(
                                padding: EdgeInsets.all(5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.search,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      "Search",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'headerfont'),
                                    )
                                  ],
                                ),
                              )),
                        )),
                      ])),
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

  Widget BodyView(FabricCarditems carditems, int index1,
      List<FabricCarditems> FabricLibcardList1) {
    index1 = index1+1;
    return Container(
      child: Column(
        children: <Widget>[
          Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15.0),
                          boxShadow: <BoxShadow>[
                            BoxShadow(
                              color: Colors.grey,
                              offset: Offset(1.0, 15.0),
                              blurRadius: 20.0,
                            ),
                          ]),
                      child: Container(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Image.asset(
                                    'assets/images/am_launchericon.png',
                                    fit: BoxFit.contain,
                                    height: 60,
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Article ID : ${carditems.flexValueMeaning}",
                                              style: TextStyle(
                                                  fontFamily: 'headerfont',
                                                  fontSize: 12,
                                                  color: ReColors().appMainColor),
                                            ),
                                          ),
                                          Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "Article Code : ${carditems.description}",
                                                style: TextStyle(
                                                    fontFamily: 'headerfont',
                                                    fontSize: 12,
                                                    color: ReColors().appMainColor),
                                              )
                                          ),
                                          Align(
                                              alignment: Alignment.topLeft,
                                              child: Text(
                                                "Sample Reference : ${carditems.sampleReference}",
                                                style: TextStyle(
                                                    fontFamily: 'headerfont',
                                                    fontSize: 12,
                                                    color: ReColors().appMainColor),
                                              )
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Weave Code : ",
                                              style: TextStyle(
                                                  fontFamily: 'headerfont',
                                                  fontSize: 12,
                                                  color:
                                                      ReColors().appMainColor),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${carditems.weavArtNoRef}",
                                              style: TextStyle(
                                                  fontFamily: 'titlefont',
                                                  fontSize: 10,
                                                  color:
                                                      ReColors().appMainColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Dye Code : ",
                                              style: TextStyle(
                                                  fontFamily: 'headerfont',
                                                  fontSize: 12,
                                                  color: ReColors().appMainColor
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${carditems.dyeArtNoRef}",
                                              style: TextStyle(
                                                  fontFamily: 'titlefont',
                                                  fontSize: 10,
                                                  color:
                                                      ReColors().appMainColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Weave + Twill : ",
                                              style: TextStyle(
                                                  fontFamily: 'headerfont',
                                                  fontSize: 12,
                                                  color:
                                                      ReColors().appMainColor),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${carditems.weave}",
                                              style: TextStyle(
                                                  fontFamily: 'titlefont',
                                                  fontSize: 10,
                                                  color:
                                                      ReColors().appMainColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Shade : ",
                                              style: TextStyle(
                                                  fontFamily: 'headerfont',
                                                  fontSize: 12,
                                                  color: ReColors().appMainColor
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${carditems.color}",
                                              style: TextStyle(
                                                  fontFamily: 'titlefont',
                                                  fontSize: 10,
                                                  color:
                                                      ReColors().appMainColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Picks/Inch. : ",
                                              style: TextStyle(
                                                  fontFamily: 'headerfont',
                                                  fontSize: 12,
                                                  color: ReColors().appMainColor),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${carditems.picks}",
                                              style: TextStyle(
                                                  fontFamily: 'titlefont',
                                                  fontSize: 10,
                                                  color: ReColors().appMainColor
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Reed Count (Dent/CM) : ",
                                              style: TextStyle(
                                                  fontFamily: 'headerfont',
                                                  fontSize: 12,
                                                  color:
                                                      ReColors().appMainColor),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${carditems.reed}",
                                              style: TextStyle(
                                                  fontFamily: 'titlefont',
                                                  fontSize: 10,
                                                  color: ReColors().appMainColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Reed Width : ",
                                              style: TextStyle(
                                                  fontFamily: 'headerfont',
                                                  fontSize: 12,
                                                  color:
                                                      ReColors().appMainColor),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${carditems.reedWidth}",
                                              style: TextStyle(
                                                  fontFamily: 'titlefont',
                                                  fontSize: 10,
                                                  color:
                                                      ReColors().appMainColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Ends/Inch (Dent/CM) : ",
                                              style: TextStyle(
                                                  fontFamily: 'headerfont',
                                                  fontSize: 12,
                                                  color:
                                                      ReColors().appMainColor),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${carditems.epi}",
                                              style: TextStyle(
                                                  fontFamily: 'titlefont',
                                                  fontSize: 10,
                                                  color:
                                                      ReColors().appMainColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Total No. Of Ends : ",
                                              style: TextStyle(
                                                  fontFamily: 'headerfont',
                                                  fontSize: 12,
                                                  color:
                                                      ReColors().appMainColor),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${carditems.wvusedends}",
                                              style: TextStyle(
                                                  fontFamily: 'titlefont',
                                                  fontSize: 10,
                                                  color:
                                                      ReColors().appMainColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Finishing Route : ",
                                              style: TextStyle(
                                                  fontFamily: 'headerfont',
                                                  fontSize: 12,
                                                  color:
                                                      ReColors().appMainColor),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${carditems.routename}",
                                              style: TextStyle(
                                                  fontFamily: 'titlefont',
                                                  fontSize: 10,
                                                  color:
                                                      ReColors().appMainColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Weight : ",
                                              style: TextStyle(
                                                  fontFamily: 'headerfont',
                                                  fontSize: 12,
                                                  color:
                                                      ReColors().appMainColor),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${carditems.stdWeight}",
                                              style: TextStyle(
                                                  fontFamily: 'titlefont',
                                                  fontSize: 10,
                                                  color:
                                                      ReColors().appMainColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "CUT Width : ",
                                              style: TextStyle(
                                                  fontFamily: 'headerfont',
                                                  fontSize: 12,
                                                  color:
                                                      ReColors().appMainColor),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${carditems.cutWidth}",
                                              style: TextStyle(
                                                  fontFamily: 'titlefont',
                                                  fontSize: 10,
                                                  color:
                                                      ReColors().appMainColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "STD Width : ",
                                              style: TextStyle(
                                                  fontFamily: 'headerfont',
                                                  fontSize: 12,
                                                  color:
                                                      ReColors().appMainColor),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${carditems.stdWidth}",
                                              style: TextStyle(
                                                  fontFamily: 'titlefont',
                                                  fontSize: 10,
                                                  color:
                                                      ReColors().appMainColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Shrinkage Warp : ",
                                              style: TextStyle(
                                                  fontFamily: 'headerfont',
                                                  fontSize: 12,
                                                  color:
                                                      ReColors().appMainColor),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${carditems.stdShrinkage2}",
                                              style: TextStyle(
                                                  fontFamily: 'titlefont',
                                                  fontSize: 10,
                                                  color:
                                                      ReColors().appMainColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Shrinkage Weft : ",
                                              style: TextStyle(
                                                  fontFamily: 'headerfont',
                                                  fontSize: 12,
                                                  color:
                                                      ReColors().appMainColor),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${carditems.stdShrinkage1}",
                                              style: TextStyle(
                                                  fontFamily: 'titlefont',
                                                  fontSize: 10,
                                                  color:
                                                      ReColors().appMainColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Warp Color : ",
                                              style: TextStyle(
                                                  fontFamily: 'headerfont',
                                                  fontSize: 12,
                                                  color: ReColors().appMainColor
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${carditems.dyeColor}",
                                              style: TextStyle(
                                                  fontFamily: 'titlefont',
                                                  fontSize: 10,
                                                  color: ReColors().appMainColor),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Loom Type : ",
                                              style: TextStyle(
                                                  fontFamily: 'headerfont',
                                                  fontSize: 12,
                                                  color: ReColors().appMainColor
                                              ),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${carditems.loomtype}",
                                              style: TextStyle(
                                                  fontFamily: 'titlefont',
                                                  fontSize: 10,
                                                  color:
                                                      ReColors().appMainColor
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "Composition : ",
                                              style: TextStyle(
                                                  fontFamily: 'headerfont',
                                                  fontSize: 12,
                                                  color: ReColors().appMainColor),
                                            ),
                                          ),
                                          Align(
                                            alignment: Alignment.topLeft,
                                            child: Text(
                                              "${carditems.composition}",
                                              style: TextStyle(
                                                  fontFamily: 'titlefont',
                                                  fontSize: 10,
                                                  color: ReColors().appMainColor
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.all(5),
                                      child: Column(
                                        children: [
                                          Align(
                                            alignment: Alignment.center,
                                            child: Text(
                                              "Total : ${index1} / ${FabricLibcardList1.length}",
                                              style: TextStyle(
                                                  fontFamily: 'headerfont',
                                                  fontSize: 14,
                                                  color: ReColors().appMainColor
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                      ),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
