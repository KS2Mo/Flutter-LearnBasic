import 'package:flutter/material.dart';
import 'package:validators/validators.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}



class User {
  User() {
    this.email = "";
    this.password = "";
    this.gender = "male";
    this.agreePolicy = false;
    this.receiveEmail = false;
    this.fname = "";
    this.lname = "";
  }

  String email;
  String password;
  String gender;
  bool agreePolicy;
  bool receiveEmail;
  String fname;
  String lname;
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final String appTitle = "Form Register";

    return MaterialApp(
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: Text(appTitle),
        ),
        body: CustomForm(),
      ),
    );
  }
}

class CustomForm extends StatefulWidget {
  @override
  _CustomFormState createState() => _CustomFormState();
}

class _CustomFormState extends State<CustomForm> {
  final _formKey = GlobalKey<FormState>();

  User user = User();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: _buildInputDecoration(
                    label: 'ชื่อ',
                    hint: 'ชื่อ',
                    icon: Icons.person),
                keyboardType: TextInputType.text,
                validator: _validateName,
                onSaved: (String value) {
                  user.fname = value;
                },
              ),
              TextFormField(
                decoration: _buildInputDecoration(
                    label: 'นามสกุล',
                    hint: 'นามสกุล',
                    icon: Icons.closed_caption),
                keyboardType: TextInputType.text,
                validator: _validateName,
                onSaved: (String value) {
                  user.lname = value;
                },
              ),
              TextFormField(
                decoration: _buildInputDecoration(
                    label: 'อีเมล์',
                    hint: 'example@gmail.com',
                    icon: Icons.email),
                keyboardType: TextInputType.emailAddress,
                validator: _validateEmail,
                onSaved: (String value) {
                  user.email = value;
                },
              ),
              TextFormField(
                decoration:
                _buildInputDecoration(label: 'รหัสผ่าน', icon: Icons.lock),
                obscureText: true,
                validator: _validatePassword,
                onSaved: (String value) {
                  user.password = value;
                },
              ),
              _buildGenderForm(),
              _buildReceiveEmailForm(),
              _buildAgreePolicyForm(),
              _buildSummitButton(),
            ],
          )),
    );
  }

  InputDecoration _buildInputDecoration(
      {String label, String hint, IconData icon}) {
    return InputDecoration(labelText: label, hintText: hint, icon: Icon(icon));
  }

  Widget _buildGenderForm() {
    final Color activeColor = Colors.blueAccent;

    return Container(
      margin: EdgeInsets.only(top: 12),
      child: Row(
        children: <Widget>[
          Text(
            "เพศ:",
            style: TextStyle(fontSize: 16),
          ),
          Radio(
              activeColor: activeColor,
              value: "male",
              groupValue: user.gender,
              onChanged: _handleRadioValueChange),
          Text("ชาย"),
          Radio(
              activeColor: activeColor,
              value: "female",
              groupValue: user.gender,
              onChanged: _handleRadioValueChange),
          Text("หญิง"),
        ],
      ),
    );
  }

  Widget _buildReceiveEmailForm() {
    return Row(
      children: <Widget>[
        Text(
          "ต้องการรับอีเมล์?:",
          style: TextStyle(fontSize: 16),
        ),
        Switch(
            activeColor: Colors.blueAccent,
            value: user.receiveEmail,
            onChanged: (select) {
              setState(() {
                user.receiveEmail = select;
              });
            }),
      ],
    );
  }

  Widget _buildSummitButton() {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(top: 4),
      child: RaisedButton(
        color: Colors.blue,
        onPressed: _submit,
        child: Text(
          "Submit",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildAgreePolicyForm() {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 16),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Checkbox(
            value: user.agreePolicy,
            activeColor: Colors.orange,
            onChanged: (value) {
              setState(() {
                user.agreePolicy = value;
              });
            },
          ),
          Text("ฉันยอมรับเงื่อนไข "),
          GestureDetector(
            onTap: _launchURL,
            child: Text(
              'ข้อกำหนด.',
              style: TextStyle(
                  color: Colors.blue, decoration: TextDecoration.underline),
            ),
          )
        ],
      ),
    );
  }

  void _handleRadioValueChange(value) {
    print('value: ${value}');
    setState(() {
      user.gender = value;
    });
  }


  String _validateName(String value) {
    if (value.isEmpty) {
      return "กรุณากรอกชื่อ-นามสกุล";
    }
  }


  String _validateEmail(String value) {
    if (value.isEmpty) {
      return "กรุณากรอกอีเมล์";
    }

    if (!isEmail(value)) {
      return "The Email must be a valid email.";
    }
  }

  String _validatePassword(String value) {
    if (value.length < 8) {
      return 'รหัสผ่านต้องมีไม่ตำกว่า 8 ตัวอักษร.';
    }
  }

  void _submit() {
    if (this._formKey.currentState.validate()) {
      if (user.agreePolicy == false) {
        showAlertDialog();
      } else {
        _formKey.currentState.save();

        print("Email: ${user.email}");
        print("Password: ${user.password}");
        print("Gender: ${user.gender}");
        print("Receive Email: ${user.receiveEmail}");
        print("Agree Policy: ${user.agreePolicy}");
      }
    }
  }

  void showAlertDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Title"),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text("Detail1"),
                Text("Detail2"),
                Text("Detail3"),
                Icon(Icons.directions_walk)
              ],
            ),
          ),
          actions: <Widget>[
            IconButton(
              onPressed: null,
              icon: Icon(
                Icons.cake,
                color: Colors.blue,
              ),
            ),
            FlatButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Close"))
          ],
        );
      },
    );
  }

  _launchURL() async {
    const url = 'https://www.cylog.org';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}

