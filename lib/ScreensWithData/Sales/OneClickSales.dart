import 'dart:io';
import 'dart:math';

import 'package:art/APIUri/BaseUrl.dart';
import 'package:art/HexCodeConverter/Hexcode.dart';
import 'package:art/Model/daywiseunit_model.dart';
import 'package:art/Model/denim_sales_total.dart';
import 'package:art/Model/pieChartModel.dart';
import 'package:art/Model/unit_model.dart';
import 'package:art/ParsingJSON/GetJSONMethod.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/CustomAppbarWithImage.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:art/ScreensWithData/Menu/MainMenuPopup.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChartApp extends StatefulWidget {
  // ignore: prefer_const_constructors_in_immutables
  ChartApp({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ChartApp> {
  String url = BaseURL().NewAuth + 'dashboard/denim_sales/all_units';
  String unitdaywiseurl =
      BaseURL().NewAuth + 'dashboard/denim_sales/daywiseunit/';
  Color color2 = HexColor("#055e8e");
  List dataJSON;
  List dataJSONunitdaywise;
  int met_per, target_per, sales, total_sales;
  bool loading = false;
  TooltipBehavior _tooltip;
  List<UnitModelitems> unitlist = [];
  List<DenimSalesTotalitems> denimSalesTotalList = [];
  int unitIntValue;

  @override
  void initState() {
    getCoinsTimeSeries().then((value) {
      if (this.mounted) {
        this.setState(() {});
      }
    });
    GetJSON().getUnit(context).then((value) {
      if (this.mounted) {
        this.setState(() {
          unitlist = value;
          unitlist?.length > 0 ? unitlist[0] : '';
          if (unitlist.length <= 0) {
          } else {
            loading = true;
            getdayWiseUnit(0).then((value) => {});
          }
        });
      }
    });
    if (this.mounted) {
      this.setState(() {
        GetJSON().getDenimSalesTotal(context, 0).then((value) {
          denimSalesTotalList = value;
          denimSalesTotalList?.length > 0 ? denimSalesTotalList[0] : '';
          loading = true;
        });
      });
    }

    _tooltip = TooltipBehavior(
      enable: true,
      canShowMarker: true,
    );
    GetJSON().getOneClickSales().then((count) {
      Map<String, dynamic> targetSales = jsonDecode(count.body);
      met_per = targetSales['v_met_per'];
      target_per = targetSales['v_tgt_per'];
      sales = targetSales['sales_tgt'];
      total_sales = targetSales['total_sales'];
      loading = true;
    });
  }

  final List<CircularSeries<PieChartitem, String>> _seriesPieData = [];

  Future<String> getCoinsTimeSeries() async {
    var response = await http.get(Uri.parse(url));

    if (this.mounted) {
      this.setState(() {
        var extractdata = json.decode(response.body);
        dataJSON = extractdata["items"];
        loading = true;
        print('dataJSON values ${dataJSON}');
        /*  chartWidget();*/
      });
    }
    return '';
  }

  bool graphVisiblity = true;

  Future<String> getdayWiseUnit(int org_id) async {
    var response =
        await http.get(Uri.parse(unitdaywiseurl + org_id.toString()));

    if (this.mounted) {
      this.setState(() {
        var extractdata = json.decode(response.body);
        dataJSONunitdaywise = extractdata["items"];
        loading = true;
        print('dataJSON values 232 ${dataJSONunitdaywise}');
        if (dataJSONunitdaywise.length <= 0) {
          graphVisiblity = false;
        }
        /*  chartWidget();*/
      });
    }
    return '';
  }

  String days;

  @override
  Widget build(BuildContext context) {
    List<PieChartitem> tsdata = [];
    if (dataJSON != null) {
      for (Map m in dataJSON) {
        try {
          tsdata.add(new PieChartitem(
              label1: m['label1'], colour: m['colour'], value1: m['value1']));
        } catch (e) {
          print(e.toString());
        }
      }
    } else {
      // Dummy list to prevent dataJSON = NULL
      // tsdata.add(new PieChartitem(new DateTime.now(), 0.0));
    }
    List<Daywiseunititems> DayWisedata = [];
    List<int> DayWisedata1 = [];
    if (dataJSONunitdaywise != null) {
      for (Map m in dataJSONunitdaywise) {
        print('piechart values ${m}');
        try {
          DayWisedata.add(
              new Daywiseunititems(day: m['day'], dayTotal: m['day_total']));
          DayWisedata1.add(m['day_total']);
        } catch (e) {
          print(e.toString());
        }
      }
    } else {
      // Dummy list to prevent dataJSON = NULL
      // tsdata.add(new PieChartitem(new DateTime.now(), 0.0));
    }
    return Willpopwidget().getWillScope(Scaffold(
      appBar: new CustomAppBarImage(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => MainMenuPopUp()),
          );
        },
        Title: 'One-Click Sales',
        image_bar: 'assets/images/oneclick_logo.png',
        refreshonPressed: () {
          getCoinsTimeSeries();
        },
      ),
      body: Container(
        color: Colors.white,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                child: loading == false
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(-1.0, 0.0),
                            end: Alignment(1.0, 0.0),
                            transform: GradientRotation(0.7853982),
                            colors: [
                              ReColors().lightColor,
                              ReColors().darkColor
                            ],
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(17.0),
                        ),
                        child: Center(
                          child: SfCircularChart(
                              legend: Legend(
                                  isVisible: true,
                                  position: LegendPosition.bottom,
                                  textStyle: TextStyle(color: Colors.white),
                                  overflowMode: LegendItemOverflowMode.wrap),
                              series: <CircularSeries<PieChartitem, String>>[
                                PieSeries<PieChartitem, String>(
                                  dataSource: tsdata,
                                  animationDuration: 1000,
                                  animationDelay: 1000,
                                  xValueMapper: (PieChartitem data, _) =>
                                      data.label1,
                                  yValueMapper: (PieChartitem data, _) =>
                                      data.value1,
                                  dataLabelMapper: (PieChartitem data, _) =>
                                      '${data.value1}',
                                  pointColorMapper: (PieChartitem data, _) =>
                                      Color(int.parse(
                                          data.colour.replaceAll("#", "0xff"))),
                                  dataLabelSettings: DataLabelSettings(
                                      isVisible: true,
                                      textStyle: TextStyle(color: Colors.white),
                                      labelPosition:
                                          ChartDataLabelPosition.inside),
                                )
                              ]),
                        ),
                      ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17.0),
                ),
                elevation: 5,
                margin: EdgeInsets.all(10),
              ),
              Card(
                child: loading == false
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(-1.0, 0.0),
                            end: Alignment(1.0, 0.0),
                            transform: GradientRotation(0.7853982),
                            colors: [
                              ReColors().lightColor,
                              ReColors().darkColor
                            ],
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(17.0),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  new Text(
                                    '${sales}\nSales Target',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                  new Text(
                                    '${total_sales}\nTotal Sales',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 200,
                              width: 200,
                              decoration: new BoxDecoration(
                                color: Colors.transparent,
                                shape: BoxShape.circle,
                                border: new Border.all(
                                  color: Colors.white,
                                  width: 12,
                                ),
                              ),
                              child: Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.fromLTRB(0, 50, 0, 50),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '${met_per}',
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.green),
                                        ),
                                        Text(
                                          '/',
                                          style: TextStyle(
                                              fontSize: 25,
                                              color: Colors.white),
                                        ),
                                        Text(
                                          '${target_per}',
                                          style: TextStyle(
                                              fontSize: 25, color: Colors.red),
                                        ),
                                      ],
                                    ),
                                    Text(
                                      '%',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    ),
                                    Text(
                                      'Target Met',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.white),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            /* Container(
                        height: 200,
                        width: 200,
                        decoration: new BoxDecoration(
                          color: Colors.transparent,
                          shape: BoxShape.circle,
                          border: new Border.all(
                            color: Colors.white,
                            width: 12,
                          ),
                        ),
                        child: new Center(
                          child: new Text(
                            '${met_per}/${target_per}\n%\nTarget Met',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 23, color: Colors.white),
                          ),
                        ),
                      )*/
                          ],
                        ),
                      ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17.0),
                ),
                elevation: 5,
                margin: EdgeInsets.all(10),
              ),
              loading == false
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Row(
                      children: [
                        SizedBox(
                          height: 35,
                          child: new GestureDetector(
                              onTap: () {
                                graphVisiblity = true;
                                getdayWiseUnit(0);
                                GetJSON()
                                    .getDenimSalesTotal(context, 0)
                                    .then((value) {
                                  denimSalesTotalList = value;
                                  loading = true;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(8, 5, 5, 5),
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
                                    padding: EdgeInsets.fromLTRB(5, 5, 5, 5),
                                    child: Text(
                                      'All Units',
                                      overflow: TextOverflow.ellipsis,
                                      softWrap: false,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12,
                                          fontFamily: 'headingfont'),
                                    ),
                                  ),
                                ),
                              )),
                        ),
                        Expanded(
                          child: SizedBox(
                            height: 35,
                            width: double.infinity,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount:
                                    unitlist == null ? 0 : unitlist.length,
                                itemBuilder: (BuildContext context, int index) {
                                  UnitModelitems depReqItem = unitlist[index];
                                  return new GestureDetector(
                                      onTap: () {
                                        print(
                                            'notify id : ${depReqItem.orgId}');
                                        graphVisiblity = true;
                                        getdayWiseUnit(depReqItem.orgId);
                                        GetJSON()
                                            .getDenimSalesTotal(
                                                context, depReqItem.orgId)
                                            .then((value) {
                                          denimSalesTotalList = value;
                                          loading = true;
                                        });
                                      },
                                      child: Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(8, 5, 5, 5),
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
                                            borderRadius:
                                                BorderRadius.circular(5.0),
                                          ),
                                          child: Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(5, 5, 5, 5),
                                            child: Text(
                                              '${depReqItem.organizationCode == null ? '' : depReqItem.organizationCode}',
                                              overflow: TextOverflow.ellipsis,
                                              softWrap: false,
                                              style: TextStyle(
                                                  fontSize: 12,
                                                  color: Colors.white,
                                                  fontFamily: 'headingfont'),
                                            ),
                                          ),
                                        ),
                                      ));
                                }),
                          ),
                        )
                      ],
                    ),
              loading == false
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Container(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        child: Text(
                                          'Direct Exports',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        padding:
                                            EdgeInsets.fromLTRB(20, 5, 20, 5),
                                        color: Colors.black,
                                      ),
                                      Divider(
                                        height: 0.5,
                                        color: Colors.grey,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment(-1.0, 0.0),
                                            end: Alignment(1.0, 0.0),
                                            transform:
                                                GradientRotation(0.7853982),
                                            colors: [Colors.black, color2],
                                          ),
                                          color: Colors.white,
                                        ),
                                        padding:
                                            EdgeInsets.fromLTRB(20, 15, 20, 15),
                                        child: Text(
                                          '${denimSalesTotalList?.length > 0 ? denimSalesTotalList[0].exportSales : ''}',
                                          // '${denimSalesTotalList[0].exportSales == null ? '-' : denimSalesTotalList[0].exportSales}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontFamily: 'headerfont'),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        child: Text(
                                          'Indirect Exports',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        padding:
                                            EdgeInsets.fromLTRB(20, 5, 20, 5),
                                        color: Colors.black,
                                      ),
                                      Divider(
                                        height: 0.5,
                                        color: Colors.grey,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment(-1.0, 0.0),
                                            end: Alignment(1.0, 0.0),
                                            transform:
                                                GradientRotation(0.7853982),
                                            colors: [Colors.black, color2],
                                          ),
                                          color: Colors.white,
                                        ),
                                        padding:
                                            EdgeInsets.fromLTRB(20, 15, 20, 15),
                                        child: Text(
                                          '${denimSalesTotalList?.length > 0 ? denimSalesTotalList[0].indirectExportSale : ''}',
                                          // '${denimSalesTotalList[0].indirectExportSale == null ? '-' : denimSalesTotalList[0].indirectExportSale}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontFamily: 'headerfont'),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        child: Text(
                                          'Dispatch Approval',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        padding:
                                            EdgeInsets.fromLTRB(20, 5, 20, 5),
                                        color: Colors.black,
                                      ),
                                      Divider(
                                        height: 0.5,
                                        color: Colors.grey,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment(-1.0, 0.0),
                                            end: Alignment(1.0, 0.0),
                                            transform:
                                                GradientRotation(0.7853982),
                                            colors: [Colors.black, color2],
                                          ),
                                          color: Colors.white,
                                        ),
                                        padding:
                                            EdgeInsets.fromLTRB(20, 15, 20, 15),
                                        child: Text(
                                          '${denimSalesTotalList?.length > 0 ? denimSalesTotalList[0].dispatchApproval : ''}',

                                          // '${denimSalesTotalList[0].dispatchApproval == null ? '-' : denimSalesTotalList[0].dispatchApproval}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontFamily: 'headerfont'),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    children: [
                                      Container(
                                        width: double.infinity,
                                        child: Text(
                                          'Inter Unit',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        padding:
                                            EdgeInsets.fromLTRB(20, 5, 20, 5),
                                        color: Colors.black,
                                      ),
                                      Divider(
                                        height: 0.5,
                                        color: Colors.grey,
                                      ),
                                      Container(
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          gradient: LinearGradient(
                                            begin: Alignment(-1.0, 0.0),
                                            end: Alignment(1.0, 0.0),
                                            transform:
                                                GradientRotation(0.7853982),
                                            colors: [Colors.black, color2],
                                          ),
                                          color: Colors.white,
                                        ),
                                        padding:
                                            EdgeInsets.fromLTRB(20, 15, 20, 15),
                                        child: Text(
                                          '${denimSalesTotalList?.length > 0 ? denimSalesTotalList[0].interUnitSale : ''}',

                                          // '${denimSalesTotalList[0].interUnitSale == null ? '-' : denimSalesTotalList[0].interUnitSale}',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 25,
                                              fontFamily: 'headerfont'),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Container(
                                width: double.infinity,
                                child: Text(
                                  'Total Exports',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(color: Colors.white),
                                ),
                                padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                color: Colors.black,
                              ),
                              Divider(
                                height: 0.5,
                                color: Colors.grey,
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment(-1.0, 0.0),
                                    end: Alignment(1.0, 0.0),
                                    transform: GradientRotation(0.7853982),
                                    colors: [Colors.black, color2],
                                  ),
                                  color: Colors.white,
                                ),
                                padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                                child: Text(
                                  '${denimSalesTotalList?.length > 0 ? denimSalesTotalList[0].totalExports : ''}',

                                  // '${denimSalesTotalList[0].totalExports == null ? '-' : denimSalesTotalList[0].totalExports}',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 25,
                                      fontFamily: 'headerfont'),
                                ),
                              )
                            ],
                          ),
                        ],
                      )),
              Card(
                child: graphVisiblity == false
                    ? Padding(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'NO DATA FOUND',
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    : loading == false
                        ? Center(
                            child: CircularProgressIndicator(),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment(-1.0, 0.0),
                                end: Alignment(1.0, 0.0),
                                transform: GradientRotation(0.7853982),
                                colors: [
                                  ReColors().lightColor,
                                  ReColors().darkColor
                                ],
                              ),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(17.0),
                            ),
                            child: Center(
                              child: SfCartesianChart(
                                tooltipBehavior: _tooltip,
                                plotAreaBorderWidth: 0,
                                primaryXAxis: CategoryAxis(
                                    title: AxisTitle(
                                        text: 'Days',
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Roboto',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300)),
                                    labelStyle: TextStyle(color: Colors.white),
                                    majorGridLines: const MajorGridLines(
                                        width: 0, color: Colors.white)),
                                primaryYAxis: NumericAxis(
                                    labelStyle: TextStyle(color: Colors.white),
                                    majorTickLines: const MajorTickLines(
                                        color: Colors.transparent),
                                    axisLine: const AxisLine(width: 0),
                                    title: AxisTitle(
                                        text: 'Total Days',
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontFamily: 'Roboto',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300)),
                                    minimum: 0,
                                    maximum: DayWisedata1.isEmpty
                                        ? 0
                                        : DayWisedata1.reduce(max).toDouble()),
                                series: <
                                    ColumnSeries<Daywiseunititems, String>>[
                                  ColumnSeries<Daywiseunititems, String>(
                                    // Binding the chartData to the dataSource of the column series.
                                    dataSource: DayWisedata,
                                    xValueMapper: (Daywiseunititems sales, _) =>
                                        sales.day,
                                    yValueMapper: (Daywiseunititems sales, _) =>
                                        sales.dayTotal,
                                    pointColorMapper:
                                        (Daywiseunititems data, _) =>
                                            ReColors().columnBarColor,
                                    dataLabelSettings: DataLabelSettings(
                                        isVisible: true,
                                        connectorLineSettings:
                                            ConnectorLineSettings(
                                                width: 6,
                                                type: ConnectorType.curve),
                                        textStyle: TextStyle(
                                            color: Colors.white, fontSize: 7),
                                        labelPosition:
                                            ChartDataLabelPosition.outside),
                                  ),
                                ],
                              ),
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
        ),
      ),
    ));
  }
}
