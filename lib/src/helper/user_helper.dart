import 'package:mymoney_app/app_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHelper {
  static Future<bool> userIsLogged() async {
    var prefs = await SharedPreferences.getInstance();

    var response = prefs.getString('token_key');
    print('This is the token: $response');
    return response != null;
  }

  static Future<String> getUserToken() async {
    var prefs = await SharedPreferences.getInstance();

    return prefs.getString(token_key);
  }
}
