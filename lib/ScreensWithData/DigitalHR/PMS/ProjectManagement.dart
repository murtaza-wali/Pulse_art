import 'package:art/ReuseableWidget/CustomAppbarWidget.dart';
import 'package:art/ReuseableWidget/CustomAppbarWithImage.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:art/ScreensWithData/Menu/MainMenuPopup.dart';
import 'package:flutter/material.dart';

class ProjectManagement extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProjectManagementState();
}

class _ProjectManagementState extends State<ProjectManagement> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
          Title: 'Digital HR',
          image_bar: 'assets/images/hrms_logo2.png',
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(5),
          ),
        ),
      ),
    );
  }
}

/**/
