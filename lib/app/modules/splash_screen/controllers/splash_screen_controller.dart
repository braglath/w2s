import 'package:get/get.dart';
import 'package:w2s/app/data/user/user_data.dart';
import 'package:w2s/app/routes/app_pages.dart';

class SplashScreenController extends GetxController {
  final isLoaded = false.obs;
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 3), () {
      print(UserLoggedIn().checkisUserLoggedIn());
      UserLoggedIn().checkisUserLoggedIn() == false
          ? Get.offNamed(Routes.LOGIN)
          : Get.offNamed(Routes.HOME);
    }).then((value) => isLoaded.value = true);
  }
}
