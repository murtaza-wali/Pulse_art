import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

class Willpopwidget {
  @override
  getWillScope(Widget child) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top, SystemUiOverlay.bottom]);
    return WillPopScope(child: child, onWillPop: () => Future.value(false));
  }
}
