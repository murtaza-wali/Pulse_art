import 'package:art/ReuseableValues/ReColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomAppBarDrawer extends StatelessWidget implements PreferredSizeWidget{
  VoidCallback onPressed;
  VoidCallback refreshonPressed;
  String Title;
  String image_bar;

  CustomAppBarDrawer({this.onPressed, this.Title,this.refreshonPressed,this.image_bar});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: [
        new Stack(
          alignment: Alignment.centerRight,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.menu),
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
            image_bar,
            fit: BoxFit.contain,
            height: 40,
          ),
          Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(Title,style: TextStyle(fontFamily: 'headerfont',fontSize: 16),))
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
