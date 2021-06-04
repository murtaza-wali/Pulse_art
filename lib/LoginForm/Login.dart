import 'dart:math';

import 'package:art/InternetConnection/Offline.dart';
import 'package:art/LocalStorage/LocalStorage.dart';
import 'package:art/Menu/MainMenu.dart';
import 'package:art/Model/LoginAuthenticationModel.dart';
import 'package:art/Model/LoginUser.dart';
import 'package:art/ReuseableValues/ReStrings.dart';
import 'package:art/ReuseableWidget/GradientBG.dart';
import 'package:art/ReuseableWidget/ReuseButton.dart';
import 'package:art/ReuseableWidget/appbar.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  // This widget is the root of your application.
  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<Login> {
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

  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: new ReusableWidgets().getAppBar(appstring().login),
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
                  ),
                ),
                FlatButton(
                  onPressed: () {},
                  child: Text(appstring().forget_psw),
                  textColor: Colors.white,
                ),
                ReuseButton(
                  buttonText: appstring().login,
                  onPressed: () {
                    // LoginAuth().getLoginUser(username.text, userpassword.text);
                    loginAuth
                        .getLoginUser(username.text, userpassword.text)
                        .then((users) {
                      setState(() {
                        //list of user
                        _users = users;
                        showAlertDialog(context, 'You must fill correct data.', "Error" , "Ok");
                        print('_users.len ${_users}');
                      });
                      item = _users[0];
                      print('_users.len ${item}');
                      print('_users ${item.userId}');
                      int userID = item.userId;
                      LocalStorage().userIdSet(userID);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Menu()),
                      );
                    });

                    /* Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Menu()),
                    );*/
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
showAlertDialog(BuildContext context, String message, String heading, String buttonCancelTitle) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text(buttonCancelTitle),
    onPressed: () {
      Navigator.pop(context, null);
    },
  );
  /*Widget continueButton = FlatButton(
    child: Text(buttonAcceptTitle),
    onPressed: () {

    },
  );*/

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(heading),
    content: Text(message),
    actions: [
      cancelButton,
      // continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}