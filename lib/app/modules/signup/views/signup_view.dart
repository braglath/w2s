import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:w2s/app/data/resources/colour_resources.dart';
import 'package:w2s/app/data/resources/image_assets.dart';
import 'package:w2s/app/data/resources/strings.dart';
import 'package:w2s/app/views/views/custom_bottomsheet.dart';
import 'package:w2s/app/views/views/custom_email_field_view.dart';
import 'package:w2s/app/views/views/custom_password_field_view.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _signupBody(context),
    );
  }

  _signupBody(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
          reverse: true,
          child: Obx(() {
            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Text(
                            Strings.signup,
                            style: context.theme.textTheme.headline2,
                          ),
                        ),
                        const Spacer(),
                        Hero(
                          tag: Strings.heroTagLogo,
                          child: SizedBox(
                              height: 50,
                              width: 50,
                              child: Image.asset(ImageAssets.logo,
                                  fit: BoxFit.contain)),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    _profileImage(context),
                    Form(
                      key: controller.formState,
                      child: Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: _name(context),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: _phoneNumber(context),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: _email(),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: _password(),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Text(
                                SignUpPageStrings.pickStrongerPass,
                                style: context.theme.textTheme.caption,
                              ),
                            ),
                          ),
                          Obx(() {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 12),
                              child: LinearProgressIndicator(
                                minHeight: 3,
                                semanticsLabel: SignUpPageStrings.passStrength,
                                value: controller.passwordStrength.value,
                                backgroundColor: ColourResources.white,
                                color: controller.passwordStrength.value <=
                                        1 / 4
                                    ? ColourResources.red?.withOpacity(0.8)
                                    : controller.passwordStrength.value == 2 / 4
                                        ? ColourResources.amber
                                            ?.withOpacity(0.8)
                                        : controller.passwordStrength.value ==
                                                3 / 4
                                            ? Colors.deepPurpleAccent
                                                .withOpacity(0.8)
                                            : Colors.green.withOpacity(0.8),
                              ),
                            );
                          }),
                          const SizedBox(
                            height: 20,
                          ),
                          Hero(
                            tag: Strings.loginBtnHeroTag,
                            child: Center(
                              child: ElevatedButton(
                                onPressed: () => controller.signupUser(
                                    context,
                                    controller.nameController.text,
                                    controller.phoneController.text,
                                    controller.emailController.text,
                                    controller.passwordController.text),
                                child: Text(
                                  Strings.signup,
                                  style: context.theme.textTheme.headline6
                                      ?.copyWith(color: ColourResources.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: InkWell(
                          onTap: () => Get.back(),
                          child: RichText(
                            text: TextSpan(
                              text: 'Have an account?\n',
                              style: context.theme.textTheme.headline4,
                              children: <TextSpan>[
                                TextSpan(
                                    text: Strings.login,
                                    style: context.theme.textTheme.headline4
                                        ?.copyWith(
                                      color: ColourResources.blue,
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                controller.isLoading.value
                    ? const Positioned.fill(
                        child: Center(
                            child: CircularProgressIndicator(
                        backgroundColor: ColourResources.grey,
                        color: ColourResources.blue,
                      )))
                    : const SizedBox.shrink()
              ],
            );
          })),
    );
  }

  Widget _profileImage(BuildContext context) {
    return ProfileImage(controller: controller);
  }

  Widget _name(BuildContext context) {
    return TextFormField(
        onEditingComplete: () => FocusScope.of(context).nextFocus(),
        style: const TextStyle(color: ColourResources.grey),
        cursorColor: ColourResources.grey,
        keyboardType: TextInputType.name,
        controller: controller.nameController,
        validator: (val) => controller.nameValidator(val),
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.person,
            color: ColourResources.blue,
          ),
          labelText: Strings.name,
        ));
  }

  Widget _phoneNumber(BuildContext context) {
    return TextFormField(
        onEditingComplete: () => FocusScope.of(context).nextFocus(),
        style: const TextStyle(color: ColourResources.grey),
        cursorColor: ColourResources.grey,
        keyboardType: TextInputType.number,
        controller: controller.phoneController,
        validator: (val) => controller.phoneValidator(val),
        decoration: const InputDecoration(
          prefixIcon: Icon(
            Icons.phone,
            color: ColourResources.blue,
          ),
          labelText: Strings.phone,
        ));
  }

  Widget _email() => CustomEmailField(
        emailController: controller.emailController,
        validator: (val) => controller.emailValidator(val),
        label: Strings.email,
      );
  Widget _password() => Obx(() {
        return CustompasswordField(
          passwordController: controller.passwordController,
          onChanged: (value) => controller.checkPasswordStrength(value),
          obscureText: controller.obscured.value,
          validator: (val) => controller.passwordValidator(val),
          obsOnTap: () => controller.passwordObs(),
          label: Strings.password,
        );
      });
}

class ProfileImage extends StatelessWidget {
  const ProfileImage({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final SignupController controller;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Obx(() {
          return Center(
              child: CircleAvatar(
            backgroundColor: ColourResources.white,
            radius: 55,
            child: CircleAvatar(
              radius: 52,
              child: controller.profilePicture.value.isEmpty
                  ? const Icon(
                      Icons.person,
                      color: ColourResources.white,
                      size: 50,
                    )
                  : const SizedBox.shrink(),
              backgroundColor: ColourResources.blue,
              foregroundImage: controller.profilePicture.value.isEmpty
                  ? null
                  : FileImage(
                      File(controller.profilePicture.value),
                    ),
            ),
          ));
        }),
        IconButton(
            splashColor: Colors.transparent,
            onPressed: () => CustomBottomSheet(
                  icon1: FontAwesomeIcons.cameraRetro,
                  icon2: FontAwesomeIcons.image,
                  title1: SignUpPageStrings.camera,
                  titile2: SignUpPageStrings.gallery,
                  onTap1: () => controller.pickImage(ImageSource.camera),
                  onTap2: () => controller.pickImage(ImageSource.gallery),
                ).show(),
            icon: const FaIcon(
              FontAwesomeIcons.cameraRetro,
              color: ColourResources.white,
            ))
      ],
    );
  }
}
