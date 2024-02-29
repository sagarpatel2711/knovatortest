import 'package:shared_preferences/shared_preferences.dart';

class LocalDB {
  final accessTokenKey = "token";

  Future<bool> saveToken(String tokenvalue) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setString(accessTokenKey, tokenvalue);
  }

  Future<String?> getToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getString(accessTokenKey);
  }

  Future<bool> removeToken() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.remove(accessTokenKey);
  }
}
