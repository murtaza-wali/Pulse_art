import 'dart:io';

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
import 'package:art/Gatepass/GatepassMenu.dart';
import 'package:art/InternetConnection/Offline.dart';
import 'package:art/Model/MenuCardsModel.dart';
import 'package:open_file/open_file.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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

  final apkUrl = "https://art.artisticmilliners.com:8081/ords/art/apis/apk/";
  bool downloading = false;
  var progressString = "";
  List<ApkItem> list = [];
  String mobileversionCode;
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
      package().then((value) {
        mobileversionCode = value;
        print('uploadversionCode1: ${uploadversionCode}');
        print('mobileversionCode1: ${mobileversionCode}');
        EnableButton(uploadversionCode, mobileversionCode);
      });
    });

    createFolder().then((value) {
      dir = value;
      print('dir: ${dir}');
    });
  }

  bool enablebtn = false;
  bool downloadfile;
  final key = GlobalKey();

  Widget EnableButton(uploadversionCode1, mobileversionCode1) {
    print(
        'condition: ${int.parse(uploadversionCode1) == int.parse(mobileversionCode1)}');

    if (int.parse(uploadversionCode1) == int.parse(mobileversionCode1)) {
      enablebtn = false;
    } else {
      enablebtn = true;
      downloadFile().then((value) {});
      confirmationPopup(
          context, 'Updating...', 'Your app is updating. Please wait...', 'OK');
    }
  }

  Future<String> package() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String code = packageInfo.buildNumber;
    return code;
  }

  Future<void> deleteFile(File file) async {
    try {
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      // Error in getting access to the file.
    }
  }

  Future<String> createFolder() async {
    final path = Directory("storage/emulated/0/Download/pulse_/apk");
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
      file = new File("${dir}/pulse.apk");
      deleteFile(File(file.absolute.path));
      dio.download(apkUrl, "${dir}/pulse.apk",
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              validateStatus: (status) {
                return status < 500;
              }), onReceiveProgress: (rec, total) {
        total = 3131585;
        downloading = true;
        totalpercentage = ((rec / total) * 100).toStringAsFixed(0);
        valueOfTotal = totalpercentage;
        if (int.parse(totalpercentage) >= 738) {
          downloading = false;
          OpenFile.open("${dir}/pulse.apk");
          getMyIcon();
        }
      });
    } catch (e) {
      print('catchinf ............ ${e}');
    }
  }

  Widget getMyIcon() {
    return Icon(
      Icons.download_sharp,
      color: Colors.blue,
      size: 20,
    );
  }

  void stateChanged(bool isShow) {
    print('menu is ${isShow ? 'showing' : 'closed'}');
  }

  Future<dynamic> _refreshMenu() async {
    print('GET ID : ${getID}');
    return await GetJSON().getMenus(getID);
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
      /* Navigator.push(
          context,
          MaterialPageRoute(builder: (BuildContext context) => UserProfile()),
          );*/

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

/*  Future<String> createFolder(String cow) async {
    final folderName = cow;
    final path = Directory("storage/emulated/0/$folderName");
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    if ((await path.exists())) {
      return path.path;
    } else {
      path.create();
      return path.path;
    }
  }*/

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
                },
              )
            ],
          ),
          new Stack(
            alignment: Alignment.centerRight,
            children: <Widget>[
              enablebtn == true
                  ? new Transform.scale(
                      scale: 0.5,
                      child: Column(
                        children: [
                          CircularProgressIndicator(),
                          Text('${mobileversionCode}/${uploadversionCode}')
                        ],
                      ),
                    )
                  : IconButton(
                      icon: Icon(Icons.download_sharp),
                      color: Colors.white,
                      onPressed: () {
                        confirmationPopup(
                            context, 'Updated', 'No update available', 'OK');
                      },
                    )
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
              return showError(httpException.message, Icons.error);
            }
            if (snapshot.error is NoInternetException) {
              NoInternetException noInternetException =
                  snapshot.error as NoInternetException;
              return showError('noInternetException.message', Icons.error);
            }
            if (snapshot.error is NoServiceFoundException) {
              NoServiceFoundException noServiceFoundException =
                  snapshot.error as NoServiceFoundException;
              return showError(noServiceFoundException.message, Icons.error);
            }
            if (snapshot.error is InvalidFormatException) {
              InvalidFormatException invalidFormatException =
                  snapshot.error as InvalidFormatException;
              return showError(invalidFormatException.message, Icons.error);
            }
            if (snapshot.error is SocketException) {
              SocketException socketException =
                  snapshot.error as SocketException;
              print('Socket checking: ${socketException.message}');
              return showError('Please check your internet connection',
                  Icons.signal_wifi_connected_no_internet_4);
            } else {
              UnknownException unknownException =
                  snapshot.error as UnknownException;
              return showError(unknownException.message, Icons.error);
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
                  child: Text(
                    'Welcome $username',
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
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          EapprovalByUSERID()),
                                  (Route<dynamic> route) => false);
                            } else if (_cardsMenuItem.applicationId == '105') {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Gatepass()),
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
                                                imageUrl: _cardsMenuItem.logo,
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

Future download2(Dio dio, String url, String savePath) async {
  try {
    Response response = await dio.get(
      url,
      onReceiveProgress: showDownloadProgress,
      //Received data with List<int>
      options: Options(
          responseType: ResponseType.bytes,
          followRedirects: false,
          validateStatus: (status) {
            return status < 500;
          }),
    );
    print(response.headers);
    File file = File(savePath);
    var raf = file.openSync(mode: FileMode.write);
    // response.data is List<int> type
    raf.writeFromSync(response.data);
    await raf.close();
  } catch (e) {
    print(e);
  }
}

void showDownloadProgress(received, total) {
  if (total != -1) {
    print((received / total * 100).toStringAsFixed(0) + "%");
  }
}

// Future<String> downloadFile(String url, String dir) async {
//   HttpClient httpClient = new HttpClient();
//   File file;
//   String filePath = '';
//   String myUrl = '';
//
//   try {
//     myUrl = url;
//     // myUrl = url+'/'+fileName;
//     var request = await httpClient.getUrl(Uri.parse(myUrl));
//     var response = await request.close();
//     if (response.statusCode == 200) {
//       var bytes = await consolidateHttpClientResponseBytes(response);
//       Directory tempDir = await DownloadsPathProvider.downloadsDirectory;
//       String tempPath = tempDir.path;
//       filePath = tempPath + '/$dir';
//       file = File(filePath);
//       print('FILE : ${file}');
//       await file.writeAsBytes(bytes);
//     } else
//       filePath = 'Error code: ' + response.statusCode.toString();
//   } catch (ex) {
//     filePath = 'Can not fetch url';
//   }
//
//   return filePath;
// }
