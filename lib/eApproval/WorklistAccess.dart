import 'package:art/HexCodeConverter/Hexcode.dart';
import 'package:art/ReuseableWidget/appbar.dart';
import 'package:date_format/date_format.dart';
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
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> _selectendDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: endselectedDate,
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
  List<RadioModel> sampleData = new List<RadioModel>();
  final List<worklistnameModel> _worklistnameModelList = [
    worklistnameModel(worklistName: 'All Employees and users'),
    worklistnameModel(worklistName: 'Employee'),
    worklistnameModel(worklistName: 'Oracle Application User'),
    worklistnameModel(worklistName: 'public Sector Employee'),
  ];
  worklistnameModel _worklistnameModel = worklistnameModel();
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
    sampleData.add(new RadioModel(false, 'All Item Types'));
    sampleData.add(new RadioModel(false, 'Selected Item Types'));
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
                      borderSide: const BorderSide(color: Color(0x055e8e), width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    border:
                    OutlineInputBorder(borderSide: BorderSide(color: color2)),
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
                        prefixIcon: Icon(Icons.calendar_today_sharp,color: color2,),
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
                        prefixIcon: Icon(Icons.calendar_today_sharp,color: color2),
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
                            });
                          },
                          child: new RadioItem(sampleData[index],color2),
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

class RadioModel {
  bool isSelected;
  final String text;

  RadioModel(this.isSelected, this.text);
}

class RadioItem extends StatelessWidget {
  final RadioModel _item;
  Color color;

  RadioItem(this._item, this.color);

  @override
  Widget build(BuildContext context) {
    return new Container(
      margin: new EdgeInsets.all(15.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          new Container(
            height: 20.0,
            width: 20.0,
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              color: _item.isSelected ? color : Colors.transparent,
              border: new Border.all(
                  width: 1.0,
                  color: _item.isSelected ? color : Colors.grey),
              // borderRadius: const BorderRadius.all(const Radius.circular(2.0)),
            ),
          ),
          new Container(
            margin: new EdgeInsets.only(left: 10.0),
            child: new Text(_item.text),
          )
        ],
      ),
    );
  }
}

class worklistnameModel {
  final String worklistName;

  worklistnameModel({
    this.worklistName,
  });
}

class CustomDropdown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> dropdownMenuItemList;
  final ValueChanged<T> onChanged;
  final T value;
  final bool isEnabled;
  final Color color;

  CustomDropdown({
    Key key,
    this.dropdownMenuItemList,
    this.onChanged,
    @required this.value,
    this.isEnabled = true,
    this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: !isEnabled,
      child: Container(
        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(10.0)),
            border: Border.all(
              color: color,
              width: 1,
            ),
            color: isEnabled ? Colors.white : Colors.grey.withAlpha(100)),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            isExpanded: true,
            itemHeight: 50.0,
            style: TextStyle(
                fontSize: 15.0, color: isEnabled ? color : Colors.grey[700]),
            items: dropdownMenuItemList,
            onChanged: onChanged,
            value: value,
          ),
        ),
      ),
    );
  }
}
