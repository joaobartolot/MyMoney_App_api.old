import 'package:shared_preferences/shared_preferences.dart';

class UserHelper {
  static Future<bool> userIsLogged() async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.getString('token_key') != null;
  }
}
