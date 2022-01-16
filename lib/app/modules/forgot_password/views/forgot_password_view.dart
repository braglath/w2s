import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:w2s/app/data/resources/colour_resources.dart';
import 'package:w2s/app/data/resources/image_assets.dart';
import 'package:w2s/app/data/resources/strings.dart';
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
                      Strings.password,
                      style: context.theme.textTheme.headline2,
                    ),
                  ),
                ],
              ),
              Hero(
                tag: Strings.heroTagLogo,
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
                        label: Strings.email,
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
                          label: ForgotPasswordPageStrings.newPassword,
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
                          label: ForgotPasswordPageStrings.retypePassword,
                        );
                      }),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Hero(
                      tag: Strings.loginBtnHeroTag,
                      child: Center(
                        child: ElevatedButton(
                          onPressed: () => controller.confirmPassword(
                              controller.passwordTwoController.text),
                          child: controller.isLoading.isFalse
                              ? Text(
                                  ForgotPasswordPageStrings.confirm,
                                  style: context.theme.textTheme.headline6
                                      ?.copyWith(color: ColourResources.white),
                                )
                              : const SizedBox(
                                  height: 25,
                                  width: 25,
                                  child: CircularProgressIndicator(
                                    backgroundColor: ColourResources.grey,
                                    color: ColourResources.blue,
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
                              text: Strings.login,
                              style:
                                  context.theme.textTheme.headline4?.copyWith(
                                color: ColourResources.blue,
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
