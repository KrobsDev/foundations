import 'dart:convert';
import 'dart:developer';

import 'package:shared_preferences/shared_preferences.dart';

class UserDetailsController {
  static Future saveUserDetails({required credentials}) async {
    // instance of shared preference
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    // print(jsonDecode(credentials));
    // var userDetails = jsonDecode(credentials);
    // store
    // log(credentials);
    // print(credentials['data']["user_id"].runtimeType);
    // print(userDetails);
    await _prefs.setInt("uid", credentials['data']['user_id']);
    await _prefs.setString("email", credentials['data']['user_email']);
  }
}
