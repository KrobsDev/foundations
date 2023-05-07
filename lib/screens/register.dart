import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:foundations/constants.dart';
import 'package:foundations/widgets/custom_button.dart';
import 'package:foundations/widgets/loading_screen.dart';
import 'package:http/http.dart' as http;

import '../env.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool isLoading = false;

  final TextEditingController _fnamecontroller = TextEditingController();
  final TextEditingController _lnamecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _phonecontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  // Create user
  Future _createUser() async {
    return await http.post(
      Uri.parse("${Env.URL_ENDPOINT_USERS}/create.php"),
      body: jsonEncode(
        {
          "user_fname": _fnamecontroller.text,
          "user_lname": _lnamecontroller.text,
          "user_phone": _phonecontroller.text,
          "user_image": "",
          "user_email": _emailcontroller.text,
          "user_pass": _passcontroller.text,
        },
      ),
    );
  }

  void _onConfirm(context) async {
    await _createUser();

    Navigator.of(context)
        .pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);
  }

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
                  'Create your account',
                  style: TextStyle(
                    color: kWhiteTextColor,
                    fontSize: kDefaultHeading,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 50),
                Flexible(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextFormField(
                            controller: _fnamecontroller,
                            style: const TextStyle(color: Colors.white),
                            validator: (value) {
                              // /^[A-Za-z][A-Za-z\'\-]+([\ A-Za-z][A-Za-z\'\-]+)*$/
                              final nameReg = RegExp(
                                r"[A-Za-z][A-Za-z\'\-]+([\ A-Za-z][A-Za-z\'\-]+)*$",
                              );
                              if (value == null || value.isEmpty) {
                                return '* Name cannot be empty';
                              } else if (!nameReg.hasMatch(value)) {
                                return 'Enter a valid name';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'First Name',
                              hintStyle: const TextStyle(
                                color: kLightTextColor,
                              ),
                              prefixIcon: const Icon(
                                Icons.person,
                                color: kLightTextColor,
                              ),
                              errorStyle: const TextStyle(color: Colors.white),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: kWhiteTextColor),
                              ),
                              disabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: inactiveColor),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
                              ),
                              focusedErrorBorder: const OutlineInputBorder(
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
                            controller: _lnamecontroller,
                            style: const TextStyle(color: Colors.white),
                            validator: (value) {
                              // /^[A-Za-z][A-Za-z\'\-]+([\ A-Za-z][A-Za-z\'\-]+)*$/
                              final nameReg = RegExp(
                                r"[A-Za-z][A-Za-z\'\-]+([\ A-Za-z][A-Za-z\'\-]+)*$",
                              );
                              if (value == null || value.isEmpty) {
                                return '* Name cannot be empty';
                              } else if (!nameReg.hasMatch(value)) {
                                return 'Enter a valid name';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Last Name',
                              hintStyle: const TextStyle(
                                color: kLightTextColor,
                              ),
                              prefixIcon: const Icon(
                                Icons.person,
                                color: kLightTextColor,
                              ),
                              errorStyle: const TextStyle(color: Colors.white),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: kWhiteTextColor),
                              ),
                              focusedErrorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
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
                            controller: _emailcontroller,
                            style: const TextStyle(color: Colors.white),
                            validator: (value) {
                              final regex = RegExp(
                                r'([a-zA-Z0-9]+)([\.{1}])?([a-zA-Z0-9]+)\@gmail([\.])com',
                              );
                              if (value == null || value.isEmpty) {
                                return '* Email cannot be empty';
                              } else if (!regex.hasMatch(value)) {
                                return 'Enter a valid email';
                              } else {
                                return null;
                              }
                            },
                            decoration: InputDecoration(
                              hintText: 'Email',
                              hintStyle: const TextStyle(
                                color: kLightTextColor,
                              ),
                              prefixIcon: const Icon(
                                Icons.email,
                                color: kLightTextColor,
                              ),
                              errorStyle: const TextStyle(color: Colors.white),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: kWhiteTextColor),
                              ),
                              focusedErrorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
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
                            validator: (value) {
                              final regex = RegExp(
                                r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$',
                              );
                              if (value == null || value.isEmpty) {
                                return '* Password cannot be empty';
                              } else if (!regex.hasMatch(value)) {
                                return 'Enter a valid password';
                              } else {
                                return null;
                              }
                            },
                            obscureText: true,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: const TextStyle(
                                color: kLightTextColor,
                              ),
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: kLightTextColor,
                              ),
                              errorStyle: const TextStyle(color: Colors.white),
                              focusedBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: kWhiteTextColor),
                              ),
                              focusedErrorBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.red),
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
                          const SizedBox(height: 40),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: TextButton(
                              onPressed: () {},
                              child: const Text(
                                'By signing up, you are agreeing to our Terms & Conditions and Privacy Policy',
                                style: TextStyle(
                                  color: kLightTextColor,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        setState(() => isLoading = true);
                        await Future.delayed(
                          const Duration(seconds: 3),
                        );
                        _onConfirm(context);
                        setState(() => isLoading = false);
                      }
                    },
                    btnName: 'Create account',
                    backgroundColor: kWhiteTextColor,
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already a member?',
                      style: TextStyle(
                        color: kLightTextColor,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Sign in',
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
