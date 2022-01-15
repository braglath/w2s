import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:w2s/app/data/user/user_data.dart';
import 'package:w2s/app/routes/app_pages.dart';
import 'package:w2s/app/views/views/custom_snackbar_view.dart';

class LoginController extends GetxController {
  final isLoading = false.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
  }

  String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return 'Email cannot be empty';
    }
    if (value.isEmail == false) {
      return 'Email field error';
    }
    if (value != UserDetails().readUserEmailfromBox()) {
      return 'Email is incorrect';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value!.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length > 16) {
      return 'Password cannot be more than 16 character';
    }
    if (value != UserDetails().readUserPasswordfromBox()) {
      return 'Password is incorrect';
    }
    return null;
  }

  void loginUser(context, String email, String password) async {
    print(
        '${UserDetails().readUserEmailfromBox()}\n${UserDetails().readUserPasswordfromBox()}');
    isLoading.value = true;
    if (formState.currentState!.validate()) {
      UserLoggedIn().userLoggedIn(true);
      Get.offAllNamed(Routes.HOME);
      CustomSnackbar(
              title: "Login successfully",
              message: 'Welcome back, ${UserDetails().readUserNamefromBox()}')
          .showSuccess();
      isLoading.value = false;
    } else {
      CustomSnackbar(
              title: "Login error",
              message: 'Error loging in, Check credentials')
          .showWarning();
      isLoading.value = false;
    }
  }
}
