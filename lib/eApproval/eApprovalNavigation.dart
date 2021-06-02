import 'package:art/HexCodeConverter/Hexcode.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/eApproval/WorklistAccess.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:foldable_sidebar/foldable_sidebar.dart';
import 'VacationRules.dart';
import 'eApprovalTabs.dart';

// ignore: camel_case_types
class eApprovalNav extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: eApprovalNavigation(),
      // home: FirstScreen(),
    );
  }
}

// ignore: camel_case_types
class eApprovalNavigation extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MyeApprovalNavigationState();
}

class _MyeApprovalNavigationState extends State<eApprovalNavigation> {
  FSBStatus drawerStatus;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FoldableSidebarBuilder(
          //drawerBackgroudcolor........
          drawerBackgroundColor: ReColors().appMainColor,
          drawer: CustomDrawer(closeDrawer: (){
            setState(() {
              drawerStatus = FSBStatus.FSB_CLOSE;
            });
          },),
          screenContents: Eapproval(),
          status: drawerStatus,
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ReColors().appMainColor,
            child: Icon(Icons.menu,color: Colors.white,),
            onPressed: () {
              setState(() {
                drawerStatus = drawerStatus == FSBStatus.FSB_OPEN ? FSBStatus.FSB_CLOSE : FSBStatus.FSB_OPEN;
              });
            }),
      ),
    );
  }
}


class CustomDrawer extends StatelessWidget {

  final Function closeDrawer;

  const CustomDrawer({Key key,  this.closeDrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      color: Colors.white,
      width: mediaQuery.size.width * 0.70,
      height: mediaQuery.size.height,
      child: Column(
        children: <Widget>[
          Container(
              width: double.infinity,
              height: 200,
              color: Colors.grey.withAlpha(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Image.asset(
                    "assets/images/eapprovals.png",
                    width: 100,
                    height: 100,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text("E-Approval")
                ],
              )),
          ListTile(
            onTap: (){
              debugPrint("Tapped Profile");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => VacationRules()),
              );
            },
            leading: Icon(Icons.rule),
            title: Text(
              "Vacation Rules",
            ),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              debugPrint("Tapped settings");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WorklistAccess()),
              );
            },
            leading: Icon(Icons.workspaces_filled),
            title: Text("Worklist Access"),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),

        ],
      ),
    );
  }
}