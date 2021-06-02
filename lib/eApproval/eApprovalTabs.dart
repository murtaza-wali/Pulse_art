import 'package:art/HexCodeConverter/Hexcode.dart';
import 'package:art/ReuseableValues/ReColors.dart';
import 'package:art/eApproval/eApprovalMenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriesModel {
  String _name = "";
  String _description = "";
  String _status = "";
  String _type = "";

  CategoriesModel(String name, String description, String status, String type) {
    this._name = name;
    this._description = description;
    this._status = status;
    this._type = type;
  }
}

class CategoryRepository {
  Future<List<CategoriesModel>> findAllAsync() {
    return Future.value([
      //adding all the categories of news in the list
      new CategoriesModel(
          'Junaid Khan', "Leave for 15 days holiday", "Open", "Requisition"),
      new CategoriesModel('Farhad Naseem', "Testing Machine", "Approved", "PO"),
      new CategoriesModel('Ali Zafar', "Medical Leave", "Open", "Requisition"),
      new CategoriesModel(
          'Batool', "Laptop for HR Manager", "Reject", "Journal Batch"),
      new CategoriesModel(
          'Farhan', "New Scanner for IT Department", "Reject", "Requisition"),
      new CategoriesModel('Subhan', "Emergency Leave", "Reject", "PO"),
      new CategoriesModel(
          'Omar Khalid', "Buying Laptop", "Open", "Journal Batch"),
      new CategoriesModel(
          'Danish Aslam', "Expense for stock", "Approved", "Journal Batch")
    ]);
  }
}

class Eapproval extends StatefulWidget {
  @override
  _EapprovalState createState() => _EapprovalState();
}

class _EapprovalState extends State<Eapproval> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: choices.length,
        child: Scaffold(
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
                    padding: const EdgeInsets.all(8.0), child: Text('Worklist'))
              ],
            ),
            automaticallyImplyLeading: true, // hides default back button
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [ReColors().appMainColor, Colors.black],
                ),
              ),
            ),
            bottom: TabBar(
              isScrollable: true,
              tabs: choices.map((Choice choice) {
                return Tab(
                  text: choice.title,
                );
              }).toList(),
            ),
          ),
          body: TabBarView(
            children: choices.map((Choice choice) {
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: ChoiceCard(
                  choice: choice,
                  key: null,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class Choice {
  const Choice({ this.title});

  final String title;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Open'),
  const Choice(title: 'Approved'),
  const Choice(title: 'Reject'),
  const Choice(title: 'All'),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key,  this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder<List<CategoriesModel>>(
      future: CategoryRepository().findAllAsync(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return buildListView(snapshot.data);
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }

  ListView buildListView(final categories) {
    return ListView.builder(
      // ignore: unnecessary_null_comparison
      itemCount: categories == null ? 0 : categories.length,
      itemBuilder: (BuildContext ctx, int index) {
        return listText(categories[index], ctx);
      },
    );
  }

  Widget listText(CategoriesModel category, BuildContext context) {
    if (category._status == choice.title) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => eApproval()),
              );
            },
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(category._name,
                            style:
                                TextStyle(color: Colors.black, fontSize: 15)),
                        Text(category._description,
                            style: TextStyle(color: Colors.grey, fontSize: 15)),
                        Text(category._type,
                            style: TextStyle(color: Colors.grey, fontSize: 15)),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(category._status,
                        style: TextStyle(color: Colors.green, fontSize: 15)),
                    // Text("Not Received"),
                  ],
                ),
              ],
            ),
          )
          // Text("Pay on: Wed, May 08 2019"),
        ],
      );
    } else if (choice.title == 'All') {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Text("Pay on: Wed, May 08 2019"),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => eApproval()),
              );
            },
            child: Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(category._name,
                            style:
                                TextStyle(color: Colors.black, fontSize: 15)),
                        Text(category._description,
                            style: TextStyle(color: Colors.grey, fontSize: 15)),
                        Text(category._type,
                            style: TextStyle(color: Colors.grey, fontSize: 15)),
                      ],
                    ),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(category._status,
                        style: TextStyle(color: Colors.green, fontSize: 15)),
                    // Text("Not Received"),
                  ],
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      return Container();
    }
  }
}
