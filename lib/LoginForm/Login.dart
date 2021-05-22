import 'package:art/HexCodeConverter/Hexcode.dart';
import 'package:art/Menu/MainMenu.dart';
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
  Color color2 = HexColor("#055e8e");

  Widget build(BuildContext buildContext) {
    return Scaffold(
      appBar: new ReusableWidgets().getAppBar('Login'),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: <Widget>[
            Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'Login',
                  style: TextStyle(
                      color: color2,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                )),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: TextField(
                controller: username,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'User Name'),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.center,
              child: TextField(
                controller: userpassword,
                decoration: InputDecoration(
                    border: OutlineInputBorder(), labelText: 'User Password'),
              ),
            ),
            FlatButton(
              onPressed: () {},
              child: Text('Forget Password?'),
              textColor: color2,
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
                textColor: Colors.white,
                child: Text('Login'),
                color: color2,
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Text('Does not have an account?'),
                  FlatButton(
                    onPressed: () {},
                    child: Text('Sign Up'),
                    textColor: color2,
                    // padding: EdgeInsets.fromLTRB(60, 10, 60, 10),
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
