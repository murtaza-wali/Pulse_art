import 'package:art/ReuseableValues/ReColors.dart';
import 'package:flutter/material.dart';

class Dropdown extends StatefulWidget {
  final String _key;
  final List<String> _values;
  final Function update; // Add this line.

  Dropdown(this._key, this._values, {this.update = null}); // Fix this line.

  @override
  _DropdownState createState() => _DropdownState();
}

class _DropdownState extends State<Dropdown> {
  var _chosenValue;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
        child: Container(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              border: Border.all(
                color: ReColors().appMainColor,
                width: 1,
              ),
              color: ReColors().appTextWhiteColor),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              hint: Text(
                widget._key,
                style: TextStyle(color: ReColors().appMainColor),
              ),
              icon: Icon(
                Icons.arrow_drop_down,
                color: ReColors().appMainColor,
              ),
              iconSize: 24,
              isExpanded: true,
              items:
                  widget._values.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: ReColors().appMainColor),
                  ),
                );
              }).toList(),
              onChanged: (String value) {
                // Fix start.
                setState(() {
                  _chosenValue = value;
                  print('_chosenValue: ${_chosenValue}');
                }); // Fix end.
              },
              style: TextStyle(
                  fontFamily: 'headingfont',
                  fontSize: 15.0,
                  color: ReColors().appMainColor),
              value: _chosenValue,
            ),
          ),
        ));
  }
}
