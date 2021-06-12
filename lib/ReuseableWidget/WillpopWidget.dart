import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class Willpopwidget {
  @override
  getWillScope(Widget child) {
    SystemChrome.setEnabledSystemUIOverlays([]);
    return WillPopScope(child: child, onWillPop: () => Future.value(false));
  }
}
