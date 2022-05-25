import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:foundations/constants.dart';
import 'package:foundations/widgets/custom_button.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../env.dart';
import '../models/user_model.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../widgets/loading_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoading = false;

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();

  Future<bool> _loggedIn() async {
    var data = jsonEncode({
      "user_email": _emailcontroller.text,
      "user_pass": _passcontroller.text,
    });

    var response = await http.post(
      Uri.parse("${Env.URL_PREFIX_USERS}/login.php"),
      body: data,
      headers: {
        "Accept": "application/json",
      },
    );

    var res = jsonDecode(response.body);

    // if user login is successful
    if ((res != "Wrong credentials") && (res != "Wrong email")) {
      Map<String, dynamic> userMap = res;
      User user = User.fromJson(userMap);

      Fluttertoast.showToast(msg: "Login Successful");
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      await _prefs.setString('fname', user.fname!);
      await _prefs.setString('lname', user.lname!);
      await _prefs.setString('email', user.email!);
      await _prefs.setString('uid', user.uid!);

      // print(user.uid);

      Navigator.of(context, rootNavigator: true)
          .pushNamedAndRemoveUntil('/home', (route) => false);
      return true;
    } else {
      Fluttertoast.showToast(msg: "Enter a correct email or password");
      return false;
    }
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => isLoading
      ? const LoadingScreen()
      : Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            leading:
                const Image(image: AssetImage('assets/logo/logo-white-sm.png')),
          ),
          backgroundColor: kDefaultBackground,
          body: SingleChildScrollView(
            clipBehavior: Clip.none,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Let\'s sign you in',
                  style: TextStyle(
                    color: kWhiteTextColor,
                    fontSize: kDefaultHeading,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 50),
                Flexible(
                  child: Form(
                      child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextFormField(
                          controller: _emailcontroller,
                          style: const TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: const TextStyle(
                              color: kLightTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                            prefixIcon: const Icon(
                              Icons.email,
                              color: kLightTextColor,
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: kWhiteTextColor),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: inactiveColor),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: kLightTextColor.withOpacity(0.3),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          controller: _passcontroller,
                          style: const TextStyle(color: Colors.white),
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: const TextStyle(
                              color: kLightTextColor,
                              fontWeight: FontWeight.w600,
                            ),
                            prefixIcon: const Icon(
                              Icons.lock,
                              color: kLightTextColor,
                            ),
                            focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: kWhiteTextColor),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: inactiveColor),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.red),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: kLightTextColor.withOpacity(0.3),
                              ),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {},
                            child: const Text(
                              'Forgot Password?',
                              style: TextStyle(color: kWhiteTextColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 40.0, left: 20, right: 20),
                  child: CustomButton(
                    onPressed: () async {
                      // set isLoading to true
                      setState(() {
                        isLoading = true;
                      });

                      await Future.delayed(const Duration(seconds: 3));
                      //call to api goes here
                      await _loggedIn();

                      setState(() {
                        isLoading = false;
                      });
                    },
                    btnName: 'Sign in',
                    backgroundColor: kWhiteTextColor,
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Expanded(
                        child: Divider(
                          thickness: 1.2,
                          color: kLightTextColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                          'or continue with',
                          style: TextStyle(
                            color: kLightTextColor,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 1.2,
                          color: kLightTextColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                  child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                      color: kLightTextColor.withOpacity(0.2),
                      // border: Border.all(),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Image(
                          image: AssetImage(
                            'assets/images/akar-icons_google-fill.png',
                          ),
                        ),
                        SizedBox(width: 10),
                        Text(
                          'Sign in with Google',
                          style: TextStyle(
                            color: kWhiteTextColor,
                            fontSize: kDefaultFontSize,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Not a member?',
                      style: TextStyle(
                        color: kLightTextColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/signup',
                          (route) => route.isCurrent &&
                                  route.settings.name == '/signup'
                              ? false
                              : true,
                        );
                      },
                      child: const Text(
                        'Sign up now',
                        style: TextStyle(
                          color: kWhiteTextColor,
                          fontSize: kDefaultFontSize,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
}
