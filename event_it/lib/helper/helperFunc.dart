import 'package:shared_preferences/shared_preferences.dart';

class helperFun {
  static String userLoggedInKey = "LOGGEDINKEY";
  static String userNameKey = "USERNAMEKEY";
  static String userEmailKey = "USEREMAILKEY";
  //saving the data to SP
  static Future<bool?> saveUserLoggedInStatus(bool isUserLoggedIn) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.setBool(userLoggedInKey, isUserLoggedIn);
  }

  static Future<bool?> saveUserNameSp(String userName) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.setString(userNameKey, userName);
  }

  static Future<bool?> saveUserEmailSp(String userEmail) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return await sp.setString(userEmailKey, userEmail);
  }

  //getting the data from SP
  static Future<bool?> getUserLoggedInStatus2() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getBool(userLoggedInKey);
  }

  static Future<String?> getUsernameSp() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(userNameKey);
  }

  static Future<String?> getUserEmailSp() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    return sp.getString(userEmailKey);
  }
}
