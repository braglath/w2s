import 'package:flutter/material.dart';

import 'package:get/get.dart';

class CustomSnackbar {
  String title;
  String message;
  CustomSnackbar({required this.title, required this.message});
  void showWarning() {
    Get.closeAllSnackbars();
    Get.snackbar('', '',
        isDismissible: true,
        backgroundColor: Colors.grey.withOpacity(0.5),
        icon: const Icon(
          Icons.warning_sharp,
          color: Colors.red,
          size: 25,
        ),
        messageText: Text(message,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        shouldIconPulse: true,
        colorText: Colors.white,
        titleText: Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17)));
  }

  void showSuccess() {
    Get.snackbar('', '',
        snackPosition: SnackPosition.BOTTOM,
        isDismissible: true,
        backgroundColor: Colors.grey.withOpacity(0.5),
        icon: const Icon(
          Icons.done,
          color: Colors.green,
          size: 35,
        ),
        messageText: Text(message,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20)),
        shouldIconPulse: true,
        colorText: Colors.white,
        titleText: Text(title,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 17)));
  }
}
