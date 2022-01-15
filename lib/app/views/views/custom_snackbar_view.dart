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
        icon: const CircleAvatar(
          backgroundColor: Colors.amber,
          child: Icon(
            Icons.warning_sharp,
            color: Colors.amber,
            size: 25,
          ),
        ),
        messageText: Text(message,
            style: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20)),
        shouldIconPulse: true,
        colorText: Colors.green,
        titleText: Text(title,
            style: const TextStyle(
                color: Colors.green,
                fontWeight: FontWeight.bold,
                fontSize: 17)));
  }

  void showSuccess() {
    Get.snackbar('', '',
        snackPosition: SnackPosition.BOTTOM,
        isDismissible: true,
        backgroundColor: Colors.grey.withOpacity(0.5),
        icon: const CircleAvatar(
          backgroundColor: Colors.green,
          child: Icon(
            Icons.done,
            color: Colors.amber,
            size: 35,
          ),
        ),
        messageText: Text(message,
            style: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold, fontSize: 20)),
        shouldIconPulse: true,
        colorText: Colors.grey,
        titleText: Text(title,
            style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 17)));
  }
}
