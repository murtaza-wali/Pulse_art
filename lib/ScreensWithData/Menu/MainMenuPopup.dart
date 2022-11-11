import 'dart:convert';
import 'dart:io';
import 'package:art/Error/Error.dart';
import 'package:art/HexCodeConverter/Hexcode.dart';
import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/Model/Count.dart';
import 'package:art/Model/e_s_s_model.dart';
import 'package:art/Model/ticket/assign.dart';
import 'package:art/Model/ticket/department.dart';
import 'package:art/Model/ticket/severity.dart';
import 'package:art/Model/ticket/unit.dart';
import 'package:art/Notification/NotificationParsingData.dart';
import 'package:art/ParsingJSON/GetJSONMethod.dart';
import 'package:art/ParsingJSON/PostJSONMethod.dart';
import 'package:art/ReuseableValues/ReStrings.dart';
import 'package:art/ReuseableWidget/CustomDropdown.dart';
import 'package:art/ScreensWithData/DAMScreens/DAMMain.dart';
import 'package:art/ScreensWithData/DigitalHR/DigitalHRBottomNav.dart';
import 'package:art/ScreensWithData/EApprovalScreens/EapprovalFirstScreen.dart';
import 'package:art/ScreensWithData/FabricPrecosting/FabricCostingBottom.dart';
import 'package:art/ScreensWithData/LoginScreen/Login.dart';
import 'package:art/PopMenuDir/popup_menu.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/GradientBG.dart';
import 'package:art/ReuseableWidget/WillpopWidget.dart';
import 'package:art/ScreensWithData/Policyhub/iPolicy.dart';
import 'package:art/ScreensWithData/Receiveable/Receiveable.dart';
import 'package:art/ScreensWithData/Sales/OneClickSales.dart';
import 'package:art/ScreensWithData/ServiceDeskScreen/eitMain.dart';
import 'package:art/ScreensWithData/Traceability/Traceability.dart';
import 'package:art/ScreensWithData/WMS_AM5/WMSAM5.dart';
import 'package:art/ScreensWithData/YarnPrecosting/YarnPrecosting.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:art/InternetConnection/Offline.dart';
import 'package:art/Model/MenuCardsModel.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../SearchForm.dart';
import '../../TaskModel.dart';
import '../BottomNavigation.dart';
import '../p2p.dart';

class MainMenuPopUp extends StatefulWidget {
  @override
  _MainMenuPopUpState createState() => _MainMenuPopUpState();
}

int getID;

class _MainMenuPopUpState extends State<MainMenuPopUp> {
  PopupMenu menu;
  GlobalKey btnKey2 = GlobalKey();
  Color color2 = HexColor("#055e8e");
  String username, key;
  bool isloading = false;
  ProgressDialog progressDialog;
  GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      GlobalKey<RefreshIndicatorState>();
  bool downloading = false;
  bool severityVisible = false;
  UnitItems uniIltems;
  var dir;
  bool dialogvisible = false;
  List<CardsMenuItem> menuListData = [];
  List<Totalcount> countList = [];
  List<UnitItems> unitList = [];
  List<Essitems> profilelist;
  List<Deptitems> deptList = [];
  List<AssignItems> AssignItemsList = [];
  List<Severityitems> SeverityitemsList = [];
  String message;
  String selectedSpinnerItem;
  String spinnerId;
  String selectedDepartmentName;
  String selectedSeverityName = '';
  String selectedAssignName;
  String selectedAssignid;
  String _debugLabelString = "";
  String employeCode, PlayerID, AppID;
  int deptcode;
  int selectedSeverityID;
  int selectdeptID;
  int counter = 10;
  int click;
  List<TaskModel> taskList = List();

