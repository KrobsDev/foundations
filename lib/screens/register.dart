import 'package:flutter/material.dart';
import 'package:foundations/constants.dart';
import 'package:foundations/widgets/custom_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _fnamecontroller = TextEditingController();
  final TextEditingController _lnamecontroller = TextEditingController();
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _passcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextFormField(
                      controller: _fnamecontroller,
                      decoration: InputDecoration(
                        hintText: 'First Name',
                        hintStyle: const TextStyle(
                          color: kLightTextColor,
                        ),
                        prefixIcon: const Icon(
                          Icons.person,
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
                      controller: _lnamecontroller,
                      decoration: InputDecoration(
                        hintText: 'Last Name',
                        hintStyle: const TextStyle(
                          color: kLightTextColor,
                        ),
                        prefixIcon: const Icon(
                          Icons.person,
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
                      controller: _emailcontroller,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: const TextStyle(
                          color: kLightTextColor,
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
                    SizedBox(height: 40),
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
              )),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: CustomButton(
                onPressed: () {},
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
                    Navigator.of(context, rootNavigator: true)
                        .pushNamed('/login');
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
}
