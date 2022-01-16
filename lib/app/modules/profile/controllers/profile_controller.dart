import 'package:get/get.dart';
import 'package:w2s/app/data/user/user_data.dart';
import 'package:w2s/app/routes/app_pages.dart';

class ProfileController extends GetxController {
  final isLoading = false.obs;


  void logoutUser() {
    isLoading.value = true;
    UserLoggedIn().userLoggedIn(false);
    Get.offAllNamed(Routes.LOGIN);
    isLoading.value = false;
  }
}
