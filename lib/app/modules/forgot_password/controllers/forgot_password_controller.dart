import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:w2s/app/data/user/user_data.dart';

class ForgotPasswordController extends GetxController {
  final isLoading = false.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordOneController = TextEditingController();
  final TextEditingController passwordTwoController = TextEditingController();
  final GlobalKey<FormState> formState = GlobalKey<FormState>();


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

  String? passwordOneValidator(String? value) {
    if (value!.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length > 16) {
      return 'Password cannot be more than 16 character';
    }
    if (value != passwordTwoController.text) {
      return 'Password does not match';
    }
    return null;
  }

  String? passwordTwoValidator(String? value) {
    if (value!.isEmpty) {
      return 'Password cannot be empty';
    }
    if (value.length > 16) {
      return 'Password cannot be more than 16 character';
    }
    if (value != passwordOneController.text) {
      return 'Password does not match';
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
