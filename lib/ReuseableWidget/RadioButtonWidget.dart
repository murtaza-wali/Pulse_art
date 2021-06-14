import 'package:art/Model/GrantAccessToModel.dart';
import 'package:flutter/material.dart';

class RadioItem extends StatelessWidget {
  final GrantAcessModel _item;
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
                  width: 1.0, color: _item.isSelected ? color : Colors.grey),
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