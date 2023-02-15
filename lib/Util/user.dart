import 'package:shared_preferences/shared_preferences.dart';

class User {
  static getUserId() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.get('id');
  }

  static getUserMode() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.get('mode');
  }

  static getIsLogin() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.get('isLogin');
  }

  static setUserId(String id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString('id', id);
  }

  static setUserMode(String mode) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setString('mode', mode);
  }

  static setIsLogin(bool isLogin) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.setBool('isLogin', isLogin);
  }
}
