import 'package:get/get.dart';

import 'package:w2s/app/modules/forgot_password/bindings/forgot_password_binding.dart';
import 'package:w2s/app/modules/forgot_password/views/forgot_password_view.dart';
import 'package:w2s/app/modules/home/bindings/home_binding.dart';
import 'package:w2s/app/modules/home/views/home_view.dart';
import 'package:w2s/app/modules/login/bindings/login_binding.dart';
import 'package:w2s/app/modules/login/views/login_view.dart';
import 'package:w2s/app/modules/profile/bindings/profile_binding.dart';
import 'package:w2s/app/modules/profile/views/profile_view.dart';
import 'package:w2s/app/modules/signup/bindings/signup_binding.dart';
import 'package:w2s/app/modules/signup/views/signup_view.dart';
import 'package:w2s/app/modules/splash_screen/bindings/splash_screen_binding.dart';
import 'package:w2s/app/modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH_SCREEN;

  static final routes = [
    GetPage(
        name: _Paths.HOME,
        page: () => HomeView(),
        binding: HomeBinding(),
        transition: Transition.circularReveal,
        transitionDuration: const Duration(seconds: 1)),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.SIGNUP,
      page: () => const SignupView(),
      binding: SignupBinding(),
      transition: Transition.fadeIn,
    ),
    GetPage(
        name: _Paths.LOGIN,
        page: () => LoginView(),
        binding: LoginBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
    GetPage(
        name: _Paths.SPLASH_SCREEN,
        page: () => SplashScreenView(),
        binding: SplashScreenBinding(),
        transition: Transition.noTransition),
    GetPage(
        name: _Paths.FORGOT_PASSWORD,
        page: () => ForgotPasswordView(),
        binding: ForgotPasswordBinding(),
        transition: Transition.fadeIn,
        transitionDuration: const Duration(milliseconds: 500)),
  ];
}
