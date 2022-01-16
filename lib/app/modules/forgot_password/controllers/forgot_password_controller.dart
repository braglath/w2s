import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:w2s/app/data/resources/strings.dart';
import 'package:w2s/app/data/user/user_data.dart';

class ForgotPasswordController extends GetxController {
  final isLoading = false.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordOneController = TextEditingController();
  final TextEditingController passwordTwoController = TextEditingController();
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

  String? passwordOneValidator(String? value) {
    if (value!.isEmpty) {
      return Validator.passwordEmpty;
    }
    if (value.length > 16) {
      return Validator.passwordMore16Chars;
    }
    if (value != passwordTwoController.text) {
      return Validator.passwordNotMatched;
    }
    return null;
  }

  String? passwordTwoValidator(String? value) {
    if (value!.isEmpty) {
      return Validator.passwordEmpty;
    }
    if (value.length > 16) {
      return Validator.passwordMore16Chars;
    }
    if (value != passwordOneController.text) {
      return Validator.passwordNotMatched;
    }
    return null;
  }

  void confirmPassword(String password) {
    isLoading.value = true;
    if (formState.currentState!.validate()) {
      UserDetails().saveUserPasswordtoBox(password);
      // ?snackbar here
      isLoading.value = false;
      Get.back();
    } else {
      // ?snackbar here
      isLoading.value = false;
    }
  }
}
