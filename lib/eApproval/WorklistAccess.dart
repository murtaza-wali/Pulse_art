import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableValues/ReStrings.dart';
import 'package:art/ReuseableWidget/ReuseButton.dart';
import 'package:art/ReuseableWidget/appbar.dart';
import 'package:art/eApproval/CustomDropdown.dart';
import 'package:art/eApproval/GrantAccessToModel.dart';
import 'package:art/eApproval/GrantAcessItem.dart';
import 'package:art/eApproval/SelectedGrantAccessModel.dart';
import 'package:art/eApproval/WorklistNameModel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorklistAccess extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WorklistState();
}

class _WorklistState extends State<WorklistAccess> {
  double _height;
  double _width;

  String _setendDate, _setDate;

  String _hour, _minute, _time;

  String dateTime;

  DateTime selectedDate = DateTime.now();
  DateTime endselectedDate = DateTime.now();

  TextEditingController _dateController = TextEditingController();
  TextEditingController _enddateController = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: ReColors().appMainColor,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: ReColors().appMainColor,
              ),
              dialogBackgroundColor: ReColors().appTextWhiteColor,
            ),
            child: child,
          );
        },
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  List<CheckBoxListTileModel> checkBoxListTileModel =
      CheckBoxListTileModel.getUsers();

  Future<Null> _selectendDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: endselectedDate,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: ReColors().appMainColor,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: ReColors().appMainColor,
              ),
              dialogBackgroundColor: ReColors().appTextWhiteColor,
            ),
            child: child,
          );
        },
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        endselectedDate = picked;
        _enddateController.text = DateFormat.yMd().format(endselectedDate);
      });
  }

  var descriptionTextController = TextEditingController();
  List<GrantAcessModel> sampleData = new List<GrantAcessModel>();
  worklistnameModel _worklistnameModel = worklistnameModel();
  final List<worklistnameModel> _worklistnameModelList = [
    worklistnameModel(worklistName: 'All Employees and users'),
    worklistnameModel(worklistName: 'Employee'),
    worklistnameModel(worklistName: 'Oracle Application User'),
    worklistnameModel(worklistName: 'public Sector Employee'),
  ];
  List<DropdownMenuItem<worklistnameModel>> _worklistnameModelDropdownList;

  List<DropdownMenuItem<worklistnameModel>> _buildworklistnameModelDropdown(
      List worklistnameModelList) {
    List<DropdownMenuItem<worklistnameModel>> items = List();
    for (worklistnameModel WorklistnameModel in worklistnameModelList) {
      items.add(DropdownMenuItem(
        value: WorklistnameModel,
        child: Text(WorklistnameModel.worklistName),
      ));
    }
    return items;
  }

  _onChangeworklistnameModelDropdown(worklistnameModel worklistnameModel) {
    setState(() {
      _worklistnameModel = worklistnameModel;
    });
  }

  @override
  void initState() {
    sampleData.add(new GrantAcessModel(false, 'All Item Types'));
    sampleData.add(new GrantAcessModel(false, 'Selected Item Types'));
    // descriptionTextController = TextEditingController();
    _dateController.text = appstring().startdate;
    // _dateController.text = DateFormat.yMd().format(DateTime.now());
    // _enddateController.text = DateFormat.yMd().format(DateTime.now());
    _enddateController.text = appstring().enddate;
    _worklistnameModelDropdownList =
        _buildworklistnameModelDropdown(_worklistnameModelList);
    _worklistnameModel = _worklistnameModelList[0];
    super.initState();
  }

  Color getColor(Set<MaterialState> states) {
    const Set<MaterialState> interactiveStates = <MaterialState>{
      MaterialState.pressed,
      MaterialState.hovered,
      MaterialState.focused,
    };
    if (states.any(interactiveStates.contains)) {
      return Colors.white;
    }
    return ReColors().appMainColor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: new ReusableWidgets().getAppBar(context,'Worklist Access'),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              new Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: const SizedBox(
                        width: double.infinity,
                        child: Text('Name:'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20.0, vertical: 10.0),
                      child: CustomDropdown(
                        dropdownMenuItemList: _worklistnameModelDropdownList,
                        onChanged: _onChangeworklistnameModelDropdown,
                        value: _worklistnameModel,
                        isEnabled: true,
                        color: ReColors().appMainColor,
                      ),
                    ),
                  ],
                ),
              ),
              new Container(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: appstring().description,
                      labelStyle: TextStyle(color: ReColors().appMainColor),
                      fillColor: ReColors().appMainColor,
                      enabledBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: ReColors().appMainColor),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: ReColors().appMainColor, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: ReColors().appMainColor)),
                    ),
                    maxLines: 5,
                    controller: descriptionTextController,
                  ),
                ),
              ),
              new InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: Container(
                    width: 320,
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _dateController,
                      onSaved: (String val) {
                        _setDate = val;
                      },
                      autocorrect: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.calendar_today_sharp,
                          color: ReColors().appMainColor,
                        ),
                        hintText: appstring().startdate,
                        hintStyle: TextStyle(color: ReColors().appMainColor),
                        fillColor: Colors.white70,
                      ),
                    )),
              ),
              new InkWell(
                onTap: () {
                  _selectendDate(context);
                },
                child: Container(
                    width: 320,
                    padding: EdgeInsets.all(10.0),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      enabled: false,
                      keyboardType: TextInputType.text,
                      controller: _enddateController,
                      onSaved: (String val) {
                        _setendDate = val;
                      },
                      autocorrect: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.calendar_today_sharp,
                            color: ReColors().appMainColor),
                        hintText: appstring().enddate,
                        hintStyle: TextStyle(color: ReColors().appMainColor),
                      ),
                    )),
              ),
              new Container(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  children: [
                    new Container(
                      margin: new EdgeInsets.only(left: 10.0),
                      child: new Text('Grant Access to: '),
                    ),
                    new Expanded(
                        child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: sampleData.length,
                      itemBuilder: (BuildContext context, int index) {
                        return new InkWell(
                          //highlightColor: Colors.red,
                          splashColor: ReColors().appMainColor,
                          onTap: () {
                            setState(() {
                              sampleData.forEach(
                                  (element) => element.isSelected = false);
                              sampleData[index].isSelected = true;
                              print(
                                  sampleData[index].text.contains('Selected'));
                              if (sampleData[index].text.contains('Selected')) {
                                _selectRingtone(context, checkBoxListTileModel);
                              }
                            });
                          },
                          child: new RadioItem(
                              sampleData[index], ReColors().appMainColor),
                        );
                      },
                    )),
                  ],
                ),
              ),
              actionButton()
            ],
          ),
        ));
  }

  void itemChange(bool val, int index) {
    setState(() {
      checkBoxListTileModel[index].isCheck = val;
    });
  }
}

