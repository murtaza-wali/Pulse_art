import 'dart:async';
import 'dart:io';
import 'package:art/ScreensWithData/IntroScreen/intro_slider.dart';
import 'package:art/ReuseableWidget/GradientBG.dart';
import 'package:fast_qr_reader_view/fast_qr_reader_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:new_version/new_version.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LocalStorage/MySharedPref.dart';
import 'Model/LoginUser.dart';
import 'Model/version.dart';
import 'ReuseableValues/ReStrings.dart';
import 'ScreensWithData/DigitalHR/LMS/Attendance.dart';
import 'ScreensWithData/EApprovalScreens/viewdocuments/viewpdfScreen.dart';
import 'ScreensWithData/LoginScreen/Login.dart';
import 'ScreensWithData/Menu/MainMenuPopup.dart';
import 'ScreensWithData/EApprovalScreens/NoUse/LeaveRequest.dart';
import 'ScreensWithData/Selfservice/shortRequest.dart';

int initScreen;

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

List<CameraDescription> cameras;

Future<void> main() async {
  HttpOverrides.global = new MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();

  debugPaintSizeEnabled = false;

  /*SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.white, // transparent status bar
  ));*/
  await Firebase.initializeApp();
  OneSignal.shared.setAppId(appstring().AppID);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = await prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ART',
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backwardsCompatibility: false, // 1
          systemOverlayStyle: SystemUiOverlayStyle.light, // 2
        ),
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        // '/': (context) => Visualization(),
        '/': (context) => MyHomePage(title: 'Splash'),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/leave': (context) => LeaveRequest(),
        '/short': (context) => ShortRequest(),
        '/attendance': (context) => Attendance(),
        '/attachmentScreen': (context) => AttachmentsScreenApp(),
      },
      // home: MyHomePage(title: 'Splash'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool remember;
  user userLogin;
  List<Versionitem> versionList;
  String android_VersionNumber;
  int ios_VersionNumber;
  String BuildNumber;

  bool _flexibleUpdateAvailable = false;

  @override
  void initState() {
    super.initState();
    final newVersion = NewVersion(
      // iOSId: 'com.google.Vespa',
      androidId: 'am.art.art',
    );

    // You can let the plugin handle fetching the status and showing a dialog,
    // or you can fetch the status and display your own dialog, or no dialog.
    const simpleBehavior = true;

    if (simpleBehavior) {
      print('condition ${simpleBehavior}');
      basicStatusCheck(newVersion);
    } else {
      print('condition 123 q  ${simpleBehavior}');
      advancedStatusCheck(newVersion);
    }

    // AppInstaller.goStore('am.art.art', '', review: true);
    /*  GetJSON().getVersionitem(context).then((users) {
      setState(() {
        versionList = users;
        if (versionList.length == 0) {
        } else {
          getAPKBuildNum().then((value) {
            BuildNumber = value;
            if (Platform.isAndroid) {
              android_VersionNumber = versionList.first.apkVersion;
              print('Build android ${BuildNumber}');
              // Android 9 (SDK 28), Xiaomi Redmi Note 7
              if (int.parse(BuildNumber) >= int.parse(android_VersionNumber)) {
                print(
                    'Build android ${BuildNumber} / ${android_VersionNumber}');
                initStateMain();
              } else {
                print(
                    'Build123 android ${BuildNumber} / ${android_VersionNumber}');
                // ErrorPopup(context);\
                //yeh updated code hai ... yeh test krna hai
                AppInstaller.goStore('am.art.art', '', review: true);
              */
    /*  final newVersion = NewVersion(
                  // iOSId: 'com.google.Vespa',
                  androidId: 'am.art.art',
                );

                // You can let the plugin handle fetching the status and showing a dialog,
                // or you can fetch the status and display your own dialog, or no dialog.
                const simpleBehavior = true;

                if (simpleBehavior) {
                  basicStatusCheck(newVersion);
                } else {
                  advancedStatusCheck(newVersion);
                }*/
    /*
              }
            }
            if (Platform.isIOS) {
              ios_VersionNumber = versionList.first.iosVersion;
              // iOS 13.1, iPhone 11 Pro Max iPhone
              if (int.parse(BuildNumber) >= ios_VersionNumber) {
                print('Build ios ${BuildNumber}/${ios_VersionNumber}');
                initStateMain();
              } else {
                print('Build123 ios ${BuildNumber}/${ios_VersionNumber}');
                ErrorPopup(context);
              }
            }
          });
        }
      });
    });*/
  }

  basicStatusCheck(NewVersion newVersion) {
    newVersion.showAlertIfNecessary(context: context);
    initStateMain();
  }

  advancedStatusCheck(NewVersion newVersion) async {
    final status = await newVersion.getVersionStatus();
    print('new version ${status}');
    if (status != null) {
      debugPrint(status.releaseNotes);
      debugPrint(status.appStoreLink);
      debugPrint(status.localVersion);
      debugPrint(status.storeVersion);
      debugPrint(status.canUpdate.toString());
      if (status.canUpdate == true) {
        newVersion.showUpdateDialog(
            context: context,
            versionStatus: status,
            updateButtonText: 'Update',
            dismissButtonText: 'Dismiss',
            dialogTitle: 'Update App?',
            dialogText: 'A new version of Pulse available. Would You like to update it now?',
            dismissAction: () {
              if (this.mounted) {
                this.setState(() {
                  initStateMain();
                });
              }
            });
      } else {
        if (this.mounted) {
          this.setState(() {
            initStateMain();
          });
        }
      }
    }
  }

  Future<String> getAPKBuildNum() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    var version;
    if (Platform.isAndroid) {
      version = packageInfo.buildNumber;
      // Android 9 (SDK 28), Xiaomi Redmi Note 7
    }

    if (Platform.isIOS) {
      version = packageInfo.version;
      print('IOS release $version');
      // iOS 13.1, iPhone 11 Pro Max iPhone
    }
    print("deviceIdentifier :- " + version.toString());

    return version;
  }

  ErrorPopup(BuildContext dialogContext) {
    var alertStyle = AlertStyle(
      animationType: AnimationType.grow,
      overlayColor: Colors.black87,
      isCloseButton: false,
      isOverlayTapDismiss: false,
      titleStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
      descStyle: TextStyle(fontWeight: FontWeight.w500, fontSize: 16),
      animationDuration: Duration(milliseconds: 400),
    );
    // Alert(
    //     context: dialogContext,
    //     style: alertStyle,
    //     title: 'Update App?',
    //     desc:
    //         'A new version of Pulse available. Would You like to update it now?',
    //     buttons: [
    //       DialogButton(
    //         child: Text(
    //           'Update',
    //           style: TextStyle(color: Colors.white, fontSize: 18),
    //         ),
    //         onPressed: () {
    //           //yeh comment kara hai .....
    //           /*  LaunchReview.launch(
    //             androidAppId: "am.art.art",
    //             iOSAppId: "",
    //           );*/
    //
    //           //yeh updated code hai ... yeh test krna hai
    //           _updateInfo?.updateAvailability ==
    //                   UpdateAvailability.updateAvailable
    //               ? () {
    //                   InAppUpdate.performImmediateUpdate()
    //                       .catchError((e) => print(e.toString()));
    //                 }
    //               : null;
    //         },
    //         color: Colors.black,
    //       ),
    //     ]).show();
  }

  // AppUpdateInfo _updateInfo;
  //
  // // Platform messages are asynchronous, so we initialize in an async method.
  // Future<void> checkForUpdate() async {
  //   InAppUpdate.checkForUpdate().then((info) {
  //     setState(() {
  //       _updateInfo = info;
  //     });
  //   }).catchError((e) {
  //     print(e.toString());
  //   });
  // }

  initStateMain() {
    MySharedPreferences.instance
        .getBoolValue("remember")
        .then((name) => setState(() {
              remember = name;
              if (remember == true) {
                new Future.delayed(const Duration(seconds: 3), () {
                  //
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => MainMenuPopUp()),
                      (Route<dynamic> route) => false);
                });
              } else if (remember == false) {
                if (initScreen == null) {
                  new Future.delayed(const Duration(seconds: 3), () {
                    //
                    // Navigator.pop(context,true);
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => IntroApp()),
                        (Route<dynamic> route) => false);
                  });
                } else if (initScreen == 1) {
                  new Future.delayed(const Duration(seconds: 3), () {
                    //
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) => Login()),
                        (Route<dynamic> route) => false);
                  });
                }
              }
            }));
  }

  @override
  Widget build(BuildContext context) {
    /*SystemChrome.setEnabledSystemUIOverlays([]);*/
    return Scaffold(
      body: Container(
        decoration: Gradientbg().getbg(),
        child: Center(
          child: Column(
            children: <Widget>[
              Expanded(
                child: Center(
                  child: Image.asset('assets/images/artlogo.png',
                      height: 250, width: 260),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                    padding: EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: Column(
                      children: [
                        Text(
                          "Powered by Artistic Milliners",
                          style: TextStyle(
                              // remove this if don't have custom font
                              fontSize: 10.0,
                              // text size
                              color: Colors.white,
                              fontFamily: 'titlefont' // text color
                              ),
                        ),
                        Text(
                          "Copyright © 2021 All Rights Reserved",
                          style: TextStyle(
                              // remove this if don't have custom font
                              fontSize: 10.0,
                              // text size
                              color: Colors.white,
                              fontFamily: 'titlefont' // text color
                              ),
                        )
                      ],
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