  @override
  void initState() {
    super.initState();
    setState(() {
      taskList.add(TaskModel(
          title: 'MOI', description: 'Mtrs', time: '', timeStatus: ''));
      taskList.add(TaskModel(
          title: 'Performa Invoice',
          description: '2,700 Mtrs',
          time:
              'Issuance(WARP):08-JUL-2021 - 05-AUG-2021(WEFT):19-JUL-2021 - 29-SEP-2021',
          timeStatus: ''));
      taskList.add(TaskModel(
          title: 'Internal Order',
          description: 'Weight: , Bags:',
          time: '',
          timeStatus: ''));
      taskList.add(TaskModel(
          title: 'GRN',
          description: 'Total Received Qty :\nTotal Received Bags :',
          time: '',
          timeStatus: ''));
      taskList.add(TaskModel(
          title: 'Issuance',
          description:
              '(WARP):Weight 84,223 , Bags 851(WEFT):Weight 15,818, Bags 158',
          time: '',
          timeStatus: ''));
      taskList.add(TaskModel(
          title: 'Production', description: '', time: '', timeStatus: ''));
      taskList.add(TaskModel(
          title: 'Dispatch', description: '', time: '', timeStatus: ''));
    });
    progressDialog = new ProgressDialog(context);
    MySharedPreferences.instance
        .getIntValue("UserId")
        .then((value) => setState(() {
              getID = value;
              print('USER ID : ${getID}');
              GetJSON().getMenus(getID).then((users) {
                setState(() {
                  menuListData = users;
                });
              });
              GetJSON().getTotalCount(context, getID).then((count) {
                setState(() {
                  countList = count;
                });
              });

              GetJSON().getProfileData(context, getID).then((users) {
                if (this.mounted) {
                  setState(() {
                    profilelist = users;
                    MySharedPreferences.instance.setStringValue(
                        "employeecode", profilelist[0].employeecode);
                    MySharedPreferences.instance.setIntValue(
                        "departmentId", profilelist[0].departmentId);
                  });
                }
              });
              MySharedPreferences.instance
                  .getStringValue("player_id")
                  .then((player) => setState(() {
                        PlayerID = player;
                      }));
              MySharedPreferences.instance
                  .getStringValue("app_id")
                  .then((app) => setState(() {
                        AppID = app;
                        if (AppID == '' || PlayerID == '') {
                          OneSignal.shared.getDeviceState().then((deviceState) {
                            postNotification()
                                .getDeviceData(
                                    deviceState?.userId, appstring().AppID)
                                .then((count) {
                              Map<String, dynamic> device =
                                  jsonDecode(count.body);
                              postJSON().postNotification(
                                  getID,
                                  device['id'],
                                  1,
                                  device['device_model'],
                                  device['device_os'],
                                  device['invalid_identifier'].toString(),
                                  device['ip'],
                                  "Y");
                            });
                          });
                        } else {
                          postNotification()
                              .getDeviceData(PlayerID, AppID)
                              .then((count) {
                            Map<String, dynamic> device =
                                jsonDecode(count.body);
                            postJSON().postNotification(
                                getID,
                                device['id'],
                                1,
                                device['device_model'],
                                device['device_os'],
                                device['invalid_identifier'].toString(),
                                device['ip'],
                                "Y");
                          });
                        }
                      }));
            }));
    MySharedPreferences.instance.getStringValue("employeecode").then((name) {
      setState(() {
        employeCode = name;
        print('Main Menu${employeCode}');
      });
    });
    MySharedPreferences.instance
        .getIntValue("departmentId")
        .then((name) => setState(() {
              deptcode = name;
            }));
    MySharedPreferences.instance
        .getStringValue("Username")
        .then((name) => setState(() {
              username = name;
            }));
    /*MySharedPreferences.instance
        .getStringValue("key")
        .then((keys) => setState(() {
              key = keys;
            }));*/
  }

