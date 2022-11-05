import 'package:art/HexCodeConverter/Hexcode.dart';
import 'package:art/Model/wms_am5_model/warehouse_rack_list.dart';
import 'package:art/Model/wms_am5_model/warehouse_racks.dart';
import 'package:art/Model/wms_am5_model/warehouse_types.dart';
import 'package:art/ParsingJSON/GetJSONMethod.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/CustomAppbarWithImage.dart';
import 'package:art/ReuseableWidget/CustomDropdown.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:art/ScreensWithData/DAMScreens/DAMMain.dart';
import 'package:art/ScreensWithData/Menu/MainMenuPopup.dart';
import 'package:flutter/material.dart';

class WMS_AM5 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WMS_AM5State();
}

class _WMS_AM5State extends State<WMS_AM5> {
  List<Warehouse_types_items> warehouse_types_items_list;
  List<Warehouse_rack_list_items> Warehouse_rack_list_items_list;
  List<Warehouse_racks_items> Warehouse_racks_items_list;
  String Rack_id, wh_type;
  Color BackgroundColor = HexColor("#4c5cb1");

  @override
  void initState() {
    super.initState();
    GetJSON().getWareHouseTypes(84).then((users) {
      setState(() {
        warehouse_types_items_list = users;
        print(
            'warehouse_types_items_list ${warehouse_types_items_list.length}');
        print(
            'warehouse_types_items_list value ${warehouse_types_items_list[0].whTypeName}');
        if (warehouse_types_items_list.length == 0) {
          visible = false;
          return showError('No data found', Icons.assignment_late_outlined);
        } else {
          whTypeIdselectedSpinnerItem =
              warehouse_types_items_list.first.whTypeId;
          visible = true;
        }
      });
    });
  }

  Color RomanColor = HexColor("#FF8C00");

  bool visible = false;
  bool rackLabelvisible = false;
  bool rackLabelvisibleContainer = false;
  bool listviewVisible = false;
  String whTypeId_spinner, whTypeIdselectedSpinnerItem;
  String rackLabel_spinner, rackLabelselectedSpinnerItem;

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

