import 'package:flutter/material.dart';
import 'package:flutterapp/services/AuthService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget{
  @override
  _LoginState createState() => _LoginState();
}
const PrimaryColor = const Color(0xFFBF360C);
class _LoginState extends State<Home> {
  AuthService authService = AuthService();
  List<String> _dummy = List<String>.generate(20, (index) => "Row: ${index}");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: PrimaryColor,
        title: Text("Home"),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.search,
            ),
            onPressed: () async {
            },
          ),
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
            ),
            onPressed: () {
              _showAlertLogout();
            },
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/bg.png"),
              fit: BoxFit.cover,
            )
          ),
          child: _listSection(),
        ),


    );

  }

  Widget _listSection() => ListView.builder(
    itemCount: _dummy.length,
        itemBuilder: (context,index){
          /*
          if(index==0) {
              return _headerImageSection();
          }
          */

          return Card(
            margin: EdgeInsets.only(bottom: 10, right: 20, left: 20),
            child: Column(children: <Widget>[
              _headerSectionCard(),
              _bodySectionCard(),
              _footerSectionCard(),
            ],),
        );
    });

  Widget _headerImageSection() {
    return Padding(
      padding: EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
      child: Image.asset(
        'assets/header_home.png',
        height: 50,
      ),
    );
  }

  Widget _headerSectionCard() => ListTile(
    leading: Container(
      height: 50,
      width: 50,
      child:  ClipOval(
        child: Image.network(
          "https://images.all-free-download.com/images/graphiclarge/winnie_the_pooh_pooh_020_52359.jpg"
          ,fit: BoxFit.cover,
        ),
      ),
    ),
    title: Text(
      "KS2Mo",
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: TextStyle(fontWeight:FontWeight.w600,fontSize: 18),
    ),
    subtitle: Text(
      "Learning Flutter",
      maxLines: 1,
    ),
  );
  Widget _bodySectionCard() => Image.network(
    "https://hansasamoonsite.files.wordpress.com/2014/05/winnie-the-pooh-friends-winnie-the-pooh-1993022-1024-768.jpg?w=300",
    fit: BoxFit.cover,
  );
  Widget _footerSectionCard() => Row(
    children: <Widget>[
      _customFlatButton(icon: Icons.person,label: "Like"),
      _customFlatButton(icon: Icons.share,label: "Share"),
    ],
  );

  Widget _customFlatButton({IconData icon, String label, String text}) {
    return FlatButton(
      child: Row(
        children: <Widget>[
          Icon(icon),
          SizedBox(
            width: 8,
          ),
          Text(label),
        ],
      ),
      onPressed: () {
        print(text);
      },
    );
  }

  Future _showAlertLogout() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("${_prefs.getString(AuthService.USERNAME)} to Logout."),
            content: Text("Are you sure?"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  authService.logout();
                  Navigator.pushNamedAndRemoveUntil(
                      context, '/login', (Route<dynamic> route) => false);
                },
                child: Text("Yes"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("No"),
              )
            ],
          );
        });
  }



}