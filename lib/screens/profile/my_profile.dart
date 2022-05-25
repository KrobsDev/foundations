import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:foundations/widgets/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants.dart';
import 'package:image_picker/image_picker.dart';

import '../../env.dart';
import '../../models/user_model.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  State<MyProfile> createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  final TextEditingController _fnamecontroller = TextEditingController();
  final TextEditingController _lnamecontroller = TextEditingController();

  final ImagePicker _picker = ImagePicker();
  File? imageFile;

  _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        imageFile = File(image.path);
      });
    }
  }

  String? uid;

  bool isLoading = false;

  // function check if user is logged in
  Future _isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      uid = prefs.getString("uid");
    });

    // print(uid);
  }

  // User object to use throughout page
  User? user;

  // get user details
  Future _getUserDetails() async {
    var url = Uri.parse("${Env.URL_PREFIX_USERS}/read_single.php?id=$uid");
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
      "user_fname": _fnamecontroller.text,
      "user_lname": _lnamecontroller.text,
    });
    var url = Uri.parse("${Env.URL_PREFIX_USERS}/update_user.php");
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
        _fnamecontroller.text = user!.fname!;
        _lnamecontroller.text = user!.lname!;
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
          'My Profile',
          style: TextStyle(color: kDefaultBackground),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(),
                Positioned(
                  top: 20,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.grey,
                      backgroundImage: imageFile != null
                          ? Image.file(
                              imageFile!,
                              fit: BoxFit.fill,
                              width: double.infinity,
                              height: double.infinity,
                            ).image
                          : Image.asset("assets/images/avatar-image.png").image,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 130.0),
              child: GestureDetector(
                // behavior: HitTestBehavior.translucent,
                onTap: () {
                  _pickImage();
                  // print(imageFile);
                },
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: 50,
                    height: 50,
                    // color: Colors.white,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Colors.white,
                      // border: Border.all(),
                      boxShadow: [
                        BoxShadow(
                          blurRadius: 10,
                          color: inactiveColor.withOpacity(0.1),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.add_a_photo,
                      color: kDefaultBackground,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Form(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(
                        child: TextFormField(
                          controller: _fnamecontroller,
                          decoration: InputDecoration(
                            label: const Text('First Name'),
                            labelStyle: TextStyle(color: inactiveColor),
                            hintText: 'First Name',
                            hintStyle: TextStyle(
                              color: inactiveColor,
                              fontWeight: FontWeight.w600,
                            ),
                            prefixIcon: Icon(
                              Icons.badge_rounded,
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
                      SizedBox(height: 20),
                      Flexible(
                        child: TextFormField(
                          controller: _lnamecontroller,
                          decoration: InputDecoration(
                            label: const Text('Last Name'),
                            labelStyle: TextStyle(color: inactiveColor),
                            hintText: 'Last Name',
                            hintStyle: TextStyle(
                              color: inactiveColor,
                              fontWeight: FontWeight.w600,
                            ),
                            prefixIcon: Icon(
                              Icons.badge_rounded,
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
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: CustomButton(
          onPressed: () async {
            await _updateDetails();
          },
          btnName: 'Update Profile',
        ),
      ),
    );
  }
}
