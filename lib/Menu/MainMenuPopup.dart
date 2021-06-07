import 'package:art/HexCodeConverter/Hexcode.dart';
import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/LoginForm/Login.dart';
import 'package:art/PopMenuDir/popup_menu.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:flutter/material.dart';
import 'package:art/Gatepass/GatepassMenu.dart';
import 'package:art/InternetConnection/Offline.dart';
import 'package:art/Model/LoginAuthenticationModel.dart';
import 'package:art/Model/MenuCardsModel.dart';
import 'package:art/eApproval/eApprovalNavigation.dart';

class MainMenuPopUp extends StatefulWidget {
  @override
  _MainMenuPopUpState createState() => _MainMenuPopUpState();
}

int getID;

class _MainMenuPopUpState extends State<MainMenuPopUp> {
  PopupMenu menu;
  GlobalKey btnKey2 = GlobalKey();
  int counter = 10;
  Color color2 = HexColor("#055e8e");
  String username;

  List<CardsMenuItem> menuListData = [];

  @override
  void initState() {
    super.initState();
    MySharedPreferences.instance
        .getIntValue("UserId")
        .then((value) => setState(() {
              getID = value;
              print(getID);
              MenuCard().getMenus(getID).then((users) {
                setState(() {
                  //list of user
                  menuListData = users;
                });
              });
            }));

    MySharedPreferences.instance
        .getStringValue("Username")
        .then((name) => setState(() {
              username = name;
              print(username);
            }));
  }

  void stateChanged(bool isShow) {
    print('menu is ${isShow ? 'showing' : 'closed'}');
  }

  void onClickMenu(MenuItemProvider item) {
    print('Click menu -> ${item.menuTitle}');
    if (item.menuTitle.contains('Sign Out')) {
      MySharedPreferences.instance.removeAll();
      // Menu Item Conditions.....
      // pushAndRemoveUntil -> pushAndRemoveUntil
      // pushAndRemoveUntil -> pushReplacement-> crash app
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => Login()),
          (Route<dynamic> route) => false);
    }
  }

  void onDismiss() {
    print('Menu is dismiss');
  }

  Future<bool> _onWillPop() {
    return showDialog(
          builder: (context) => new AlertDialog(
            title: new Text('Logout'),
            content: new Text('Are you sure you want to log out? '),
            actions: <Widget>[
              new FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: new Text('No'),
              ),
              new FlatButton(
                onPressed: () {
                  MySharedPreferences.instance.removeAll();
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => Login()),
                      (Route<dynamic> route) => false);
                  /*Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Login()),
                  );*/
                },
                child: new Text('Yes'),
              ),
            ],
          ),
          context: context,
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    PopupMenu.context = context;
    return WillPopScope(
        child: Scaffold(
          appBar: AppBar(
            title: new Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/artlogo.png',
                  fit: BoxFit.contain,
                  height: 20,
                ),
                Container(
                    padding: const EdgeInsets.all(8.0), child: Text('Menu'))
              ],
            ),
            actions: <Widget>[
              new Stack(
                alignment: Alignment.centerRight,
                children: <Widget>[
                  IconButton(
                    key: btnKey2,
                    icon: Icon(Icons.person),
                    onPressed: () {
                      maxColumn();
                    },
                  )
                ],
              ),
              new Stack(
                alignment: Alignment.centerRight,
                children: <Widget>[
                  new IconButton(
                      icon: Icon(Icons.notifications),
                      onPressed: () {
                        setState(() {
                          counter = 0;
                        });
                      }),
                  counter != 0
                      ? new Positioned(
                          right: 11,
                          top: 11,
                          child: new Container(
                            padding: EdgeInsets.all(2),
                            decoration: new BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            constraints: BoxConstraints(
                              minWidth: 14,
                              minHeight: 14,
                            ),
                            child: Text(
                              '$counter',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : new Container()
                ],
              ),
            ],

            automaticallyImplyLeading: false, // hides default back button
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [color2, Colors.black],
                ),
              ),
            ),
          ),
          body: ReuseOffline().getoffline(FutureBuilder<List<CardsMenuItem>>(
            future: MenuCard().getMenus(getID),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                menuListData = snapshot.data;
                return gridMenuData(menuListData);
              } else if (snapshot.hasError) {
                return Text("${snapshot.error}");
              }
              return Center(
                  child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(ReColors().appMainColor),
              ));
            },
          )),
        ),
        onWillPop: () => Future.value(false));
  }

  void checkState(BuildContext context) {
    final snackBar = new SnackBar(content: new Text('这是一个SnackBar!'));

    Scaffold.of(context).showSnackBar(snackBar);
  }

  Column gridMenuData(menuList) {
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10),
          child: Text(
            'Welcome to $username',
            style: TextStyle(
              color: ReColors().appMainColor,
              fontSize: 20, // light
              fontWeight: FontWeight.bold, // italic
            ),
          ),
        ),
        Expanded(
            child: GridView.count(
          // Create a grid with 2 columns. If you change the scrollDirection to
          // horizontal, this would produce 2 rows.
          crossAxisCount: 2,
          // Generate 100 Widgets that display their index in the List
          children:
              List.generate(null == menuList ? 0 : menuList.length, (index) {
            return Container(
              child: InkWell(
                onTap: () {
                  print(menuList[index].applicationId);
                  // ignore: unrelated_type_equality_checks
                  Colors.white;
                  if (menuList[index].applicationId == 403) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => eApprovalNavigation()),
                    );
                  } else if (menuList[index].applicationName == 'GatePass') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Gatepass()),
                    );
                  }
                },
                child: Card(
                  // semanticContainer: true,
                  // yeh shadow dekhata hai
                  // clipBehavior: Clip.antiAlias,

                  child: Container(
                    decoration: BoxDecoration(
                      // border: Border.all(color: Color(0xff940D5A)),
                      gradient: LinearGradient(
                        begin: Alignment(-0.6, -1),
                        end: Alignment(-1, -0),
                        colors: [Colors.black, color2],
                      ),
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(17.0),
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1.0, 15.0),
                          blurRadius: 20.0,
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          child: Center(
                            child: Image(
                              width: 100,
                              height: 100,
                              image: NetworkImage(menuList[index].logo),
                            ),
                          ),
                        ),
                        Text(
                          menuList[index].applicationName,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.0,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(17.0),
                  ),
                  elevation: 5,
                  margin: EdgeInsets.all(10),
                ),
              ),
            );
          }),
        )),
      ],
    );
  }

  void maxColumn() {
    PopupMenu menu = PopupMenu(
        // backgroundColor: Colors.teal,
        // lineColor: Colors.tealAccent,
        maxColumn: 2,
        items: [
          MenuItem(
              title: 'Self service',
              image: Image.asset('assets/images/gatekeep_logo.png')),
          MenuItem(
              title: 'Sign Out',
              image: Icon(
                Icons.power_settings_new,
                color: Colors.white,
              )),
        ],
        onClickMenu: onClickMenu,
        stateChanged: stateChanged,
        onDismiss: onDismiss);
    menu.show(widgetKey: btnKey2);
  }
}
