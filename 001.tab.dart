import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'แจ้งส่งเอกสาร', icon: Icons.contact_mail),
  const Choice(title: 'แจ้งงาน IT', icon: Icons.assistant),
  const Choice(title: 'แจ้งซ่อม', icon: Icons.assignment_turned_in),
  const Choice(title: 'แจ้งงาน HR', icon: Icons.ac_unit),
];

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String appTitle = "แจ้งงานบริการ";

    return MaterialApp(
        title: appTitle,
        home: DefaultTabController(
          // initialIndex: 2,
          length: choices.length,
          child: Scaffold(
              appBar: AppBar(
                title: Text(appTitle),
//                bottom: TabBar(
////                  unselectedLabelColor: Colors.black,
////                  indicatorWeight: 20,
////                  indicatorColor: Colors.black,
////                  labelColor: Colors.green,
//                  isScrollable: true,
//                  onTap: (index) {
//                    print("index: ${index}");
//                  },
//                  tabs: choices.map((Choice choice) {
//                    return Tab(
//                      text: choice.title,
//                      icon: Icon(choice.icon),
////                      child: Row(
////                        children: <Widget>[
////                          Icon(choice.icon),
////                          Container(
////                            margin: EdgeInsets.only(left: 8),
////                            child: Text(choice.title),
////                          )
////                        ],
////                      ),
//                    );
//                  }).toList(),
//                )
              ),
              body: TabBarView(
                  children: choices.map((Choice choice) {
                    return Center(
                      child: Text(choice.title + " By KS2Mo"),
                    );
                  }).toList()),
              bottomNavigationBar: SafeArea(
                child: Container(
                    color: Theme.of(context).primaryColor,
                    child: TabBar(
                      isScrollable: true,
                      onTap: (index) {
                        print("index: ${index}");
                      },
                      tabs: choices.map((Choice choice) {
                        return Tab(
                          text: choice.title,
                          icon: Icon(choice.icon),
                        );
                      }).toList(),
                    )),
              )),
        ));
  }
}
