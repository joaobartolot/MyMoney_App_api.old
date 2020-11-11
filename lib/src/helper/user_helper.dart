import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:mymoney_app/app_const.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserHelper {
  static Future<bool> userIsLogged() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    FirebaseUser user = await _auth.currentUser();

    return user != null;
  }
}