Future<String> _selectRingtone(BuildContext context,
    List<CheckBoxListTileModel> checkBoxListTileModel) async {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState2) {
            return AlertDialog(
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context, null);
                  },
                  child: Text(appstring().cancel),
                ),
                FlatButton(
                  onPressed: () {
                    var _currentIndex;
                    Navigator.pop(context, null);
                  },
                  child: Text(appstring().ok),
                ),
              ],
              content: Container(
                width: double.minPositive,
                height: 300,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: checkBoxListTileModel.length,
                  itemBuilder: (BuildContext context, int index) {
                    return new CheckboxListTile(
                        activeColor: ReColors().appMainColor,
                        dense: true,
                        //font change
                        title: new Text(
                          checkBoxListTileModel[index].title,
                          style: TextStyle(fontSize: 14, letterSpacing: 0.5),
                        ),
                        value: checkBoxListTileModel[index].isCheck,
                        /*secondary: Container(
                          height: 50,
                          width: 50,
                          child: Image.asset(
                            checkBoxListTileModel[index].img,
                            fit: BoxFit.cover,
                          ),
                        ),*/
                        onChanged: (bool val) {
                          setState2(() {
                            checkBoxListTileModel[index].isCheck = val;
                          });
                        });
                  },
                ),
              ),
            );
          },
        );
      });
}

Widget actionButton() {
  return ReuseTwoButton(
    firstbuttonText: appstring().apply,
    secondbuttonText: appstring().cancel,
    firstonPressed: null,
    secondonPressed: null,
  );
}

onVerifyClick() {}

onNextClick() {}
