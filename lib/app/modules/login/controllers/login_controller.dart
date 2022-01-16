import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:w2s/app/data/resources/strings.dart';
import 'package:w2s/app/data/user/user_data.dart';
import 'package:w2s/app/routes/app_pages.dart';
import 'package:w2s/app/views/views/custom_snackbar_view.dart';

class LoginController extends GetxController {
  final isLoading = false.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return Validator.emailEmpty;
    }
    if (value.isEmail == false) {
      return Validator.emailNotValid;
    }
    if (value != UserDetails().readUserEmailfromBox()) {
      return Validator.emailIncorrect;
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return Validator.passwordEmpty;
    }
    if (value.length > 16) {
      return Validator.passwordMore16Chars;
    }
    if (value != UserDetails().readUserPasswordfromBox()) {
      return Validator.passwordIncorrect;
    }
    return null;
  }

  void loginUser(context, String email, String password) async {
    // print(
    //     '${UserDetails().readUserEmailfromBox()}\n${UserDetails().readUserPasswordfromBox()}');
    isLoading.value = true;
    if (formState.currentState!.validate()) {
      UserLoggedIn().userLoggedIn(true);
      Get.offAllNamed(Routes.HOME);
      CustomSnackbar(
              title: LoginPageStrings.loginSuccessful,
              message: 'Welcome back, ${UserDetails().readUserNamefromBox()}')
          .showSuccess();
      isLoading.value = false;
    } else {
      CustomSnackbar(
              title: LoginPageStrings.loginError,
              message: LoginPageStrings.errorLoggingIn)
          .showWarning();
      isLoading.value = false;
    }
  }
}
