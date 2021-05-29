import 'package:art/Gatepass/GatepassMenu.dart';
import 'package:art/HexCodeConverter/Hexcode.dart';
import 'package:art/Model/MenuModel.dart';
import 'package:art/eApproval/eApprovalMenu.dart';
import 'package:art/eApproval/eApprovalTabs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_offline/flutter_offline.dart';

class Menu extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new _ArtMenu();
}

class _ArtMenu extends State<Menu> {
  int counter = 10;
  List<MenuModel> categoriesList = [];
  Color color2 = HexColor("#055e8e");

  @override
  void initState() {
    categoriesList = new MenuModel("", "").loadCategories();
    super.initState();
  }

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
        body: OfflineBuilder(
          connectivityBuilder: (BuildContext context,
              ConnectivityResult connectivity, Widget child) {
            final bool connected = connectivity != ConnectivityResult.none;
            return Stack(
              fit: StackFit.expand,
              children: [
                child,
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  height: 32.0,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    color: connected ? Color(0xFFFFFFF) : Color(0xFFEE4400),
                    child: connected
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              /*Text(
                                "ONLINE",
                                style: TextStyle(color: Colors.white),
                              ),*/
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                "OFFLINE",
                                style: TextStyle(color: Colors.white),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                            ],
                          ),
                  ),
                ),
              ],
            );
          },
          child: GridView.count(
            // Create a grid with 2 columns. If you change the scrollDirection to
            // horizontal, this would produce 2 rows.
            crossAxisCount: 2,
            // Generate 100 Widgets that display their index in the List
            children: List.generate(categoriesList.length, (index) {
              return Container(
                child: InkWell(
                  onTap: () {
                    print(categoriesList[index].title);
                    if (categoriesList[index].title == 'E-Approval') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Eapproval()),
                      );
                    } else if (categoriesList[index].title == 'GatePass') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Gatepass()),
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
                        boxShadow: <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(1.0, 15.0),
                            blurRadius: 20.0,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Container(
                            child: Center(
                              child: Image(
                                width: 100,
                                height: 100,
                                image: AssetImage(categoriesList[index].image),
                              ),
                              // child: Icon(
                              //   Icons.mobile_friendly_sharp,
                              //   color: Colors.blue,
                              //   size: 50,
                              // ),
                            ),
                          ),
                          Text(
                            categoriesList[index].title,
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
        ));
  }
}
