import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foundations/controllers/auth_controller.dart';
import 'package:foundations/controllers/user_details_controller.dart';
import 'package:foundations/providers/loginProvider/login_state.dart';

// creating an extension of the StateNotifier class that will be passed to
// our StateNotifierProvider
// This class should not expose any state outside of its "state" property, which means
// no public getters/properties!
// the public methods on this class will be what allow the UI to modify the state
class LoginNotifier extends StateNotifier<LoginState> {
  // initialize our login state
  LoginNotifier() : super(const LoginState.initial());

  // assign the state of the email
  onEmailChange(String email) {
    state = state.copyWith(
      email: email,
    );
  }

  // assign the password state
  onPasswordChange(String password) {
    state = state.copyWith(
      password: password,
    );
  }

  // on successful login
  void onLogin(ref) async {
    state = state.copyWith(
      isLoading: true,
    );

    // perform call to api
    var result = await AuthController().authenticate(formData: state.toJson());

    if (result is String) {
      state = state.copyWith(
        isLoading: false,
      );
    }

    // save user credentials
    await UserDetailsController.saveUserDetails(credentials: result);

    await Future.delayed(const Duration(seconds: 3));

    state = state.copyWith(
      isLoading: false,
      result: result,
    );
  }
}

final loginProvider = StateNotifierProvider<LoginNotifier, LoginState>((ref) {
  return LoginNotifier();
});
