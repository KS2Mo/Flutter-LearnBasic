import 'package:flutterapp/models/User.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final String IS_LOGIN = "is_login";
  static final String USERNAME = "username";

  Future<bool> isLogin() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    return _prefs.getBool(IS_LOGIN) ?? false;
  }

  Future<bool> login({User user}) async {
    if (user.username == "mo61250@gmail.com" && user.password == "password") {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString(USERNAME, user.username);
      _prefs.setBool(IS_LOGIN, true);
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.remove(IS_LOGIN);

    return await Future<void>.delayed(Duration(seconds: 1));
  }
}