import 'package:art/HexCodeConverter/Hexcode.dart';
import 'package:art/Gatepass/GatepassMenu.dart';
import 'package:art/eApproval/eApprovalMenu.dart';
import 'package:art/ReuseableWidget/ReuseGradient.dart';
import 'package:art/ReuseableWidget/appbar.dart';
import 'package:flutter/material.dart';

class Menu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ArtMenu();
}

class _ArtMenu extends State<Menu> {
  int counter = 10;
  Color color2 = HexColor("#055e8e");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu'),

        actions: <Widget>[
          // Using Stack to show Notification Badge
          new Stack(
            children: <Widget>[
              new IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () {
                    setState(() {
                      counter = 0;
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
                          '$counter',
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
      body: SafeArea(
        child: Center(
          child: Container(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // first row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: InkWell(
                            onTap: () {
                              print("Card Clicked");
                            },
                            child: Card(
                              // semanticContainer: true,
                              // yeh shadow dekhata hai
                              // clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: Container(
                                height: 150,
                                width: 150,
                                decoration: new ReuseGradient().getgradient(),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Container(
                                      child: Center(
                                        child: IconButton(
                                          iconSize: 100,
                                          icon: Image.asset(
                                            "assets/images/eapprovals.png",
                                          ),
                                          onPressed: () {
                                            print("Card Clicked1");
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      eApproval()),
                                            );
                                          },
                                        ),
                                        // child: Icon(
                                        //   Icons.mobile_friendly_sharp,
                                        //   color: Colors.blue,
                                        //   size: 50,
                                        // ),
                                      ),
                                    ),
                                    Text(
                                      "e Approval",
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
                        ),
                      ),
                      Expanded(
                          child: Container(
                        child: Card(
                          semanticContainer: true,
                          // yeh shadow dekhata hai
                          // clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: new ReuseGradient().getgradient(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Center(
                                    child: IconButton(
                                      iconSize: 100,
                                      icon: Image.asset(
                                        "assets/images/gatekeep_logo.png",
                                      ),
                                      onPressed: () {
                                        print("Card Clicked1");
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Gatepass()),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                Text(
                                  "Gate Pass",
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
                      ))
                    ],
                  ),
                  // second row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Card(
                            semanticContainer: true,
                            // yeh shadow dekhata hai
                            // clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: new ReuseGradient().getgradient(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Center(
                                      child: IconButton(
                                        iconSize: 100,
                                        icon: Image.asset(
                                          "assets/images/denim.png",
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Denim",
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
                      ),
                      Expanded(
                          child: Container(
                        child: Card(
                          semanticContainer: true,
                          // yeh shadow dekhata hai
                          // clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: new ReuseGradient().getgradient(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Center(
                                    // set Images in this tag
                                    child: IconButton(
                                      iconSize: 100,
                                      icon: Image.asset(
                                        "assets/images/jarvis.png",
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                                // Text in this tag....
                                Text(
                                  "J.A.R.V.I.S",
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
                      ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Card(
                            semanticContainer: true,
                            // yeh shadow dekhata hai
                            // clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: new ReuseGradient().getgradient(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Center(
                                      child: IconButton(
                                        iconSize: 100,
                                        icon: Image.asset(
                                          "assets/images/tcrm.png",
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Tex CRM",
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
                      ),
                      Expanded(
                          child: Container(
                        child: Card(
                          semanticContainer: true,
                          // yeh shadow dekhata hai
                          // clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: new ReuseGradient().getgradient(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Center(
                                    child: IconButton(
                                      iconSize: 100,
                                      icon: Image.asset(
                                        "assets/images/isupplier.png",
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                                Text(
                                  "Supply Chain",
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
                      ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          child: Card(
                            semanticContainer: true,
                            // yeh shadow dekhata hai
                            // clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: new ReuseGradient().getgradient(),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Container(
                                    child: Center(
                                      child: IconButton(
                                        iconSize: 100,
                                        icon: Image.asset(
                                          "assets/images/denimcosting.png",
                                        ),
                                        onPressed: () {},
                                      ),
                                    ),
                                  ),
                                  Text(
                                    "Fabric Precosting",
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
                      ),
                      Expanded(
                          child: Container(
                        child: Card(
                          semanticContainer: true,
                          // yeh shadow dekhata hai
                          // clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: Container(
                            height: 150,
                            width: 150,
                            decoration: new ReuseGradient().getgradient(),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  child: Center(
                                    child: IconButton(
                                      iconSize: 100,
                                      icon: Image.asset(
                                        "assets/images/dam.png",
                                      ),
                                      onPressed: () {},
                                    ),
                                  ),
                                ),
                                Text(
                                  "DAM",
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
                      ))
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