  Widget warehouse_typesView() {
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
                                        warehouse_types_items_list.map((item) {
                                              return DropdownMenuItem(
                                                child: chip(
                                                  item.whTypeName,
                                                ),
                                                value: item.whTypeId,
                                                onTap: () {
                                                  whTypeId_spinner =
                                                      item.whTypeId;
                                                  print(
                                                      'Selected UNit ID: ${whTypeId_spinner}');
                                                  print(
                                                      'selectedSpinnerItem3293: ${whTypeIdselectedSpinnerItem.toString()}');
                                                },
                                              );
                                            }).toList() ??
                                            [],
                                    onChanged: (newVal) {
                                      setState(() {
                                        rackLabelvisibleContainer = true;
                                        whTypeIdselectedSpinnerItem = newVal;
                                        GetJSON()
                                            .getWareHouseRackList(
                                                84, whTypeIdselectedSpinnerItem)
                                            .then((users) {
                                          setState(() {
                                            Warehouse_rack_list_items_list =
                                                users;
                                            if (Warehouse_rack_list_items_list.length == 0) {
                                              rackLabelvisible = false;
                                              return showError(
                                                  'No data found',
                                                  Icons
                                                      .assignment_late_outlined);
                                            } else {
                                              rackLabelselectedSpinnerItem =
                                                  Warehouse_rack_list_items_list
                                                      .first.rackLabel;
                                              rackLabelvisible = true;
                                            }
                                          });
                                        });
                                      });
                                    },
                                    value: whTypeIdselectedSpinnerItem,
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
                  ],
                )),
      )),
    );
  }

  List<String> Warehouse_bin_type_0 = [];
  List<String> Warehouse_bin_type_I = [];
  List<String> Warehouse_bin_type_II = [];
  List<String> Warehouse_bin_type_III = [];
  List<String> Warehouse_bin_type_IV = [];
  List<String> Warehouse_bin_type_V = [];
  List<String> Warehouse_bin_type_VI = [];
  List<String> Warehouse_bin_type_VII = [];
  List<String> Warehouse_bin_type_VIII = [];

  Widget Warehouse_rack_listView() {
    return Container(
      child: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(5),
        child: rackLabelvisible == false
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Visibility(
                visible: rackLabelvisible,
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
                                        Warehouse_rack_list_items_list.map(
                                                (item) {
                                              return DropdownMenuItem(
                                                child: chip(
                                                  item.rackLabel,
                                                ),
                                                value: item.rackLabel,
                                                onTap: () {
                                                  rackLabel_spinner =
                                                      item.rackLabel;
                                                  print(
                                                      'Selected UNit ID: ${rackLabel_spinner}');
                                                  print(
                                                      'selectedSpinnerItem3293: ${rackLabelselectedSpinnerItem.toString()}');
                                                },
                                              );
                                            }).toList() ??
                                            [],
                                    onChanged: (newVal) {
                                      setState(() {
                                        rackLabelselectedSpinnerItem = newVal;
                                        listviewVisible = true;
                                        print(
                                            'selectedSpiasdasd: ${rackLabelselectedSpinnerItem.toString()}');

                                        GetJSON()
                                            .getWareHouseRack(
                                                rackLabelselectedSpinnerItem,
                                                84,
                                                whTypeIdselectedSpinnerItem)
                                            .then((users) {
                                          setState(() {
                                            Warehouse_racks_items_list = users;
                                            Warehouse_bin_type_0.clear();
                                            Warehouse_bin_type_I.clear();
                                            Warehouse_bin_type_II.clear();
                                            Warehouse_bin_type_III.clear();
                                            Warehouse_bin_type_IV.clear();
                                            Warehouse_bin_type_V.clear();
                                            Warehouse_bin_type_VI.clear();
                                            Warehouse_bin_type_VII.clear();
                                            Warehouse_bin_type_VIII.clear();
                                            print(
                                                'adjasdkahsjhjk ${Warehouse_racks_items_list[0].binNumber}');
                                            for (int i = 0;
                                                i <
                                                    Warehouse_racks_items_list
                                                        .length;
                                                i++) {
                                              if (Warehouse_racks_items_list[i]
                                                      .binType ==
                                                  '0') {
                                                Warehouse_bin_type_0.add(
                                                    Warehouse_racks_items_list[
                                                            i]
                                                        .binNumber
                                                    /*TableRow(children: [
                                                      Container(
                                                        child: Text(Warehouse_racks_items_list[i].binNumber),
                                                        padding: EdgeInsets.all(3),
                                                        color: ReColors().menubgdarkgreyColor,
                                                      )
                                                ])*/
                                                    );

                                                // Warehouse_bin_type_0.add(Warehouse_racks_items_list[i].binNumber);
                                              }
                                              else if (Warehouse_racks_items_list[i].binType == 'I') {
                                                Warehouse_bin_type_I.add(Warehouse_racks_items_list[i].binNumber);
                                              }
                                              else if (Warehouse_racks_items_list[i]
                                                      .binType ==
                                                  'II') {
                                                Warehouse_bin_type_II.add(
                                                    Warehouse_racks_items_list[
                                                            i]
                                                        .binNumber);

                                                // Warehouse_bin_type_0.add(Warehouse_racks_items_list[i].binNumber);
                                              } else if (Warehouse_racks_items_list[
                                                          i]
                                                      .binType ==
                                                  'III') {
                                                Warehouse_bin_type_III.add(
                                                    Warehouse_racks_items_list[
                                                            i]
                                                        .binNumber);

                                                // Warehouse_bin_type_0.add(Warehouse_racks_items_list[i].binNumber);
                                              } else if (Warehouse_racks_items_list[i].binType ==
                                                  'IV') {
                                                Warehouse_bin_type_IV.add(Warehouse_racks_items_list[
                                                            i]
                                                        .binNumber);

                                                // Warehouse_bin_type_0.add(Warehouse_racks_items_list[i].binNumber);
                                              }
                                              else if (Warehouse_racks_items_list[i].binType == 'V') {
                                                Warehouse_bin_type_V.add(Warehouse_racks_items_list[i].binNumber);
                                              }
                                              else if (Warehouse_racks_items_list[i].binType == 'VI') {
                                                Warehouse_bin_type_VI.add(Warehouse_racks_items_list[i].binNumber);
                                              }
                                              else if (Warehouse_racks_items_list[i].binType == 'VII') {
                                                Warehouse_bin_type_VII.add(Warehouse_racks_items_list[i].binNumber);
                                              }
                                              else if (Warehouse_racks_items_list[
                                                          i]
                                                      .binType ==
                                                  'VIII') {
                                                Warehouse_bin_type_VIII.add(
                                                    Warehouse_racks_items_list[
                                                            i]
                                                        .binNumber);

                                                // Warehouse_bin_type_0.add(Warehouse_racks_items_list[i].binNumber);
                                              }
                                            }
                                          });
                                        });
                                      });
                                    },
                                    value: rackLabelselectedSpinnerItem,
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
                  ],
                )),
      )),
    );
  }

  Color color2 = HexColor("#055e8e");

  Widget table0(List<String> list) {
    return Container(
        /* decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                offset: Offset(1.0, 15.0),
                blurRadius: 20.0,
              ),
            ]),*/
        child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
          sortColumnIndex: 0,
          dividerThickness: 0,
          headingTextStyle: TextStyle(
              color: Colors.white, fontFamily: 'headerfont', fontSize: 15),
          showCheckboxColumn: false,
          dataRowHeight: 20,
          headingRowColor:
              MaterialStateColor.resolveWith((states) => RomanColor),
          headingRowHeight: 20,
          horizontalMargin: 2,
          columns: <DataColumn>[
            DataColumn(
              label: Container(
                height: 100,
                width: 30,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      //                   <--- right side
                      color: Colors.black,
                      width: 1.0,
                    ),
                    bottom: BorderSide(
                      //                   <--- right side
                      color: Colors.black,
                      width: 1.0,
                    ),
                    left: BorderSide(
                      //                   <--- right side
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  color: RomanColor,
                ),
                child: Column(
                    children: [Text('0', style: TextStyle(fontSize: 16.0))]),
              ),
            ),
          ],
          rows: List.generate(
              list.length,
              (index) => DataRow(
                      onSelectChanged: (bool selected) {
                        if (selected) {
                          print('STATUS: ${list[index].toString()}--');
                          Navigator.of(context).push(
                            PageRouteBuilder(
                                pageBuilder: (context, _, __) => customAler(),
                                opaque: false),
                          );
                        }
                      },
                      cells: [
                        DataCell(Container(
                          height: 100,
                          width: 30,
                          decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  //                   <--- right side
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                                bottom: BorderSide(
                                  //                   <--- right side
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              color: ReColors().menubgdarkgreyColor),
                          child: Text('${list[index].toString()}',
                              
                              softWrap: false,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'headerfont',
                                    fontSize: 13)),
                        )),
                      ]))),
    ));
  }

  Widget tableI(List<String> list) {
    return Container(
        /* decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                offset: Offset(1.0, 15.0),
                blurRadius: 20.0,
              ),
            ]),*/
        child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
          sortColumnIndex: 0,
          dividerThickness: 0,
          headingTextStyle: TextStyle(
              color: Colors.white, fontFamily: 'headerfont', fontSize: 15),
          showCheckboxColumn: false,
          dataRowHeight: 20,
          headingRowColor:
              MaterialStateColor.resolveWith((states) => RomanColor),
          headingRowHeight: 20,
          horizontalMargin: 2,
          columns: <DataColumn>[
            DataColumn(
              label: Container(
                height: 100,
                width: 30,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      //                   <--- right side
                      color: Colors.black,
                      width: 1.0,
                    ),
                    bottom: BorderSide(
                      //                   <--- right side
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  color: RomanColor,
                ),
                child: Column(
                    children: [Text('I', style: TextStyle(fontSize: 16.0))]),
              ),
            ),
          ],
          rows: List.generate(
              list.length,
              (index) => DataRow(
                      onSelectChanged: (bool selected) {
                        if (selected) {
                          print('STATUS: ${list[index].toString()}--');
                          Navigator.of(context).push(
                            PageRouteBuilder(
                                pageBuilder: (context, _, __) => customAler(),
                                opaque: false),
                          );
                        }
                      },
                      cells: [
                        DataCell(Container(
                          height: 100,
                          width: 30,
                          decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  //                   <--- right side
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                                bottom: BorderSide(
                                  //                   <--- right side
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              color: ReColors().menubgdarkgreyColor),
                          child: Text('${list[index].toString()}',
                              
                              softWrap: false,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'headerfont',
                                    fontSize: 13)),
                        )),
                      ]))),
    ));
  }

  Widget tableII(List<String> list) {
    return Container(
        /* decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                offset: Offset(1.0, 15.0),
                blurRadius: 20.0,
              ),
            ]),*/
        child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
          sortColumnIndex: 0,
          dividerThickness: 0,
          headingTextStyle: TextStyle(
              color: Colors.white, fontFamily: 'headerfont', fontSize: 15),
          showCheckboxColumn: false,
          dataRowHeight: 20,
          headingRowColor:
              MaterialStateColor.resolveWith((states) => RomanColor),
          headingRowHeight: 20,
          horizontalMargin: 2,
          columns: <DataColumn>[
            DataColumn(
              label: Container(
                height: 100,
                width: 30,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      //                   <--- right side
                      color: Colors.black,
                      width: 1.0,
                    ),
                    bottom: BorderSide(
                      //                   <--- right side
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  color: RomanColor,
                ),
                child: Column(
                    children: [Text('II', style: TextStyle(fontSize: 16.0))]),
              ),
            ),
          ],
          rows: List.generate(
              list.length,
              (index) => DataRow(
                      onSelectChanged: (bool selected) {
                        if (selected) {
                          print('STATUS: ${list[index].toString()}--');
                          Navigator.of(context).push(
                            PageRouteBuilder(
                                pageBuilder: (context, _, __) => customAler(),
                                opaque: false),
                          );
                        }
                      },
                      cells: [
                        DataCell(Container(
                          height: 100,
                          width: 30,
                          decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  //                   <--- right side
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                                bottom: BorderSide(
                                  //                   <--- right side
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              color: ReColors().menubgdarkgreyColor),
                          child: Text('${list[index].toString()}',
                              
                              softWrap: false,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'headerfont',
                                    fontSize: 13)),
                        )),
                      ]))),
    ));
  }

  Widget tableIII(List<String> list) {
    return Container(
        /* decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                offset: Offset(1.0, 15.0),
                blurRadius: 20.0,
              ),
            ]),*/
        child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
          sortColumnIndex: 0,
          dividerThickness: 0,
          headingTextStyle: TextStyle(
              color: Colors.white, fontFamily: 'headerfont', fontSize: 15),
          showCheckboxColumn: false,
          dataRowHeight: 20,
          headingRowColor:
              MaterialStateColor.resolveWith((states) => RomanColor),
          headingRowHeight: 20,
          horizontalMargin: 2,
          columns: <DataColumn>[
            DataColumn(
              label: Container(
                height: 100,
                width: 30,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      //                   <--- right side
                      color: Colors.black,
                      width: 1.0,
                    ),
                    bottom: BorderSide(
                      //                   <--- right side
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  color: RomanColor,
                ),
                child: Column(
                    children: [Text('III', style: TextStyle(fontSize: 16.0))]),
              ),
            ),
          ],
          rows: List.generate(
              list.length,
              (index) => DataRow(
                      onSelectChanged: (bool selected) {
                        if (selected) {
                          print('STATUS: ${list[index].toString()}--');
                          Navigator.of(context).push(
                            PageRouteBuilder(
                                pageBuilder: (context, _, __) => customAler(),
                                opaque: false),
                          );
                        }
                      },
                      cells: [
                        DataCell(Container(
                          height: 100,
                          width: 30,
                          decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  //                   <--- right side
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                                bottom: BorderSide(
                                  //                   <--- right side
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              color: ReColors().menubgdarkgreyColor),
                          child: Text('${list[index].toString()}',
                              
                              softWrap: false,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'headerfont',
                                    fontSize: 13)),
                        )),
                      ]))),
    ));
  }

  Widget tableIV(List<String> list) {
    return Container(
        /* decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                offset: Offset(1.0, 15.0),
                blurRadius: 20.0,
              ),
            ]),*/
        child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
          sortColumnIndex: 0,
          dividerThickness: 0,
          headingTextStyle: TextStyle(
              color: Colors.white, fontFamily: 'headerfont', fontSize: 15),
          showCheckboxColumn: false,
          dataRowHeight: 20,
          headingRowColor:
              MaterialStateColor.resolveWith((states) => RomanColor),
          headingRowHeight: 20,
          horizontalMargin: 2,
          columns: <DataColumn>[
            DataColumn(
              label: Container(
                height: 100,
                width: 30,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      //                   <--- right side
                      color: Colors.black,
                      width: 1.0,
                    ),
                    bottom: BorderSide(
                      //                   <--- right side
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  color: RomanColor,
                ),
                child: Column(
                    children: [Text('IV', style: TextStyle(fontSize: 16.0))]),
              ),
            ),
          ],
          rows: List.generate(
              list.length,
              (index) => DataRow(
                      onSelectChanged: (bool selected) {
                        if (selected) {
                          print('STATUS: ${list[index].toString()}--');
                          Navigator.of(context).push(
                            PageRouteBuilder(
                                pageBuilder: (context, _, __) => customAler(),
                                opaque: false),
                          );
                        }
                      },
                      cells: [
                        DataCell(Container(
                          height: 100,
                          width: 30,
                          decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  //                   <--- right side
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                                bottom: BorderSide(
                                  //                   <--- right side
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              color: ReColors().menubgdarkgreyColor),
                          child: Text('${list[index].toString()}',
                              
                              softWrap: false,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'headerfont',
                                    fontSize: 13)),
                        )),
                      ]))),
    ));
  }

  Widget tableV(List<String> list) {
    return Container(
        /* decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                offset: Offset(1.0, 15.0),
                blurRadius: 20.0,
              ),
            ]),*/
        child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
          sortColumnIndex: 0,
          dividerThickness: 0,
          headingTextStyle: TextStyle(
              color: Colors.white, fontFamily: 'headerfont', fontSize: 15),
          showCheckboxColumn: false,
          dataRowHeight: 20,
          headingRowColor:
              MaterialStateColor.resolveWith((states) => RomanColor),
          headingRowHeight: 20,
          horizontalMargin: 2,
          columns: <DataColumn>[
            DataColumn(
              label: Container(
                height: 100,
                width: 30,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      //                   <--- right side
                      color: Colors.black,
                      width: 1.0,
                    ),
                    bottom: BorderSide(
                      //                   <--- right side
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  color: RomanColor,
                ),
                child: Column(
                    children: [Text('V', style: TextStyle(fontSize: 16.0))]),
              ),
            ),
          ],
          rows: List.generate(
              list.length,
              (index) => DataRow(
                      onSelectChanged: (bool selected) {
                        if (selected) {
                          print('STATUS: ${list[index].toString()}--');
                          Navigator.of(context).push(
                            PageRouteBuilder(
                                pageBuilder: (context, _, __) => customAler(),
                                opaque: false),
                          );
                        }
                      },
                      cells: [
                        DataCell(Container(
                          height: 100,
                          width: 30,
                          decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  //                   <--- right side
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                                bottom: BorderSide(
                                  //                   <--- right side
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              color: ReColors().menubgdarkgreyColor),
                          child: Text('${list[index].toString()}',
                              
                              softWrap: false,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'headerfont',
                                    fontSize: 13)),
                        )),
                      ]))),
    ));
  }

  Widget tableVI(List<String> list) {
    return Container(
        /* decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                offset: Offset(1.0, 15.0),
                blurRadius: 20.0,
              ),
            ]),*/
        child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
          sortColumnIndex: 0,
          dividerThickness: 0,
          headingTextStyle: TextStyle(
              color: Colors.white, fontFamily: 'headerfont', fontSize: 15),
          showCheckboxColumn: false,
          dataRowHeight: 20,
          headingRowColor:
              MaterialStateColor.resolveWith((states) => RomanColor),
          headingRowHeight: 20,
          horizontalMargin: 2,
          columns: <DataColumn>[
            DataColumn(
              label: Container(
                height: 100,
                width: 30,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      //                   <--- right side
                      color: Colors.black,
                      width: 1.0,
                    ),
                    bottom: BorderSide(
                      //                   <--- right side
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  color: RomanColor,
                ),
                child: Column(
                    children: [Text('VI', style: TextStyle(fontSize: 16.0))]),
              ),
            ),
          ],
          rows: List.generate(
              list.length,
              (index) => DataRow(
                      onSelectChanged: (bool selected) {
                        if (selected) {
                          print('STATUS: ${list[index].toString()}--');
                          Navigator.of(context).push(
                            PageRouteBuilder(
                                pageBuilder: (context, _, __) => customAler(),
                                opaque: false),
                          );
                        }
                      },
                      cells: [
                        DataCell(Container(
                          height: 100,
                          width: 30,
                          decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  //                   <--- right side
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                                bottom: BorderSide(
                                  //                   <--- right side
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              color: ReColors().menubgdarkgreyColor),
                          child: Text('${list[index].toString()}',
                              
                              softWrap: false,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'headerfont',
                                  fontSize: 13)),
                        )),
                      ]))),
    ));
  }

  Widget tableVII(List<String> list) {
    return Container(
        /* decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: Colors.grey,
                offset: Offset(1.0, 15.0),
                blurRadius: 20.0,
              ),
            ]),*/
        child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
          sortColumnIndex: 0,
          dividerThickness: 0,
          headingTextStyle: TextStyle(
              color: Colors.white, fontFamily: 'headerfont', fontSize: 15),
          showCheckboxColumn: false,
          dataRowHeight: 20,
          headingRowColor:
              MaterialStateColor.resolveWith((states) => RomanColor),
          headingRowHeight: 20,
          horizontalMargin: 2,
          columns: <DataColumn>[
            DataColumn(
              label: Container(
                height: 100,
                width: 30,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      //                   <--- right side
                      color: Colors.black,
                      width: 1.0,
                    ),
                    bottom: BorderSide(
                      //                   <--- right side
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  color: RomanColor,
                ),
                child: Column(
                    children: [Text('VII', style: TextStyle(fontSize: 16.0))]),
              ),
            ),
          ],
          rows: List.generate(
              list.length,
              (index) => DataRow(
                      onSelectChanged: (bool selected) {
                        if (selected) {
                          print('STATUS: ${list[index].toString()}--');
                          Navigator.of(context).push(
                            PageRouteBuilder(
                                pageBuilder: (context, _, __) => customAler(),
                                opaque: false),
                          );
                        }
                      },
                      cells: [
                        DataCell(Container(
                          height: 100,
                          width: 30,
                          decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              color: ReColors().menubgdarkgreyColor),
                          child: Text('${list[index].toString()}',
                              
                              softWrap: false,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'headerfont',
                                    fontSize: 13)),
                        )),
                      ]))),
    ));
  }

  Widget tableVIII(List<String> list) {
    return Container(
        child: SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: DataTable(
          sortColumnIndex: 0,
          dividerThickness: 0,
          headingTextStyle: TextStyle(
              color: Colors.white, fontFamily: 'headerfont', fontSize: 15),
          showCheckboxColumn: false,
          dataRowHeight: 20,
          headingRowColor:
              MaterialStateColor.resolveWith((states) => RomanColor),
          headingRowHeight: 20,
          horizontalMargin: 2,
          columns: <DataColumn>[
            DataColumn(
              label: Container(
                height: 100,
                width: 30,
                decoration: BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      color: Colors.black,
                      width: 1.0,
                    ),
                    bottom: BorderSide(
                      //                   <--- right side
                      color: Colors.black,
                      width: 1.0,
                    ),
                  ),
                  color: RomanColor,
                ),
                child: Column(
                    children: [Text('VIII', style: TextStyle(fontSize: 16.0))]),
              ),
            ),
          ],
          rows: List.generate(
              list.length,
              (index) => DataRow(
                      onSelectChanged: (bool selected) {
                        if (selected) {
                          print('STATUS: ${list[index].toString()}--');
                          Navigator.of(context).push(
                            PageRouteBuilder(
                                pageBuilder: (context, _, __) => customAler(),
                                opaque: false),
                          );
                        }
                      },
                      cells: [
                        DataCell(Container(
                          height: 100,
                          width: 30,
                          decoration: BoxDecoration(
                              border: Border(
                                right: BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                                bottom: BorderSide(
                                  color: Colors.black,
                                  width: 1.0,
                                ),
                              ),
                              color: ReColors().menubgdarkgreyColor),
                          child: Text('${list[index].toString()}',
                              softWrap: false,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'headerfont',
                                    fontSize: 13)),
                        )),
                      ]))),
    ));
  }

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
          Title: 'WMS-AM5',
          image_bar: 'assets/images/wms_am5.png',
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
                                          'Yesterday Closing',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
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
                                      '0/0',
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
                                          'Today Closing',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
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
                                      '0/0',
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
                      Padding(padding: EdgeInsets.fromLTRB(0, 15, 0, 0)),
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
                                          'Today In',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
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
                                      '0/0',
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
                                          'Today Out',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16.0,
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
                                      '0/0',
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
                  //.................
                  warehouse_typesView(),
                  //..............
                  rackLabelvisibleContainer == false
                      ? Container()
                      : Warehouse_rack_listView(),

                  listviewVisible == false
                      ? Container()
                      : Container(
                          padding: EdgeInsets.all(10),
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
                          child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                table0(Warehouse_bin_type_0)

                                /*Container(
                                          child: Table(
                                            defaultColumnWidth:
                                                FixedColumnWidth(30.0),
                                            border: TableBorder.all(
                                                color: BackgroundColor,
                                                style: BorderStyle.solid,
                                                width: 2),
                                            children: Warehouse_bin_type_0,
                                          ),
                                        )*/
                                ,
                                /*Container(
                                          child: Table(
                                            defaultColumnWidth:
                                                FixedColumnWidth(30.0),
                                            border: TableBorder.all(
                                                color: BackgroundColor,
                                                style: BorderStyle.solid,
                                                width: 2),
                                            children: Warehouse_bin_type_I,
                                          ),
                                        )*/
                                tableI(Warehouse_bin_type_I),
                                tableII(Warehouse_bin_type_II),
                                tableIII(Warehouse_bin_type_III),
                                tableIV(Warehouse_bin_type_IV),
                                tableV(Warehouse_bin_type_V),
                                tableVI(Warehouse_bin_type_VI),
                                tableVII(Warehouse_bin_type_VII),
                                tableVIII(Warehouse_bin_type_VIII),
                                /* Container(
                                          child: Table(
                                            defaultColumnWidth:
                                                FixedColumnWidth(30.0),
                                            border: TableBorder.all(
                                                color: BackgroundColor,
                                                style: BorderStyle.solid,
                                                width: 2),
                                            children: Warehouse_bin_type_II,
                                          ),
                                        ),
                                        Container(
                                          child: Table(
                                            defaultColumnWidth:
                                                FixedColumnWidth(30.0),
                                            border: TableBorder.all(
                                                color: BackgroundColor,
                                                style: BorderStyle.solid,
                                                width: 2),
                                            children: Warehouse_bin_type_III,
                                          ),
                                        ),
                                        Container(
                                          child: Table(
                                            defaultColumnWidth:
                                                FixedColumnWidth(30.0),
                                            border: TableBorder.all(
                                                color: BackgroundColor,
                                                style: BorderStyle.solid,
                                                width: 2),
                                            children: Warehouse_bin_type_IV,
                                          ),
                                        ),*/
                                /*Container(
                                  child: Table(
                                    defaultColumnWidth:
                                    FixedColumnWidth(30.0),
                                    border: TableBorder.all(
                                        color: BackgroundColor,
                                        style: BorderStyle.solid,
                                        width: 2),
                                    children: Warehouse_bin_type_V,
                                  ),
                                ),
                                Container(
                                  child: Table(
                                    defaultColumnWidth:
                                    FixedColumnWidth(30.0),
                                    border: TableBorder.all(
                                        color: BackgroundColor,
                                        style: BorderStyle.solid,
                                        width: 2),
                                    children: Warehouse_bin_type_VI,
                                  ),
                                ),
                                Container(
                                  child: Table(
                                    defaultColumnWidth:
                                    FixedColumnWidth(30.0),
                                    border: TableBorder.all(
                                        color: BackgroundColor,
                                        style: BorderStyle.solid,
                                        width: 2),
                                    children: Warehouse_bin_type_VII,
                                  ),
                                ),
                                Container(
                                  child: Table(
                                    defaultColumnWidth:
                                    FixedColumnWidth(30.0),
                                    border: TableBorder.all(
                                        color: BackgroundColor,
                                        style: BorderStyle.solid,
                                        width: 2),
                                    children: Warehouse_bin_type_VIII,
                                  ),
                                ),*/
                              ]) /*Container(
                              padding: EdgeInsets.all(10),
                              child: Center(
                                  child: Column(
                                children: [
                                  Table(
                                    defaultColumnWidth: FixedColumnWidth(30.0),
                                    border: TableBorder.all(
                                        color: BackgroundColor,
                                        style: BorderStyle.solid,
                                        width: 2),
                                    children: [
                                      TableRow(children: [
                                        Container(
                                          color: RomanColor,
                                          child: Column(children: [
                                            Text('0',
                                                style:
                                                    TextStyle(fontSize: 16.0))
                                          ]),
                                        ),
                                        Container(
                                          color: RomanColor,
                                          child: Column(children: [
                                            Text('I',
                                                style:
                                                    TextStyle(fontSize: 16.0))
                                          ]),
                                        ),
                                        Container(
                                          color: RomanColor,
                                          child: Column(children: [
                                            Text('II',
                                                style:
                                                    TextStyle(fontSize: 16.0))
                                          ]),
                                        ),
                                        Container(
                                          color: RomanColor,
                                          child: Column(children: [
                                            Text('III',
                                                style:
                                                    TextStyle(fontSize: 16.0))
                                          ]),
                                        ),
                                        Container(
                                          color: RomanColor,
                                          child: Column(children: [
                                            Text('IV',
                                                style:
                                                    TextStyle(fontSize: 16.0))
                                          ]),
                                        ),
                                        Container(
                                          color: RomanColor,
                                          child: Column(children: [
                                            Text('V',
                                                style:
                                                    TextStyle(fontSize: 16.0))
                                          ]),
                                        ),
                                        Container(
                                          color: RomanColor,
                                          child: Column(children: [
                                            Text('VI',
                                                style:
                                                    TextStyle(fontSize: 16.0))
                                          ]),
                                        ),
                                        Container(
                                          color: RomanColor,
                                          child: Column(children: [
                                            Text('VII',
                                                style:
                                                    TextStyle(fontSize: 16.0))
                                          ]),
                                        ),
                                        Container(
                                          color: RomanColor,
                                          child: Column(children: [
                                            Text('VIII',
                                                style:
                                                    TextStyle(fontSize: 16.0))
                                          ]),
                                        ),
                                      ]),
                                    ],
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: <Widget>[
                                        table(Warehouse_bin_type_0)

                                        */ /*Container(
                                          child: Table(
                                            defaultColumnWidth:
                                                FixedColumnWidth(30.0),
                                            border: TableBorder.all(
                                                color: BackgroundColor,
                                                style: BorderStyle.solid,
                                                width: 2),
                                            children: Warehouse_bin_type_0,
                                          ),
                                        )*/ /*,
                                        */ /*Container(
                                          child: Table(
                                            defaultColumnWidth:
                                                FixedColumnWidth(30.0),
                                            border: TableBorder.all(
                                                color: BackgroundColor,
                                                style: BorderStyle.solid,
                                                width: 2),
                                            children: Warehouse_bin_type_I,
                                          ),
                                        )*/ /*
                                        table(Warehouse_bin_type_0),
                                        table(Warehouse_bin_type_0),
                                        table(Warehouse_bin_type_0),
                                       */ /* Container(
                                          child: Table(
                                            defaultColumnWidth:
                                                FixedColumnWidth(30.0),
                                            border: TableBorder.all(
                                                color: BackgroundColor,
                                                style: BorderStyle.solid,
                                                width: 2),
                                            children: Warehouse_bin_type_II,
                                          ),
                                        ),
                                        Container(
                                          child: Table(
                                            defaultColumnWidth:
                                                FixedColumnWidth(30.0),
                                            border: TableBorder.all(
                                                color: BackgroundColor,
                                                style: BorderStyle.solid,
                                                width: 2),
                                            children: Warehouse_bin_type_III,
                                          ),
                                        ),
                                        Container(
                                          child: Table(
                                            defaultColumnWidth:
                                                FixedColumnWidth(30.0),
                                            border: TableBorder.all(
                                                color: BackgroundColor,
                                                style: BorderStyle.solid,
                                                width: 2),
                                            children: Warehouse_bin_type_IV,
                                          ),
                                        ),*/ /*
                                        Container(
                                          child: Table(
                                            defaultColumnWidth:
                                                FixedColumnWidth(30.0),
                                            border: TableBorder.all(
                                                color: BackgroundColor,
                                                style: BorderStyle.solid,
                                                width: 2),
                                            children: Warehouse_bin_type_V,
                                          ),
                                        ),
                                        Container(
                                          child: Table(
                                            defaultColumnWidth:
                                                FixedColumnWidth(30.0),
                                            border: TableBorder.all(
                                                color: BackgroundColor,
                                                style: BorderStyle.solid,
                                                width: 2),
                                            children: Warehouse_bin_type_VI,
                                          ),
                                        ),
                                        Container(
                                          child: Table(
                                            defaultColumnWidth:
                                                FixedColumnWidth(30.0),
                                            border: TableBorder.all(
                                                color: BackgroundColor,
                                                style: BorderStyle.solid,
                                                width: 2),
                                            children: Warehouse_bin_type_VII,
                                          ),
                                        ),
                                        Container(
                                          child: Table(
                                            defaultColumnWidth:
                                                FixedColumnWidth(30.0),
                                            border: TableBorder.all(
                                                color: BackgroundColor,
                                                style: BorderStyle.solid,
                                                width: 2),
                                            children: Warehouse_bin_type_VIII,
                                          ),
                                        ),
                                      ])
                                ],
                              )))*/
                          ,
                        )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  customAler() {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      title: Align(
        alignment: Alignment.center,
        child: Row(
          children: [
            new Expanded(
              child: Text(
                'WareHouse',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ReColors().appMainColor,
                  fontSize: 17.0,
                  fontFamily: 'headingfont',
                ),
              ),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actions: <Widget>[
        FlatButton(
          child: const Text('CANCEL',
              style: TextStyle(
                color: Color(0xff055e8e),
                fontSize: 14.0,
                fontFamily: 'headingfont',
              )),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textColor: Theme.of(context).accentColor,
          onPressed: () {
            /*Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => MainMenuPopUp()),
            );*/
          },
        ),
        FlatButton(
          child: const Text('CREATE',
              style: TextStyle(
                color: Color(0xff055e8e),
                fontSize: 14.0,
                fontFamily: 'headingfont',
              )),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textColor: Theme.of(context).accentColor,
          onPressed: () {},
        ),
      ],
      content: StatefulBuilder(
        builder:
            (BuildContext context, void Function(void Function()) setState) {
          return SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        /*  new FutureBuilder<List<UnitItems>>(
                          future: GetJSON().getTicketUnit(getID),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return CustomDropdown(
                                dropdownMenuItemList: unitList.map((item) {
                                  return DropdownMenuItem(
                                    child:
                                    chip(item.companyname, Colors.grey),
                                    value: item.companyname,
                                  );
                                }).toList() ??
                                    [],
                                onChanged: (newVal) {
                                  setState(() {
                                    selectedSpinnerItem = newVal;
                                    deptVisible = true;
                                    GetJSON()
                                        .getTicketDept(spinnerId)
                                        .then((value) {
                                      deptList = value;
                                    });
                                  });
                                },
                                value: selectedSpinnerItem,
                                isEnabled: true,
                                color: ReColors().appMainColor,
                                hint: 'Brand',
                              ).build(context);
                            } else {
                              GetJSON().getTicketUnit(getID).then((unit) {
                                setState(() {
                                  unitList = unit;
                                  if (unitList.length == 0) {
                                  } else {
                                    spinnerId = unitList.first.companyid;
                                  }
                                });
                              });
                              return new CircularProgressIndicator();
                            }
                          },
                        ),*/
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
