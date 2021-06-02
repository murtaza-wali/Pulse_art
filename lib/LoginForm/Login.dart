import 'package:art/HexCodeConverter/Hexcode.dart';
import 'package:art/Menu/MainMenu.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/ReuseableWidget/GradientBG.dart';
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
      appBar: new ReusableWidgets().getAppBar('Login'),
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
                      labelText: "Username",
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
                      labelText: "Password",
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
                  child: Text('Forget Password?'),
                  textColor: Colors.white,
                ),
                Container(
                  padding: EdgeInsets.fromLTRB(40, 0, 40, 0),
                  child: FlatButton(
                    onPressed: () {
                      // yahan click listner define hoga
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Menu()),
                      );
                    },
                    textColor: ReColors().appMainColor,
                    child: Text('Login'),
                    color: Colors.white,
                  ),
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
