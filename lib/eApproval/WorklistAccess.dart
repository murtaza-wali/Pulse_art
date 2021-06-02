import 'package:art/HexCodeConverter/Hexcode.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/appbar.dart';
import 'package:art/eApproval/CustomDropdown.dart';
import 'package:art/eApproval/GrantAccessToModel.dart';
import 'package:art/eApproval/GrantAcessItem.dart';
import 'package:art/eApproval/SelectedGrantAccessModel.dart';
import 'package:art/eApproval/WorklistNameModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class WorklistAccess extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _WorklistState();
}

class _WorklistState extends State<WorklistAccess> {
  Color color2 = HexColor("#055e8e");
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
                primary: color2,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: color2,
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
                primary: color2,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: color2,
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
    _dateController.text = 'Start Date';
    // _dateController.text = DateFormat.yMd().format(DateTime.now());
    // _enddateController.text = DateFormat.yMd().format(DateTime.now());
    _enddateController.text = 'End Date';
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
    return color2;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: new ReusableWidgets().getAppBar('Worklist Access'),
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
                        color: color2,
                      ),
                    ),
                  ],
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: "Description",
                    labelStyle: TextStyle(color: color2),
                    fillColor: color2,
                    enabledBorder: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(25.0),
                      borderSide: BorderSide(color: color2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Color(0x055e8e), width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: color2)),
                  ),
                  maxLines: 5,
                  controller: descriptionTextController,
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
                          color: color2,
                        ),
                        hintText: 'Start Date',
                        hintStyle: TextStyle(color: color2),
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
                        prefixIcon:
                            Icon(Icons.calendar_today_sharp, color: color2),
                        hintText: 'End Date',
                        hintStyle: TextStyle(color: color2),
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
                          splashColor: color2,
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
                          child: new RadioItem(sampleData[index], color2),
                        );
                      },
                    )),
                  ],
                ),
              ),
              actionButton(color2)
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
              title: Text('Phone Ringtone'),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context, null);
                  },
                  child: Text('CANCEL'),
                ),
                FlatButton(
                  onPressed: () {
                    var _currentIndex;
                    Navigator.pop(
                        context, checkBoxListTileModel[_currentIndex]);
                  },
                  child: Text('OK'),
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
                        activeColor: Colors.pink[300],
                        dense: true,
                        //font change
                        title: new Text(
                          checkBoxListTileModel[index].title,
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.5),
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

Widget actionButton(Color color2) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      RaisedButton(
        color: color2,
        child: Text(
          "Apply",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () => onVerifyClick(),
      ),
      SizedBox(
        width: 20.0,
      ),
      RaisedButton(
        color: color2,
        child: Text(
          "Cancel",
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () => onNextClick(),
      ),
    ],
  );
}

onVerifyClick() {}

onNextClick() {}