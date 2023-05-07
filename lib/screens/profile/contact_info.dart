import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import '../../env.dart';
import '../../models/user_model.dart';
import '../../widgets/custom_button.dart';
import 'package:http/http.dart' as http;

class ContactInformation extends StatefulWidget {
  const ContactInformation({Key? key}) : super(key: key);

  @override
  State<ContactInformation> createState() => _ContactInformationState();
}

class _ContactInformationState extends State<ContactInformation> {
  final TextEditingController _phonecontroller = TextEditingController();

  int? uid;

  bool isLoading = false;

  // function check if user is logged in
  Future _isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getInt("uid");
    });

    // print(uid);
  }

  // User object to use throughout page
  User? user;

  // get user details
  Future _getUserDetails() async {
    var url = Uri.parse("${Env.URL_ENDPOINT_USERS}/read_single.php?id=$uid");
    var response = await http.get(
      url,
      headers: {"Accept": "application/json"},
    );

    var res = jsonDecode(response.body);

    // get user in user object
    Map<String, dynamic> userMap = res;
    User userObj = User.fromJson(userMap);

    // print(user.email);
    setState(() {
      user = userObj;
    });

    // print(user!.email);
  }

  // update user details
  Future _updateDetails() async {
    var data = jsonEncode({
      "user_id": uid,
      "user_phone": _phonecontroller.text,
    });
    var url = Uri.parse("${Env.URL_ENDPOINT_USERS}/update_contact_info.php");
    var response = await http.post(
      url,
      body: data,
      headers: {
        'Content-Type': 'application/json',
        "Accept": "application/json",
      },
    );
    var res = jsonDecode(response.body);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _isLoggedIn().whenComplete(() {
      _getUserDetails().whenComplete(() {
        _phonecontroller.text = user!.phone!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: kDefaultBackground,
        ),
        title: const Text(
          'Contact Information',
          style: TextStyle(color: kDefaultBackground),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: TextFormField(
                  controller: _phonecontroller,
                  decoration: InputDecoration(
                    label: const Text('Phone Number'),
                    labelStyle: TextStyle(color: inactiveColor),
                    hintText: 'Phone Number',
                    hintStyle: TextStyle(
                      color: inactiveColor,
                      fontWeight: FontWeight.w600,
                    ),
                    prefixIcon: Icon(
                      Icons.phone,
                      color: inactiveColor.withOpacity(0.2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: inactiveColor),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: inactiveColor),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: kDarkTextColor.withOpacity(0.3),
                      ),
                    ),
                  ),
                ),
              ),
              // Spacer(),
              // Spacer(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: CustomButton(
            onPressed: () async {
              await _updateDetails();
            },
            btnName: 'Update Contact Information'),
      ),
    );
  }
}