  Future<void> initPlatformState() async {
    if (!mounted) return;
    OneSignal.shared.setNotificationOpenedHandler(
        (OSNotificationOpenedResult result) async {
      try {
        var clickAction =
            await result.notification.additionalData["click_action"];
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => EapprovalPage()),
            (Route<dynamic> route) => false);
      } catch (e, stacktrace) {
        print(e);
      }
    });
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      print('FOREGROUND HANDLER CALLED WITH: ${event}');

      event.complete(event.notification);

      this.setState(() {
        _debugLabelString =
            "Notification received in foreground notification: \n${event.notification.jsonRepresentation().replaceAll("\\n", "\n")}";
        print(
            'FOREGROUND _debugLabelString: ${event.notification.additionalData['click_action']}');
        var clickAction = event.notification.additionalData['click_action'];
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => EapprovalPage()),
            (Route<dynamic> route) => false);
      });
    });
  }

  void stateChanged(bool isShow) {}

  Future<dynamic> _refreshMenu() async {
    return await GetJSON().getMenus(getID);
  }

  Future<dynamic> _refreshCount() async {
    return await GetJSON().getTotalCount(context, getID);
  }

  void onClickMenu(MenuItemProvider item) {
    if (item.menuTitle.contains('Sign Out')) {
      postNotification().getDeviceData(PlayerID, AppID).then((count) {
        Map<String, dynamic> device = jsonDecode(count.body);
        postJSON().postNotification(
            getID,
            device['id'],
            1,
            device['device_model'],
            device['device_os'],
            device['invalid_identifier'].toString(),
            device['ip'],
            "N");
      });
      MySharedPreferences.instance.removeAll();
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => Login()),
          (Route<dynamic> route) => false);
    } else if (item.menuTitle.contains('Self Service')) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (BuildContext context) => BottomNavBar()),
          (Route<dynamic> route) => false);
    }
  }

  void onDismiss() {}
  bool loader = true;

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
            Container(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Menu',
                  style: TextStyle(fontFamily: 'headerfont'),
                ))
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
                      }));
                  _refreshCount().then((list) => setState(() {
                        countList = list;
                      }));
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
                      MySharedPreferences.instance
                          .setIntValue("count", countList[0].totCount);
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  EapprovalPage()),
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
        automaticallyImplyLeading: false,
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
            dialogvisible = true;
            menuListData = snapshot.data;
            print('ksaldkals Data ${menuListData.length}');
            if (menuListData.length == 0) {
              loader = false;
              showError('No Data Found', Icons.error);
            } else {
              return gridMenuData(menuListData);
            }
          } else if (snapshot.hasError) {
            if (snapshot.error is HttpException) {
              return showError(
                  'An http error occurred. Page not found. Please try again.',
                  Icons.error);
            }
            if (snapshot.error is NoInternetException) {
              dialogvisible = false;
              return showError('Please check your internet connection',
                  Icons.signal_wifi_connected_no_internet_4_sharp);
            }
            if (snapshot.error is NoServiceFoundException) {
              return showError('Server Error.', Icons.error);
            }
            if (snapshot.error is InvalidFormatException) {
              return showError(
                  'There is a problem with your request.', Icons.error);
            }
            if (snapshot.error is SocketException) {
              SocketException socketException =
                  snapshot.error as SocketException;
              dialogvisible = false;
              return showError('Please check your internet connection',
                  Icons.signal_wifi_connected_no_internet_4_sharp);
            } else {
              return showError('An Unknown error occurred.', Icons.error);
            }
          }
          return loader == true
              ? Center(
                  child: CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(ReColors().appMainColor),
                ))
              : showError(
                  'No cards Assigned to ${username}.', Icons.block_rounded);
        },
      )),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        onPressed: () {
          assignVisible = false;
          deptVisible = false;
          severityVisible = false;
          setState(() {
            GetJSON().getTicketUnit(getID).then((unit) {
              setState(() {
                unitList = unit;
                if (unitList.length == 0) {
                } else {
                  spinnerId = unitList.first.companyid;
                }
              });
            });
            GetJSON().getTicketSeverity().then((Severity) {
              setState(() {
                SeverityitemsList = Severity;
              });
            });
            Navigator.of(context).push(
              PageRouteBuilder(
                  pageBuilder: (context, _, __) =>
                      Visibility(visible: dialogvisible, child: customAler()),
                  opaque: false),
            );
          });
        },
        icon: Icon(
          Icons.support,
          color: ReColors().appMainColor,
        ),
        label: Text(
          appstring().support,
          textAlign: TextAlign.right,
          style: TextStyle(
              color: ReColors().appMainColor,
              fontSize: 15,
              fontFamily: 'headingfont'),
        ),
      ),
    ));
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
                      Expanded(
                          child: Align(
                        alignment: Alignment.center,
                        child: Text(
                          'Welcome $username',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: ReColors().appMainColor,
                              fontSize: 18,
                              fontFamily: 'headingfont'),
                        ),
                      ))
                    ],
                  ),
                ),
                Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                    children: List.generate(
                        null == menuList ? 0 : menuList.length, (index) {
                      CardsMenuItem _cardsMenuItem = menuList[index];
                      return Container(
                        child: InkWell(
                          onTap: () {
                            print('onTap: ${_cardsMenuItem.applicationId}');
                            if (_cardsMenuItem.applicationId == 104) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          EapprovalPage()),
                                  (Route<dynamic> route) => false);
                            } else if (_cardsMenuItem.applicationId == 360) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          DamMain()),
                                  (Route<dynamic> route) => false);
                            } else if (_cardsMenuItem.applicationId == 301) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          eitMain()),
                                  (Route<dynamic> route) => false);
                            } else if (_cardsMenuItem.applicationId == 405) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          IPolicyHub()),
                                  (Route<dynamic> route) => false);
                            } else if (_cardsMenuItem.applicationId == 402) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          HRBottomNavBar()),
                                  (Route<dynamic> route) => false);
                            } else if (_cardsMenuItem.applicationId == 117) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          EmillWidget()),
                                  (Route<dynamic> route) => false);
                            } else if (_cardsMenuItem.applicationId == 411) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          SearchForm()),
                                  (Route<dynamic> route) => false);
                            } else if (_cardsMenuItem.applicationId == 420) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          TraceabilityPage(taskList: taskList)),
                                  (Route<dynamic> route) => false);
                            } else if (_cardsMenuItem.applicationId == 130) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          ChartApp()),
                                  (Route<dynamic> route) => false);
                            } else if (_cardsMenuItem.applicationId == 136) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Yarnprecosting()),
                                  (Route<dynamic> route) => false);
                            } else if (_cardsMenuItem.applicationId == 401) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          FabricCostingBottomNavBar()),
                                  (Route<dynamic> route) => false);
                            } else if (_cardsMenuItem.applicationId == 125) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Receivables()),
                                  (Route<dynamic> route) => false);
                            } else if (_cardsMenuItem.applicationId == 163) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          WMS_AM5()),
                                  (Route<dynamic> route) => false);
                            }
                          },
                          child: Card(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  // begin: Alignment(-0.6, -1),
                                  // end: Alignment(-1, -0),
                                  colors: [Colors.black, color2],
                                ),
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10.0),
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
                                                height: 80,
                                                width: 80,
                                              )),
                                  ),
                                  Text(
                                    _cardsMenuItem.applicationName,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14.0,
                                      fontFamily: 'headingfont',
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
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
            ))
    );
  }

  void maxColumn() {
    PopupMenu menu = PopupMenu(
        maxColumn: 2,
        items: [
          MenuItem(
              title: 'Self Service',
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
                      textAlign: TextAlign.center,
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

  TextEditingController subjectController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  Widget chip(String label, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              color: ReColors().appMainColor,
            ),
          ),
        ),
      ],
    );
  }

  bool assignVisible = false;
  bool deptVisible = false;

  customAler() {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      title: Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Row(
              children: [
                new Expanded(
                  child: Text(
                    'Create Ticket',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: ReColors().appMainColor,
                      fontSize: 17.0,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'headingfont',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10,),
            Divider(
              height: 10,
              color: Colors.grey,
            )
          ],

        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actions: <Widget>[
        FlatButton(
          child: const Text('CANCEL',
              style: TextStyle(
                color: Color(0xff055e8e),
                fontSize: 14.0,
                fontFamily: 'headingfont',
              )),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textColor: Theme.of(context).accentColor,
    onPressed: () {
      Navigator.of(context, rootNavigator: true)
          .pop();
    }
        ),
        FlatButton(
          child: const Text('CREATE',
              style: TextStyle(
                color: Color(0xff055e8e),
                fontSize: 14.0,
                fontFamily: 'headingfont',
              )),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textColor: Theme.of(context).accentColor,
          onPressed: () {
            if (subjectController.text.isEmpty ||
                descriptionController.text.isEmpty ||
                spinnerId == null ||
                selectedAssignid == null ||
                selectedSeverityID == null ||
                selectdeptID == null) {
              confirmationPopup(
                  context, 'Alert', 'All fields are required', 'OK');
            } else {
              postJSON().postTicket(
                  employeCode,
                  subjectController.text,
                  descriptionController.text,
                  selectedSeverityID,
                  deptcode,
                  selectdeptID,
                  selectedAssignid,
                  getID,
                  spinnerId);

              setState(() {
                isloading = true;
                if (isloading) {
                  progressDialog.show();
                }
              });
              Future.delayed(Duration(seconds: 3)).then((value) => {
                    confirmationPopupforTicket(
                        context,
                        'Success',
                        'Your support ticket has been successfully created!',
                        'OK'),
                  });
            }
          },
        ),
      ],
      content: StatefulBuilder(
        builder:
            (BuildContext context, void Function(void Function()) setState) {
          return SingleChildScrollView(
            child: Container(
              width: double.maxFinite,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: Column(
                      children: <Widget>[
                        new FutureBuilder<List<UnitItems>>(
                          future: GetJSON().getTicketUnit(getID),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return CustomDropdown(
                                dropdownMenuItemList: unitList.map((item) {
                                      return DropdownMenuItem(
                                        child:
                                            chip(item.companyname, Colors.grey),
                                        value: item.companyname,
                                      );
                                    }).toList() ??
                                    [],
                                onChanged: (newVal) {
                                  setState(() {
                                    selectedSpinnerItem = newVal;
                                    deptVisible = true;
                                    GetJSON()
                                        .getTicketDept(spinnerId)
                                        .then((value) {
                                      deptList = value;
                                    });
                                  });
                                },
                                value: selectedSpinnerItem,
                                isEnabled: true,
                                color: ReColors().appMainColor,
                                hint: 'Brand',
                              ).build(context);
                            } else {
                              GetJSON().getTicketUnit(getID).then((unit) {
                                setState(() {
                                  unitList = unit;
                                  if (unitList.length == 0) {
                                  } else {
                                    spinnerId = unitList.first.companyid;
                                  }
                                });
                              });
                              return new CircularProgressIndicator();
                            }
                          },
                        ),
                        Visibility(
                            visible: deptVisible,
                            child: Column(
                              children: [
                                Divider(
                                  color: Colors.white,
                                ),
                                new FutureBuilder<List<Deptitems>>(
                                  future: GetJSON().getTicketDept(spinnerId),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return CustomDropdown(
                                        dropdownMenuItemList:
                                            deptList.map((item) {
                                                  return DropdownMenuItem(
                                                    child: chip(
                                                        item.departmentName,
                                                        Colors.grey),
                                                    value: item.departmentId,
                                                  );
                                                }).toList() ??
                                                [],
                                        onChanged: (newVal) {
                                          setState(() {
                                            selectdeptID = newVal;
                                            assignVisible = true;
                                            GetJSON()
                                                .getTicketAssign(
                                                    spinnerId, selectdeptID)
                                                .then((value) {
                                              AssignItemsList = value;
                                            });
                                          });
                                        },
                                        value: selectdeptID,
                                        isEnabled: true,
                                        color: ReColors().appMainColor,
                                        hint: 'Department',
                                      ).build(context);
                                    } else {
                                      return new CircularProgressIndicator();
                                    }
                                  },
                                )
                              ],
                            )),
                        Visibility(
                            visible: assignVisible,
                            child: Column(
                              children: [
                                Divider(
                                  color: Colors.white,
                                ),
                                new FutureBuilder<List<AssignItems>>(
                                  future: GetJSON()
                                      .getTicketAssign(spinnerId, selectdeptID),
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return CustomDropdown(
                                        dropdownMenuItemList:
                                            AssignItemsList.map((item) {
                                                  return DropdownMenuItem(
                                                    child: chip(item.ename,
                                                        Colors.grey),
                                                    value: item.employeecode,
                                                  );
                                                }).toList() ??
                                                [],
                                        onChanged: (AssignValue) {
                                          setState(() {
                                            selectedAssignid = AssignValue;
                                          });
                                        },
                                        value: selectedAssignid,
                                        isEnabled: true,
                                        color: ReColors().appMainColor,
                                        hint: 'Assign To',
                                      ).build(context);
                                    } else {
                                      return new CircularProgressIndicator();
                                    }
                                  },
                                )
                              ],
                            )),
                        Column(
                          children: [
                            Divider(
                              color: Colors.white,
                            ),
                            new FutureBuilder<List<Severityitems>>(
                              future: GetJSON().getTicketSeverity(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return CustomDropdown(
                                    dropdownMenuItemList:
                                        SeverityitemsList.map((item) {
                                              return DropdownMenuItem(
                                                child: chip(
                                                    item.value, Colors.grey),
                                                value: item.id,
                                              );
                                            }).toList() ??
                                            [],
                                    onChanged: (newVal) {
                                      setState(() {
                                        selectedSeverityID = newVal;
                                      });
                                    },
                                    value: selectedSeverityID,
                                    isEnabled: true,
                                    color: ReColors().appMainColor,
                                    hint: 'Severity',
                                  ).build(context);
                                } else {
                                  GetJSON()
                                      .getTicketSeverity()
                                      .then((Severity) {
                                    SeverityitemsList = Severity;
                                  });
                                  return new CircularProgressIndicator();
                                }
                              },
                            )
                          ],
                        ),
                        Divider(
                          color: Colors.white,
                        ),
                        TextField(
                          style: TextStyle(
                              color: ReColors().appMainColor,
                              fontFamily: 'headingfont'),
                          controller: subjectController,
                          decoration: InputDecoration(
                            fillColor: ReColors().appMainColor,
                            enabledBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                              borderSide:
                                  BorderSide(color: ReColors().appMainColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xff055e8e), width: 2.0),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            labelText: 'Subject',
                            labelStyle: TextStyle(
                                color: Color(0xff055e8e),
                                fontFamily: 'headingfont'),
                          ),
                          onChanged: (addresstext) {
                            setState(() {});
                          },
                        ),
                        Divider(
                          color: Colors.white,
                        ),
                        TextField(
                          style: TextStyle(
                              color: ReColors().appMainColor,
                              fontFamily: 'headingfont'),
                          controller: descriptionController,
                          decoration: InputDecoration(
                            fillColor: ReColors().appMainColor,
                            enabledBorder: new OutlineInputBorder(
                              borderRadius: new BorderRadius.circular(5.0),
                              borderSide:
                                  BorderSide(color: ReColors().appMainColor),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  color: Color(0xff055e8e), width: 2.0),
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            labelText: 'Description',
                            labelStyle: TextStyle(
                                color: Color(0xff055e8e),
                                fontFamily: 'headingfont'),
                          ),
                          onChanged: (addresstext) {
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
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
            },
            color: ReColors().appMainColor,
          ),
        ]).show();
  }

  confirmationPopupforTicket(
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
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => MainMenuPopUp()),
              );
            },
            color: ReColors().appMainColor,
          ),
        ]).show();
  }
}
