import 'package:mymoney_app/app_const.dart';
import 'package:mymoney_app/src/api/api_base_helper.dart';
import 'package:mymoney_app/src/model/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication {
  final String _endpoint = 'token-auth';

  ApiBaseHelper _helper = ApiBaseHelper();

  Future<User> fetchUser(String username, String password) async {
    final response = await _helper
        .post(_endpoint, {'username': username, 'password': password});

    var user = User.fromJson(response);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(token_key, user.token);
    return user;
  }
}
