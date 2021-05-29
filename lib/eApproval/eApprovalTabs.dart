import 'package:art/HexCodeConverter/Hexcode.dart';
import 'package:art/eApproval/eApprovalMenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoriesModel {
  String _name = "";
  String _description = "";
  String _status = "";

  CategoriesModel(String name, String description, String status) {
    this._name = name;
    this._description = description;
    this._status = status;
  }
}

class CategoryRepository {
  Future<List<CategoriesModel>> findAllAsync() {
    return Future.value([
      //adding all the categories of news in the list
      new CategoriesModel(
          'Junaid Khan', "Leave for 15 days holiday", "Pending"),
      new CategoriesModel('Farhad Naseem', "Testing Machine", "Approved"),
      new CategoriesModel('Ali Zafar', "Medical Leave", "Pending"),
      new CategoriesModel('Batool', "Laptop for HR Manager", "Reject"),
      new CategoriesModel('Farhan', "New Scanner for IT Department", "Reject"),
      new CategoriesModel('Subhan', "Emergency Leave", "Reject"),
      new CategoriesModel('Omar Khalid', "Buying Laptop", "Pending"),
      new CategoriesModel('Danish Aslam', "Expense for stock", "Approved")
    ]);
  }
}

class Eapproval extends StatefulWidget {
  @override
  _EapprovalState createState() => _EapprovalState();
}

class _EapprovalState extends State<Eapproval> {
  Color color2 = HexColor("#055e8e");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: choices.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Approval'),
            automaticallyImplyLeading: true, // hides default back button
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.topRight,
                  colors: [color2, Colors.black],
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
  const Choice({required this.title});

  final String title;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'All'),
  const Choice(title: 'Approved'),
  const Choice(title: 'Reject'),
  const Choice(title: 'Pending'),
];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key? key, required this.choice}) : super(key: key);

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
      return ListTile(
          trailing: Text(
            category._status,
            style: TextStyle(color: Colors.green, fontSize: 15),
          ),
          title: Text(category._name),
          subtitle: Text(category._description),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => eApproval()),
            );
          });
    } else if (choice.title == 'All') {
      print('status: ${category._status}');
      print('description: ${category._description}');
      return ListTile(
          trailing: Text(
            category._status,
            style: TextStyle(color: Colors.green, fontSize: 15),
          ),
          title: Text(category._name),
          subtitle: Text(category._description),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => eApproval()),
            );
          });
    } else {
      return Container();
    }
  }
}
