import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foundations/constants.dart';
import 'package:foundations/providers/loginProvider/login_provider.dart';
import 'package:foundations/providers/loginProvider/login_state.dart';
import 'package:foundations/widgets/custom_button.dart';
import '../widgets/loading_screen.dart';

class LoginScreen extends ConsumerWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final login = ref.watch(loginProvider);

    // listen for changes and navigate to next page
    ref.listen<LoginState>(loginProvider, (previous, next) {
      // print(next.isLoading);
      if ((previous != null && previous.isLoading) && next.result != null) {
        if (next.result is String) {
          // alert user
          showDialog(
            context: context,
            builder: (context) => Container(
              width: 400,
              height: 500,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(next.result),
              ),
            ),
          );
        }

        if (next.result is! String) {
          // navigate to the other screen
          Navigator.of(context).pushReplacementNamed('/home');
        }
      }
      return;
    });

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading:
            const Image(image: AssetImage('assets/logo/logo-white-sm.png')),
      ),
      backgroundColor: kDefaultBackground,
      body: login.isLoading
          ? const LoadingScreen()
          : SingleChildScrollView(
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
                        key: _formKey,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              TextFormField(
                                controller: emailcontroller,
                                onChanged: (value) {
                                  ref
                                      .read(loginProvider.notifier)
                                      .onEmailChange(value);
                                },
                                style: const TextStyle(color: Colors.white),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Invalid email";
                                  }
                                  return null;
                                },
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
                                  errorStyle:
                                      const TextStyle(color: Colors.white),
                                  focusedBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: kWhiteTextColor),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: inactiveColor),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  focusedErrorBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: kWhiteTextColor),
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
                                controller: passcontroller,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Invalid password";
                                  }
                                  return null;
                                },
                                onChanged: (value) {
                                  ref
                                      .read(loginProvider.notifier)
                                      .onPasswordChange(value);
                                },
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
                                    borderSide:
                                        BorderSide(color: kWhiteTextColor),
                                  ),
                                  disabledBorder: OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: inactiveColor),
                                  ),
                                  errorBorder: const OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.red),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: kLightTextColor.withOpacity(0.3),
                                    ),
                                  ),
                                  focusedErrorBorder: const OutlineInputBorder(
                                    borderSide:
                                        BorderSide(color: kWhiteTextColor),
                                  ),
                                  errorStyle:
                                      const TextStyle(color: Colors.white),
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
                    padding: const EdgeInsets.only(
                        bottom: 40.0, left: 20, right: 20),
                    child: CustomButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          ref.watch(loginProvider.notifier).onLogin(ref);
                        }
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 20),
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
}
