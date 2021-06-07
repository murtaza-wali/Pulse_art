import 'package:art/InternetConnection/Offline.dart';
import 'package:art/LocalStorage/MySharedPref.dart';
import 'package:art/Menu/MainMenuPopup.dart';
import 'package:art/Model/LoginAuthenticationModel.dart';
import 'package:art/Model/LoginUser.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableValues/ReStrings.dart';
import 'package:art/ReuseableWidget/GradientBG.dart';
import 'package:art/ReuseableWidget/ReuseButton.dart';
import 'package:art/ReuseableWidget/appbar.dart';
import 'package:back_button_interceptor/back_button_interceptor.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Login extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<Login> {
  final focus = FocusNode();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController username = new TextEditingController();
  TextEditingController userpassword = new TextEditingController();
  List<Item> _users;
  String p_user;
  String p_psw;
  LoginAuth loginAuth;
  Item item;
  bool _isHidden = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _users = [];
    loginAuth = new LoginAuth();
    item = new Item();
  }

  void _togglePasswordView() {
    setState(() {
      _isHidden = !_isHidden;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: new ReusableWidgets().getLoginAppBar(appstring().login),
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
                    style: TextStyle(color: Colors.white),
                    controller: username,
                    decoration: InputDecoration(
                      labelText: appstring().username,
                      labelStyle: TextStyle(color: Colors.white),
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
                    style: TextStyle(color: Colors.white),
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
                      labelStyle: TextStyle(color: Colors.white),
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
                FlatButton(
                  onPressed: () {},
                  child: Text(appstring().forget_psw),
                  textColor: Colors.white,
                ),
                ReuseButton(
                  buttonText: appstring().login,
                  onPressed: ()
                  {
                    loginAuth
                        .getLoginUser(username.text, userpassword.text)
                        .then((users) {
                      setState(() {
                        //list of user
                        _users = users;
                        if (_users == null) {
                          confirmationPopup(context, 'Error',
                              'Please fill the required field.', 'OK');

                        } else if (_users.length==0) {
                          confirmationPopup(
                              _scaffoldKey.currentContext,
                              "Error",
                              'Enter a valid Username and Password',
                              "Ok");
                        }
                      });
                      item = _users[0];

                      if (item != null) {

                        int userID = item.userId;
                        String name = item.empname;
                        MySharedPreferences.instance
                            .setIntValue("UserId", userID);
                        MySharedPreferences.instance
                            .setStringValue("Username", name);
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (BuildContext context) => MainMenuPopUp()),
                                (Route<dynamic> route) => false
                        );
                      }
                    });

                  },
                ),
                /* Container(
              child: Row(
                children: <Widget>[
                  Text('Does not have an account?'),
                  FlatButton(
                    onPressed: () {},
                    child: Text('Sign Up'),
                    textColor: Colors.white,
                    // padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            )*/
              ],
            ),
          ))),
    );
  }

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
