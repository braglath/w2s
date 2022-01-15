import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:w2s/app/data/assets/image_assets.dart';
import 'package:w2s/app/modules/signup/controllers/signup_controller.dart';
import 'package:w2s/app/modules/signup/views/signup_view.dart';
import 'package:w2s/app/routes/app_pages.dart';
import 'package:w2s/app/views/views/custom_bottomsheet.dart';
import 'package:w2s/app/views/views/custom_email_field_view.dart';
import 'package:w2s/app/views/views/custom_password_field_view.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  LoginView({Key? key}) : super(key: key);

  final signupController = Get.put<SignupController>(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _loginBody(context));
  }

  Widget _loginBody(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Obx(() {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Login',
                      style: context.theme.textTheme.headline2,
                    ),
                  ),
                ],
              ),
              Hero(
                tag: 'logo',
                child: SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset(ImageAssets.logo, fit: BoxFit.contain)),
              ),
              // const Spacer(),
              Form(
                key: controller.formState,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: CustomEmailField(
                        emailController: controller.emailController,
                        validator: (val) => controller.emailValidator(val),
                        label: 'Email',
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Obx(() {
                        return CustompasswordField(
                          passwordController: controller.passwordController,
                          onChanged: (value) => {},
                          obscureText: signupController.obscured.value,
                          validator: (val) => controller.passwordValidator(val),
                          obsOnTap: () => signupController.passwordObs(),
                          label: 'Password',

                        );
                      }),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    _forgetPasswordBtn(),
                    const SizedBox(
                      height: 20,
                    ),
                    Hero(
                      tag: 'loginbutton',
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () => controller.loginUser(
                              context,
                              controller.emailController.text,
                              controller.passwordController.text),
                          child: controller.isLoading.isFalse
                              ? Text(
                                  'Login',
                                  style: context.theme.textTheme.headline6
                                      ?.copyWith(color: Colors.white),
                                )
                              : const SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.amber,
                                    color: Colors.green,
                                  ),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              // const Spacer(),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: InkWell(
                    onTap: () => Get.toNamed(Routes.SIGNUP),
                    child: RichText(
                      text: TextSpan(
                        text: 'New here?\n',
                        style: context.theme.textTheme.headline4,
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Singup',
                              style:
                                  context.theme.textTheme.headline4?.copyWith(
                                color: Colors.blue,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Align _forgetPasswordBtn() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
          onPressed: () => Get.toNamed(Routes.FORGOT_PASSWORD),
          child: const Text('forgot password?')),
    );
  }
}
