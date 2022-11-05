import 'package:art/ReuseableValues/ReColors.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'ArticleCosting.dart';
import 'CostingRequest/CostingRequestList.dart';

class FabricCostingBottomNavBar extends StatefulWidget {
  FabricCostingBottomNavBar({Key key, this.Employeekey}) : super(key: key);
  String Employeekey;

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<FabricCostingBottomNavBar> {
  GlobalKey _bottomNavigationKey = GlobalKey();
  final CostingRequest = new CostingRequestList();
  final articleCosting = new ArticleCosting();
  Widget homeShow = CostingRequestList();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget _pageChooser(int page) {
    switch (page) {
      case 0:
        return CostingRequest;
        break;
      case 1:
        return articleCosting;
        break;
      default:
        return homeShow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: CurvedNavigationBar(
          key: _bottomNavigationKey,
          index: 0,
          height: 50.0,
          items: <Widget>[
            FaIcon(
              FontAwesomeIcons.envelopeOpen,
              color: Colors.white,
              size: 25,
            ),
            Icon(
              Icons.article,
              size: 25,
              color: Colors.white,
            ),
          ],
          color: ReColors().appMainColor,
          buttonBackgroundColor: ReColors().appMainColor,
          backgroundColor: ReColors().appTextWhiteColor,
          animationCurve: Curves.easeInOut,
          animationDuration: Duration(milliseconds: 600),
          onTap: (index) {
            setState(() {
              homeShow = _pageChooser(index);
              // _page = index;
            });
          },
          letIndexChange: (index) => true,
        ),
        body: Container(
          color: Colors.transparent,
          child: Center(
            child: homeShow,
          ),
        ));
  }
}
