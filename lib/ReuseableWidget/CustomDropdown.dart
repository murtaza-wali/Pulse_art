import 'package:flutter/material.dart';

class CustomDropdown<T> extends StatelessWidget {
  final List<DropdownMenuItem<T>> dropdownMenuItemList;
  final ValueChanged<T> onChanged;
  final T value;
  final String hint;
  final bool isEnabled;
  final Color color;

  CustomDropdown({
    Key key,
    this.dropdownMenuItemList,
    this.onChanged,
    @required this.value,
    @required this.hint,
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
              fontFamily: 'headingfont',
                fontSize: 15.0, color: isEnabled ? color : Colors.grey[700]),
            items: dropdownMenuItemList,
            onChanged: onChanged,
            hint: Text(hint,style:  TextStyle(
                color: Color(0xff055e8e), fontFamily: 'headingfont'),),
            value: value,
          ),
        ),
      ),
    );
  }
}
