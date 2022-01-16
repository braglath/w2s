import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:w2s/app/data/assets/image_assets.dart';
import 'package:w2s/app/modules/signup/controllers/signup_controller.dart';
import 'package:w2s/app/views/views/custom_email_field_view.dart';
import 'package:w2s/app/views/views/custom_password_field_view.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  ForgotPasswordView({Key? key}) : super(key: key);

  final signupController = Get.put<SignupController>(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _forgetPasswordBody(context));
  }

  Widget _forgetPasswordBody(BuildContext context) {
    return SingleChildScrollView(
      reverse: true,
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
                      'Password',
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
                          passwordController: controller.passwordOneController,
                          onChanged: (value) => {},
                          obscureText: signupController.obscured.value,
                          validator: (val) =>
                              controller.passwordOneValidator(val),
                          obsOnTap: () => signupController.passwordObs(),
                          label: 'New password',
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12.0),
                      child: Obx(() {
                        return CustompasswordField(
                          passwordController: controller.passwordTwoController,
                          onChanged: (value) => {},
                          obscureText: signupController.obscured.value,
                          validator: (val) =>
                              controller.passwordTwoValidator(val),
                          obsOnTap: () => signupController.passwordObs(),
                          label: 'Retype password',
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Hero(
                      tag: 'loginbutton',
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () => controller.confirmPassword(
                              controller.passwordTwoController.text),
                          child: controller.isLoading.isFalse
                              ? Text(
                                  'Confirm',
                                  style: context.theme.textTheme.headline6
                                      ?.copyWith(color: Colors.white),
                                )
                              : const SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(
                                    backgroundColor: Colors.grey,
                                    color: Colors.blue,
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
                    onTap: () => Get.back(),
                    child: RichText(
                      text: TextSpan(
                        text: 'Remember credentials?\n',
                        style: context.theme.textTheme.headline4,
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Login',
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
}
