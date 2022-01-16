import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:w2s/app/data/user/user_data.dart';

class ProfileImage extends StatelessWidget {
  final double? outerRadius;
  final double? innerRadius;
  final Function()? onTap;
  final Color? strokeColor;

  const ProfileImage({
    Key? key,
    required this.outerRadius,
    required this.innerRadius,
    required this.onTap,
    required this.strokeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('profile image  - ${UserDetails().readUserProfilePicfromBox()}');
    return InkWell(
      onTap: onTap,
      // radius: 0,
      splashColor: Colors.transparent,
      child: Center(
          child: CircleAvatar(
        backgroundColor: strokeColor,
        radius: outerRadius,
        child: CircleAvatar(
          radius: innerRadius,
          backgroundColor: Colors.blue,
          foregroundImage: FileImage(
            File(UserDetails().readUserProfilePicfromBox()),
          ),
        ),
      )),
    );
  }
}
