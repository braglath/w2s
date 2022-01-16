import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ImageView {
  final String imagePath;
  final String imageTitle;
  final bool isImageFromPath;
  ImageView(
      {required this.imagePath,
      required this.imageTitle,
      required this.isImageFromPath});
  void showImage(BuildContext context) {
    Get.defaultDialog(
        backgroundColor: Colors.transparent,
        title: imageTitle,
        titleStyle: context.theme.textTheme.caption
            ?.copyWith(color: Colors.white.withOpacity(0.8), fontSize: 22),
        content: ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: isImageFromPath
                ? Image.file(
                    File(imagePath),
                  )
                : Image.network(imagePath)));
  }
}
