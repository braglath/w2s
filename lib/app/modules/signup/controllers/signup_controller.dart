import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:w2s/app/data/resources/colour_resources.dart';
import 'package:w2s/app/data/resources/strings.dart';
import 'package:w2s/app/data/user/user_data.dart';
import 'package:w2s/app/routes/app_pages.dart';
import 'package:w2s/app/views/views/custom_bottomsheet.dart';
import 'package:w2s/app/views/views/custom_dialogue.dart';
import 'package:w2s/app/views/views/custom_snackbar_view.dart';

class SignupController extends GetxController {
  var password = ''.obs;
  var passwordStrength = 0.0.obs;
  RegExp numRegExpress = RegExp(r".*[0-9].*");
  RegExp letterRegExpress = RegExp(r".*[A-Za-z].*");
  var isSignIn = false.obs;
  var name = ''.obs;
  var phone = ''.obs;
  var email = ''.obs;
  var profilePicture = ''.obs;
  RxBool isSelected = false.obs;
  RxBool obscured = true.obs;
  RxBool isLoading = false.obs;
  XFile? photo;
  final defaultChoiceIndex = 0.obs;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formState = GlobalKey<FormState>();

  final textFieldFocusNode = FocusNode();

  void checkPasswordStrength(String value) {
    password.value = value.trim();
    if (password.value.isEmpty) {
      passwordStrength.value = 0.0;
    } else if (password.value.length < 6) {
      passwordStrength.value = 1 / 4;
    } else if (password.value.length < 8) {
      passwordStrength.value = 2 / 4;
    } else {
      if (!letterRegExpress.hasMatch(password.value) ||
          !numRegExpress.hasMatch(password.value)) {
        passwordStrength.value = 3 / 4;
      } else {
        passwordStrength.value = 1 / 4;
      }
    }
  }

  void toggleObscured() {
    obscured.value = !obscured.value;
  }

  String? nameValidator(String? value) {
    if (value!.isEmpty) {
      return Validator.nameEmpty;
    }
    return null;
  }

  String? phoneValidator(String? value) {
    if (value!.isEmpty) {
      return Validator.phoneEmpty;
    }

    if (value.contains(letterRegExpress)) {
      return Validator.phoneContainsAlpha;
    }
    if (value.length > 10) {
      return Validator.phoneMore10Chars;
    }
    return null;
  }

  String? emailValidator(String? value) {
    if (value!.isEmpty) {
      return Validator.emailEmpty;
    }
    if (value.isEmail == false) {
      return Validator.emailNotValid;
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
    return null;
  }

  void passwordObs() {
    toggleObscured();
    if (textFieldFocusNode.hasPrimaryFocus) return;
    textFieldFocusNode.canRequestFocus = false;
  }

  void signupUser(
      context, String name, String phone, String email, String password) async {
    if (formState.currentState!.validate()) {
      isLoading.value = true;
      if (profilePicture.isEmpty) {
        CustomDialogue(
                contentWidget: Text(
                  SignUpPageStrings.profPicEmpty,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(fontSize: 17, color: ColourResources.grey),
                ),
                isDismissible: true,
                onpressedCancel: () {
                  Get.back();
                  CustomBottomSheet(
                    icon1: FontAwesomeIcons.cameraRetro,
                    icon2: FontAwesomeIcons.image,
                    title1: SignUpPageStrings.camera,
                    titile2: SignUpPageStrings.gallery,
                    onTap1: () =>
                        pickImage(ImageSource.camera).whenComplete(() {
                      UserLoggedIn().userLoggedIn(true);
                      UserDetails().saveUserDetailstoBox(
                          name: name,
                          phone: phone,
                          email: email,
                          password: password,
                          profilepic: profilePicture.value);

                      isLoading.value = false;
                      Get.offAllNamed(Routes.HOME);
                    }),
                    onTap2: () =>
                        pickImage(ImageSource.gallery).whenComplete(() {
                      UserLoggedIn().userLoggedIn(true);
                      UserDetails().saveUserDetailstoBox(
                          name: name,
                          phone: phone,
                          email: email,
                          password: password,
                          profilepic: profilePicture.value);

                      isLoading.value = false;
                      Get.offAllNamed(Routes.HOME);
                    }),
                  ).show();
                },
                onpressedConfirm: () => Get.back(),
                textCancel: SignUpPageStrings.picknow,
                textConfirm: SignUpPageStrings.cancel,
                title: SignUpPageStrings.attention)
            .showDialogue();
      } else {
        UserLoggedIn().userLoggedIn(true);
        UserDetails().saveUserDetailstoBox(
            name: name,
            phone: phone,
            email: email,
            password: password,
            profilepic: profilePicture.value);

        isLoading.value = false;
        Get.offAllNamed(Routes.HOME);
      }
      isLoading.value = false;
      // print(
      //     'name - $name\nemail - $email\nphone - $phone\npassword - $password');
    }
  }

  Future pickImage(ImageSource source) async {
    isLoading.value = true;
    try {
      final ImagePicker _picker = ImagePicker();
      photo = await _picker.pickImage(source: source);
      if (photo == null) {
        isLoading.value = false;
        Get.back();
      } else {
        photo = XFile(photo!.path);
        if (photo != null) {
          //? photo with file path
          final String profilePic = photo!.path;
          profilePicture.value = profilePic;
          UserDetails().saveUserProfilePictoBox(profilePicture.value);
          isLoading.value = false;
          Get.back();
        } else {
          CustomSnackbar(
                  title: Strings.error,
                  message: SignUpPageStrings.imagePickFailed)
              .showWarning();
          isLoading.value = false;
          Get.back();
          throw Exception();
        }
      }
    } on PlatformException catch (e) {
      Get.back();
      isLoading.value = false;

      CustomSnackbar(title: Strings.error, message: 'Error picking image, $e')
          .showWarning();
    }
  }

  void getUserDetails(String name, String password) async {}
}
