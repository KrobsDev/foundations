import 'dart:convert';
import 'dart:developer';

import 'package:foundations/env.dart';
import 'package:http/http.dart' as http;

class AuthController {
  // function to communicate with api
  Future<dynamic> authenticate({required Map<String, String> formData}) async {
    // print(formData);
    try {
      var response = await http.post(
        Uri.parse('${Env.URL_ENDPOINT_USERS}/login.php'),
        body: jsonEncode(formData),
      );

      Map<String, dynamic> result = jsonDecode(response.body);

      // print(result);

      if (result["status"] == 1) {
        // login successful
        log('login successful');
        return result;
      }

      log('login failed');
      return "Something went wrong";
      // // else {
      // //   return "Something went wrong";
      // // }

      // return "Something went wrong";
    } catch (e) {
      return "An error occured";
    }
  }
}
