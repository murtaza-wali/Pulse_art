import 'dart:io';
import 'dart:math';

import 'package:art/Error/Error.dart';
import 'package:art/HexCodeConverter/Hexcode.dart';
import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/Model/ApkItem.dart';
import 'package:art/Model/Count.dart';
import 'package:art/ParsingJSON/GetJSONMethod.dart';
import 'package:art/Permission/StoragePermission.dart';
import 'package:art/ScreensWithData/EApprovalScreens/EapprovalByUserID.dart';
import 'package:art/ScreensWithData/LoginScreen/Login.dart';
import 'package:art/PopMenuDir/popup_menu.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/GradientBG.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:art/Selfservice/UserProfile.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:art/InternetConnection/Offline.dart';
import 'package:art/Model/MenuCardsModel.dart';
import 'package:flutter/services.dart';
import 'package:get_version/get_version.dart';
import 'package:open_file/open_file.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

/*if you change version code you should run pub get and pub upgrade commands*/
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
  List<Totalcount> countList = [];

  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();

  final apkUrl =
      "https://artlive.artisticmilliners.com:8081/ords/art/apis/apk/";
  bool downloading = false;
  var progressString = "";
  List<ApkItem> list = [];
  String uploadversionCode;
  String message;
  String totalpercentage = "";
  bool downloadbtn = false;
  ProgressDialog progressDialog;
  var dir;
  PermissionName permissionName = PermissionName.Storage;

  requestPermissions() async {
    List<PermissionName> permissionNames = [];
    permissionNames.add(PermissionName.Storage);
    permissionNames.add(PermissionName.Internet);
    message = '';
    var permissions = await Permission.requestPermissions(permissionNames);
    permissions.forEach((permission) {
      message +=
          '${permission.permissionName}: ${permission.permissionStatus}\n';
      print('Message: ${message}');
    });
    setState(() {
      message;
    });
  }

  int click;
  String _platformVersion = 'Unknown';
  String _projectVersion = '';
  String _projectCode = '';
  String _projectAppID = '';
  String _projectName = '';

  @override
  void initState() {
    super.initState();
    progressDialog = new ProgressDialog(context);
    requestPermissions();
    MySharedPreferences.instance
        .getIntValue("UserId")
        .then((value) => setState(() {
              getID = value;
              print(getID);
              GetJSON().getMenus(getID).then((users) {
                setState(() {
                  //list of user
                  menuListData = users;
                });
              });
              GetJSON().getTotalCount(getID).then((count) {
                setState(() {
                  //list of user
                  countList = count;
                });
              });
            }));

    MySharedPreferences.instance
        .getStringValue("Username")
        .then((name) => setState(() {
              username = name;
              print(username);
            }));
    GetJSON().getApkVersion().then((value) {
      list = value;
      uploadversionCode = list.first.versionCode;
      initPlatformState().then((value) {
        _projectCode = value;
        print('uploadversionCode1: ${uploadversionCode}');
        print('mobileversionCode1: ${_projectCode}');
        if (int.parse(uploadversionCode) > int.parse(_projectCode)) {
          confirmationPopup(
              context,
              'Update is ready',
              'Please update you app for getting new features and bugfixes.',
              'OK');
        }
      });
    });

    createFolder().then((value) {
      dir = value;
      print('dir: ${dir}');
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await GetVersion.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    String projectVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectVersion = await GetVersion.projectVersion;
    } on PlatformException {
      projectVersion = 'Failed to get project version.';
    }

    String projectCode;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectCode = await GetVersion.projectCode;
    } on PlatformException {
      projectCode = 'Failed to get build number.';
    }

    String projectAppID;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectAppID = await GetVersion.appID;
    } on PlatformException {
      projectAppID = 'Failed to get app ID.';
    }

    String projectName;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      projectName = await GetVersion.appName;
    } on PlatformException {
      projectName = 'Failed to get app name.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
      _projectVersion = projectVersion;
      _projectCode = projectCode;
      _projectAppID = projectAppID;
      _projectName = projectName;
    });
    return projectCode;
  }

  Future<void> deleteFile(File file) async {
    try {
      if (await file.exists()) {
        if (file.path.contains('pulse')) await file.delete();
      }
    } catch (e) {
      // Error in getting access to the file.
    }
  }

  Future<String> createFolder() async {
    final path = Directory("storage/emulated/0/Download");
    print('path : ${path}');
    if ((await path.exists())) {
      return path.path;
    } else {
      path.create();
      print('path.path1 : ${path.path}');
      return path.path;
    }
  }

  File file;
  String valueOfTotal;

  Future<void> downloadFile() async {
    Dio dio = Dio();
    try {
      file = new File("${dir}/pulse${_projectCode}.apk");
      deleteFile(File(file.absolute.path));
      await dio.download(apkUrl, '${dir}/pulse${uploadversionCode}.apk',
          onReceiveProgress: (rec, total) {
        print('Rec: $rec , Total: $total');
        total = 23100681;
        setState(() {
          downloading = true;
          progressString = ((rec / total) * 100).toStringAsFixed(0) + '%';
        });
      });
    } catch (e) {
      print(e);
    }
    setState(() {
      downloading = false;
      progressString = 'Completed';
    });
    OpenFile.open("${dir}/pulse${uploadversionCode}.apk");
    print('Download completed');
  }

  void stateChanged(bool isShow) {
    print('menu is ${isShow ? 'showing' : 'closed'}');
  }

  Future<dynamic> _refreshMenu() async {
    print('GET ID : ${getID}');
    return await GetJSON().getMenus(getID);
  }

  Future<dynamic> _refreshCount() async {
    print('GET ID : ${getID}');
    return await GetJSON().getTotalCount(getID);
    ;
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
    } else if (item.menuTitle.contains('Self service')) {
      // MySharedPreferences.instance.removeAll();
      // Menu Item Conditions.....
      // pushAndRemoveUntil -> pushAndRemoveUntil
      // pushAndRemoveUntil -> pushReplacement-> crash app
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => UserProfile()),
          (Route<dynamic> route) => false);
    }
  }

  void onDismiss() {
    print('Menu is dismiss');
  }

  @override
  Widget build(BuildContext context) {
    PopupMenu.context = context;
    return Willpopwidget().getWillScope(Scaffold(
      appBar: AppBar(
        title: new Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/artlogo.png',
              fit: BoxFit.contain,
              height: 20,
            ),
            Container(padding: const EdgeInsets.all(8.0), child: Text('Menu'))
          ],
        ),
        actions: <Widget>[
          new Stack(
            alignment: Alignment.centerRight,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  _refreshMenu().then((list) => setState(() {
                        menuListData = list;
                        print(menuListData.length);
                      }));
                  _refreshCount().then((list) => setState(() {
                        countList = list;
                        print(countList.length);
                      }));
                },
              )
            ],
          ),
          new Stack(
            alignment: Alignment.centerRight,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.download_sharp),
                color: Colors.white,
                onPressed: () {
                  GetJSON().getApkVersion().then((value) {
                    list = value;
                    uploadversionCode = list.first.versionCode;
                    initPlatformState().then((value) {
                      _projectCode = value;
                      print('uploadversionCode1: ${uploadversionCode}');
                      print('mobileversionCode1: ${_projectCode}');
                      if (int.parse(uploadversionCode) ==
                          int.parse(_projectCode)) {
                        confirmationPopup(
                            context, 'Updated', 'No update available', 'OK');
                      } else if (int.parse(uploadversionCode) <
                          int.parse(_projectCode)) {
                        confirmationPopup(
                            context, 'Updated', 'No update available', 'OK');
                      } else {
                        downloadFile();
                        confirmationPopup(context, 'Updating...',
                            'Your app is updating. Please wait...', 'OK');
                      }
                    });
                  });
                },
              ),
              downloading
                  ? new Positioned(
                      right: 11,
                      top: 8,
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
                          '${progressString}',
                          style: TextStyle(color: Colors.white, fontSize: 8),
                        ),
                      ),
                    )
                  : FutureBuilder(
                      builder: (context, snapshot) {
                        switch (snapshot.connectionState) {
                          case ConnectionState.none:
                            return Text('');
                          case ConnectionState.waiting:
                            print('waiting');
                            return CircularProgressIndicator();
                          case ConnectionState.active:
                            print('active');
                            return CircularProgressIndicator();
                          case ConnectionState.done:
                            print('done');
                            if (snapshot.hasData) {
                              return snapshot.data;
                            }
                        }
                        return Text('');
                      },
                    ),
            ],
          ),
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
                      MySharedPreferences.instance
                          .setIntValue("count", countList[0].totCount);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  EapprovalByUSERID()),
                          (Route<dynamic> route) => false);
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
                          '${(countList.length > 0 ? countList[0].totCount : '')}',
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
        future: GetJSON().getMenus(getID),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            menuListData = snapshot.data;

            if (menuListData.length == 0) {
              showError('No Data Found', Icons.error);
            } else {
              return gridMenuData(menuListData);
            }
          } else if (snapshot.hasError) {
            print('checking Error: ${snapshot.error}');
            if (snapshot.error is HttpException) {
              HttpException httpException = snapshot.error as HttpException;
              return showError(
                  'An http error occured.Page not found. Please try again.',
                  Icons.error);
            }
            if (snapshot.error is NoInternetException) {
              NoInternetException noInternetException =
                  snapshot.error as NoInternetException;
              return showError('Please check your internet connection',
                  Icons.signal_wifi_connected_no_internet_4_sharp);
            }
            if (snapshot.error is NoServiceFoundException) {
              NoServiceFoundException noServiceFoundException =
                  snapshot.error as NoServiceFoundException;
              return showError('Server Error.', Icons.error);
            }
            if (snapshot.error is InvalidFormatException) {
              InvalidFormatException invalidFormatException =
                  snapshot.error as InvalidFormatException;
              return showError(
                  'There is a problem with your request.', Icons.error);
            }
            if (snapshot.error is SocketException) {
              SocketException socketException =
                  snapshot.error as SocketException;
              print('Socket checking: ${socketException.message}');
              return showError('Please check your internet connection',
                  Icons.signal_wifi_connected_no_internet_4_sharp);
            } else {
              UnknownException unknownException =
                  snapshot.error as UnknownException;
              return showError('An Unknown error occured.', Icons.error);
            }
          }
          return Center(
              child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(ReColors().appMainColor),
          ));
        },
      )),
    ));
  }

  void checkState(BuildContext context) {
    final snackBar = new SnackBar(content: new Text('这是一个SnackBar!'));

    Scaffold.of(context).showSnackBar(snackBar);
  }

  Widget gridMenuData(menuList) {
    return RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: () => _refreshMenu(),
        child: Container(
            decoration: Gradientbg().getMenubg(),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    children: <Widget>[
                      Center(
                        child: Text(
                          'Welcome $username',
                          maxLines: 2,
                          style: TextStyle(
                            color: ReColors().appMainColor,
                            fontSize: 20, // light
                            fontWeight: FontWeight.bold, // italic
                          ),
                        ),
                      ),
                      Expanded(
                          child: Align(
                        alignment: Alignment.topRight,
                        child: Text(
                          'v$_projectCode',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            color: ReColors().appMainColor,
                            fontSize: 15, // light
                            fontWeight: FontWeight.bold, // italic
                          ),
                        ),
                      ))
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    // Create a grid with 2 columns. If you change the scrollDirection to
                    // horizontal, this would produce 2 rows.
                    crossAxisCount: 2,
                    // Generate 100 Widgets that display their index in the List
                    children: List.generate(
                        null == menuList ? 0 : menuList.length, (index) {
                      CardsMenuItem _cardsMenuItem = menuList[index];
                      return Container(
                        child: InkWell(
                          onTap: () {
                            print(
                                'ApplicationID : ${_cardsMenuItem.applicationId}');
                            // ignore: unrelated_type_equality_checks
                            Colors.white;
                            if (_cardsMenuItem.applicationId == 104) {
                              /*Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          EapprovalByUSERID()),
                                  (Route<dynamic> route) => false); */
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          EapprovalByUSERID()),
                                  (Route<dynamic> route) => false);
                            } else if (_cardsMenuItem.applicationId == '105') {
                              /* Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Gatepass()),
                              );*/
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
                                /*boxShadow: <BoxShadow>[
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(1.0, 15.0),
                          blurRadius: 20.0,
                        ),
                      ]*/
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Center(
                                        child: _cardsMenuItem.logo == null
                                            ? Image(
                                                image: AssetImage(
                                                    'assets/images/eapprovals.png'),
                                              )
                                            : CachedNetworkImage(
                                                placeholder: (context, url) =>
                                                    CircularProgressIndicator(
                                                  strokeWidth: 2.0,
                                                ),
                                                imageUrl:
                                                    'https://artlive.artisticmilliners.com:8081${_cardsMenuItem.logo}',
                                                height: 100,
                                                width: 100,
                                              )),
                                  ),
                                  Text(
                                    _cardsMenuItem.applicationName,
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
                  ),
                ),
              ],
            )));
  }

  void maxColumn() {
    PopupMenu menu = PopupMenu(
        // backgroundColor: Colors.teal,
        // lineColor: Colors.tealAccent,
        maxColumn: 2,
        items: [
          MenuItem(
              title: 'Self service',
              image: Image.asset('assets/images/ess_logo.png')),
          MenuItem(
              title: 'Sign Out',
              image: Image.asset('assets/images/signout_logo.png')),
        ],
        onClickMenu: onClickMenu,
        stateChanged: stateChanged,
        onDismiss: onDismiss);
    menu.show(widgetKey: btnKey2);
  }

  Widget showError(String message, key) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _refreshMenu();
          _refreshCount();
        });
      },
      child: Center(
        child: Container(
          alignment: FractionalOffset(0.5, 0.5),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Center(
                      child: Icon(
                        key,
                        size: 70,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      message,
                      style: TextStyle(fontSize: 20),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  confirmationPopup(
      BuildContext dialogContext, String title, String msg, String okbtn) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      overlayColor: Colors.black87,
      isCloseButton: true,
      isOverlayTapDismiss: true,
      titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      descStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      animationDuration: Duration(milliseconds: 400),
    );

    Alert(
        context: dialogContext,
        style: alertStyle,
        title: title,
        desc: msg,
        buttons: [
          DialogButton(
            child: Text(
              okbtn,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            onPressed: () {
              Navigator.of(dialogContext).pop(null);
              //
            },
            color: ReColors().appMainColor,
          ),
        ]).show();
  }
}
