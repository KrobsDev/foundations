import 'package:flutter/material.dart';

@immutable
class LoginState {
  // properties should be final
  final String email;
  final String password;
  final dynamic result;
  final bool isLoading;

  // constructor
  const LoginState({
    required this.email,
    required this.password,
    required this.result,
    this.isLoading = false,
  });

  // since the class is immutable, the "copyWith" keyword allows us to have
  // a modifiable constructor
  LoginState copyWith({
    String? email,
    String? password,
    result,
    bool? isLoading,
  }) {
    return LoginState(
      email: email ?? this.email,
      password: password ?? this.password,
      result: result ?? this.result,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  // an initial state
  const LoginState.initial({
    this.email = '',
    this.password = '',
    this.result,
    this.isLoading = false,
  });

  // convert properties to json format
  Map<String, String> toJson() {
    return {
      "user_email": email,
      "user_pass": password,
    };
  }
}
