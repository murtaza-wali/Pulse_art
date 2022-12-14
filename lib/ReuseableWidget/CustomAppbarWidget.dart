import 'package:art/ReuseableValues/ReColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  VoidCallback onPressed;
  VoidCallback refreshonPressed;
  String Title;

  CustomAppBar({this.onPressed, this.Title, this.refreshonPressed});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        new Stack(
          alignment: Alignment.centerRight,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              onPressed: refreshonPressed,
            )
          ],
        )
      ],
      automaticallyImplyLeading: false,
      leading: BackButton(
        color: ReColors().appTextWhiteColor,
        onPressed: onPressed,
      ),
      title: new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            'assets/images/artlogo.png',
            fit: BoxFit.contain,
            height: 20,
          ),
          Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                Title,
                overflow: TextOverflow.ellipsis,

                softWrap: false,
                style: TextStyle( fontFamily: 'headerfont'),
              ))
        ],
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(30),
        ),
      ),
      // leading: Image.asset("assets/images/artlogo.png"),// hides default back button
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.topRight,
            colors: [ReColors().appMainColor, Colors.black],
          ),
        ),
      ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(60);
}
