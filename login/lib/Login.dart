import 'package:flutter/material.dart';
import 'package:flutterapp/models/User.dart';
import 'package:flutterapp/services/AuthService.dart';
import 'package:validators/validators.dart';

class Login extends StatefulWidget{
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  AuthService authService = AuthService();
  User user = User();
  FocusNode passwordFocusNode = FocusNode();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bg.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          ListView(
            children: <Widget>[
              _buildForm(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildForm() => Card(
    margin: EdgeInsets.only(top: 80, left: 30, right: 30),
    color: Colors.white,
    child: Padding(
      padding: EdgeInsets.all(20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            _logo(),
            SizedBox(
              height: 22,
            ),
            _buildUsernameInput(),
            SizedBox(
              height: 8,
            ),
            _buildPasswordInput(),
            SizedBox(
              height: 28,
            ),
            _buildSubmitButton(),
            _buildForgotPasswordButton(),
          ],
        ),
      ),
    ),
  );

  Widget _logo() => Image.asset(
    "assets/header_main.png",
    fit: BoxFit.cover,
  );

  Widget _buildUsernameInput() => TextFormField(
    decoration: InputDecoration(
      labelText: 'Email',
      hintText: 'example@gmail.com',
      icon: Icon(Icons.email),
    ),
    keyboardType: TextInputType.emailAddress,
    validator: _validateEmail,
    onSaved: (String value) {
      user.username = value;
    },
    onFieldSubmitted: (String value) {
      FocusScope.of(context).requestFocus(passwordFocusNode);
    },
  );

  Widget _buildPasswordInput() => TextFormField(
    decoration: InputDecoration(
      labelText: 'Password',
      icon: Icon(Icons.lock),
    ),
    obscureText: true,
    validator: _validatePassword,
    focusNode: passwordFocusNode,
    onSaved: (String value) {
      user.password = value;
    },
  );

  Widget _buildSubmitButton() => Container(
    width: MediaQuery.of(context).size.width,
    child: RaisedButton(
      color: Colors.black87,
      onPressed: _submit,
      child: Text(
        "Login".toUpperCase(),
        style: TextStyle(color: Colors.white),
      ),
    ),
  );

  Widget _buildForgotPasswordButton() => FlatButton(
    onPressed: () {},
    splashColor: Colors.blue.shade500,
    child: Text(
      "Forgot password?",
      style: TextStyle(color: Colors.black54),
    ),
  );

  String _validateEmail(String value) {
    if (value.isEmpty) {
      return "The Email is Empty";
    }
    /*if (!isEmail(value)) {
      return "The Email must be a valid email.";
    }*/
    return null;
  }

  String _validatePassword(String value) {
    if (value.length < 8) {
      return 'The Password must be at least 8 charactors.';
    }
    return null;
  }

  void _submit()  {
    if (this._formKey.currentState.validate()) {
      _formKey.currentState.save();
      authService.login(user: user).then(
            (result) async {
          if (result) {
            Navigator.pushReplacementNamed(context, '/home');
          } else {
            showAlertDialog();
          }
        },
      );
    }
  }

  void showAlertDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text("Username or Password is incorrect"),
          content: Text("Please try again."),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            )
          ],
        );
      },
    );
  }

}