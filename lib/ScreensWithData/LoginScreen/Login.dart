import 'package:art/InternetConnection/Offline.dart';
import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/Model/LoginUser.dart';
import 'package:art/ParsingJSON/GetJSONMethod.dart';
import 'package:art/ParsingJSON/PostJSONMethod.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableValues/ReStrings.dart';
import 'package:art/ReuseableWidget/GradientBG.dart';
import 'package:art/ScreensWithData/Menu/MainMenuPopup.dart';
import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<Login> {
  final focus = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController username = new TextEditingController();
  TextEditingController userpassword = new TextEditingController();
  TextEditingController updateuserpassword = new TextEditingController();
  List<Loginitems> _users;
  String p_user;
  String p_psw;
  GetJSON loginAuth;
  Loginitems item;
  bool _isHidden = true;
  bool _myBool = false;

  @override
  void initState() {
    super.initState();
    _users = [];
    loginAuth = new GetJSON();
    item = new Loginitems();
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  String Username1 = '';

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                child: Text(appstring().login))
          ],
        ),
        automaticallyImplyLeading: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              colors: [ReColors().appMainColor, Colors.black],
            ),
          ),
        ),
      ),
      body: ReuseOffline().getoffline(Container(
          decoration: Gradientbg().getbg(),
          child: Padding(
            padding: EdgeInsets.all(10),
            child: ListView(
              children: <Widget>[
                Center(
                  child: Image.asset('assets/images/artlogo.png',
                      height: 155, width: 165),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: TextField(
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'titlefont'),
                    controller: username,
                    decoration: InputDecoration(
                      labelText: appstring().username,
                      labelStyle: TextStyle(
                          color: Colors.white, fontFamily: 'titlefont'),
                      fillColor: Colors.white,
                      enabledBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => focus.nextFocus(),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  alignment: Alignment.center,
                  child: TextField(
                    obscureText: _isHidden,
                    obscuringCharacter: "*",
                    style:
                        TextStyle(color: Colors.white, fontFamily: 'titlefont'),
                    controller: userpassword,
                    decoration: InputDecoration(
                      suffix: InkWell(
                        onTap: _togglePasswordView,
                        child: Icon(
                          _isHidden ? Icons.visibility : Icons.visibility_off,
                          color: Colors.white,
                        ),
                      ),
                      labelText: appstring().psw,
                      labelStyle: TextStyle(
                          color: Colors.white, fontFamily: 'titlefont'),
                      fillColor: Colors.white,
                      enabledBorder: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(25.0),
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    textInputAction: TextInputAction.next,
                    onEditingComplete: () => focus.nextFocus(),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                          flex: 5,
                          child: Container(
                              child: FlatButton(
                                  onPressed: () =>
                                      setState(() => _myBool = !_myBool),
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                            height: 24.0,
                                            width: 24.0,
                                            child: Checkbox(
                                                side: BorderSide(color: ReColors().appTextWhiteColor),
                                                checkColor: ReColors().appMainColor,
                                                activeColor: Colors.white,
                                                value: _myBool,
                                                onChanged: (value) {
                                                  setState(() => _myBool = value);
                                                }
                                                )
                                        ),
                                        SizedBox(width: 10.0),
                                        Text(
                                          appstring().remember,
                                          style: TextStyle(
                                              color:
                                                  ReColors().appTextWhiteColor,
                                              fontSize: 13.0,
                                              fontFamily: 'titlefont'),
                                        )
                                      ])))),
                      Expanded(
                          flex: 5,
                          child: FlatButton(
                              color: Colors.transparent,
                              textColor: Colors.white,
                              padding: EdgeInsets.all(8.0),
                              splashColor: Colors.transparent,
                              onPressed: () {},
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(appstring().forget_psw,
                                    style: TextStyle(
                                        fontSize: 15.0,
                                        fontFamily: 'titlefont'),
                                    textAlign: TextAlign.right),
                              )))
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                  height: 50.0,
                  margin: EdgeInsets.all(10),
                  child: RaisedButton(
                    onPressed: () {
                      /*  Navigator.of(context).push(
                        PageRouteBuilder(
                            pageBuilder: (context, _, __) =>
                                UpdatePasswordPopup(),
                            opaque: false),
                      );*/
                      if (username.text.isEmpty || userpassword.text.isEmpty) {
                        confirmationPopup(context, 'Error',
                            'Please fill the required field', 'OK');
                      } else {
                        print('login auth${username.text}${userpassword.text}');
                        loginAuth
                            .getLoginUser(
                                context, username.text, userpassword.text)
                            .then((users) {
                          setState(() {
                            _users = users;
                            if (_users == null) {
                              confirmationPopup(
                                  context,
                                  'Error',
                                  'Please fill the required field or Check your Internet Connection',
                                  'OK');
                            } else if (_users.length == 0) {
                              confirmationPopup(context, "Error",
                                  'Enter a valid Username and Password', "Ok");
                            }
                          });
                          item = _users[0];
                          if (item != null) {
                            String userID = item.userId;
                            String name = item.empname;
                            // String keys = item.keys;
                            int returnValue = item.rtnVal;
                            Username1 = item.userName;
                            int loginStatus = 0;
                            MySharedPreferences.instance
                                .setIntValue("UserId", int.parse(userID));
                            MySharedPreferences.instance
                                .setBoolValue("remember", _myBool);
                            MySharedPreferences.instance
                                .setStringValue("Username", name);
                            /*MySharedPreferences.instance
                                .setStringValue("key", keys);*/
                            if (_myBool == false) {
                              loginStatus = 0;
                            } else if (_myBool == true) {
                              loginStatus = 1;
                            }
                            OneSignal.shared
                                .getDeviceState()
                                .then((deviceState) {
                              MySharedPreferences.instance.setStringValue(
                                  "player_id", deviceState?.userId);
                              MySharedPreferences.instance
                                  .setStringValue("app_id", appstring().AppID);
                            }).whenComplete(() {
                              if (returnValue == 1) {
                                Navigator.of(context).push(
                                  PageRouteBuilder(
                                      pageBuilder: (context, _, __) =>
                                          UpdatePasswordPopup(),
                                      opaque: false),
                                );
                              } else if (returnValue == 0) {
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            MainMenuPopUp()),
                                    (Route<dynamic> route) => false);
                              }
                            });
                          }
                        });
                      }
                    },
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(80.0)),
                    padding: EdgeInsets.all(0.0),
                    child: Ink(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              ReColors().appTextWhiteColor,
                              ReColors().appTextWhiteColor
                            ],
                            begin: Alignment.centerLeft,
                            end: Alignment.centerRight,
                          ),
                          borderRadius: BorderRadius.circular(30.0)),
                      child: Container(
                        margin: EdgeInsets.symmetric(
                            horizontal:
                                0.05 * MediaQuery.of(context).size.width),
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width,
                            minHeight: 50.0),
                        alignment: Alignment.center,
                        child: Text(
                          appstring().login,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ReColors().appMainColor,
                              fontSize: 15,
                              fontFamily: 'headerfont'),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ))),
    );
  }

  bool loading = false;
  String str =
      'You are required to update your password in order to continue using services in ART Portal';

  UpdatePasswordPopup() {
    return AlertDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      title: Align(
        alignment: Alignment.center,
        child: Row(
          children: [
            new Expanded(
              child: Text(
                'Update Password',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: ReColors().appMainColor,
                  fontSize: 17.0,
                  fontFamily: 'headingfont',
                ),
              ),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      actions: <Widget>[
        FlatButton(
          child: const Text('Cancel',
              style: TextStyle(
                color: Color(0xff055e8e),
                fontSize: 14.0,
                fontFamily: 'headingfont',
              )),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textColor: Theme.of(context).accentColor,
          onPressed: () {
            Navigator.of(context).pop(null);
          },
        ),
        FlatButton(
          child: const Text('Update',
              style: TextStyle(
                color: Color(0xff055e8e),
                fontSize: 14.0,
                fontFamily: 'headingfont',
              )),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textColor: Theme.of(context).accentColor,
          onPressed: () {
            print('check ${Username1} = ${updateuserpassword.text}');
            postJSON()
                .PostTupdatePassword(
              context,
              Username1,
              updateuserpassword.text,
            )
                .then((value) {
              print('check value ${value} = ');
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (BuildContext context) => Login()),
                  (Route<dynamic> route) => false);
            });
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
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: EasyRichText(
                            textAlign: TextAlign.center,
                            text: str,
                            patternMap: {
                              'You are required to update your password in order to continue using services in ':
                                  TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14,
                                      fontFamily: 'titlefont'),
                              'ART Portal': TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 14,
                                  fontFamily: 'headingfont'),
                            },
                          ),
                        ),
                        /*  Text(
                            'You are required to update your password in order to continue using services in ART Portal',style:  TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 14, fontFamily: 'titlefont')),*/
                        Center(
                            child: Container(
                                width: 320,
                                padding: EdgeInsets.all(10.0),
                                child: TextField(
                                  autocorrect: false,
                                  /*   maxLength: 6,*/
                                  inputFormatters: [
                                    new LengthLimitingTextInputFormatter(6),
                                    // for mobile
                                  ],
                                  obscureText: _isHidden,
                                  obscuringCharacter: "*",
                                  style: TextStyle(
                                      color: Color(0xff055e8e),
                                      fontFamily: 'titlefont'),
                                  controller: updateuserpassword,
                                  decoration: InputDecoration(
                                    suffix: InkWell(
                                      onTap: _togglePasswordView,
                                      child: Icon(
                                        _isHidden
                                            ? Icons.visibility
                                            : Icons.visibility_off,
                                        color: Color(0xff055e8e),
                                      ),
                                    ),
                                    hintText: '******',
                                    prefixIcon: Icon(Icons.vpn_key_outlined),
                                    hintStyle: TextStyle(color: Colors.grey),
                                    filled: true,
                                    fillColor: Colors.white70,
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(12.0)),
                                      borderSide: BorderSide(
                                          color: Color(0xff055e8e), width: 2),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(10.0)),
                                      borderSide: BorderSide(
                                          color: Color(0xff055e8e), width: 2),
                                    ),
                                  ),
                                ))),
                        Padding(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            'Password must not be greater than 6 digits, Alphanumeric with special characters are applicable.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 11,
                                fontFamily: 'titlefont'),
                          ),
                        )
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
}

confirmationPopup(
    BuildContext dialogContext, String title, String msg, String okbtn) {
  var alertStyle = AlertStyle(
    animationType: AnimationType.grow,
    overlayColor: Colors.black87,
    isCloseButton: false,
    isOverlayTapDismiss: false,
    titleStyle: TextStyle(
        fontWeight: FontWeight.bold, fontSize: 18, fontFamily: 'titlefont'),
    descStyle: TextStyle(
        fontWeight: FontWeight.w500, fontSize: 16, fontFamily: 'titlefont'),
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
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontFamily: 'titlefont'),
          ),
          onPressed: () {
            Navigator.of(dialogContext).pop(null);
          },
          color: ReColors().appMainColor,
        ),
      ]).show();
}
