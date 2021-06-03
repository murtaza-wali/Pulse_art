import 'package:art/Menu/MainMenu.dart';
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

  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: new ReusableWidgets().getAppBar(appstring().login),
      body: Container(
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
                    controller: userpassword,
                    decoration: InputDecoration(
                      labelText:appstring().username,
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
                    controller: userpassword,
                    decoration: InputDecoration(
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
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Menu()),
                    );
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
          )),
    );
  }
}