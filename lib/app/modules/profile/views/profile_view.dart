import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:get/get.dart';
import 'package:w2s/app/data/user/user_data.dart';
import 'package:w2s/app/views/views/custom_profile_image_view.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _profileBody(context),
    );
  }

  Stack _profileBody(BuildContext context) {
    return Stack(
      children: [
        _mainBody(context),
        controller.isLoading.value
            ? const Positioned.fill(
                child: Center(
                    child: CircularProgressIndicator(
                backgroundColor: Colors.grey,
                color: Colors.blue,
              )))
            : const SizedBox.shrink()
      ],
    );
  }

  Widget _mainBody(BuildContext context) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Spacer(),
            ProfileImage(
              outerRadius: 55,
              innerRadius: 52,
              onTap: () {},
            ),
            const SizedBox(height: 50),
            ..._userDetails,
            const Spacer(
              flex: 3,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () => controller.logoutUser(),
                child: Text(
                  'Logout',
                  style: context.theme.textTheme.headline6
                      ?.copyWith(color: Colors.white),
                ),
              ),
            ),
            const Spacer(
              flex: 1,
            ),
          ],
        ),
      );
}

class ProfileUserDetails extends StatelessWidget {
  final String title;
  final IconData icon;
  const ProfileUserDetails({Key? key, required this.title, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            icon,
            color: Colors.blue,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style:
                context.theme.textTheme.headline6?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}

final _userDetails = [
  ProfileUserDetails(
    title: UserDetails().readUserNamefromBox(),
    icon: FontAwesomeIcons.userAlt,
  ),
  const SizedBox(height: 10),
  ProfileUserDetails(
    title: UserDetails().readUserEmailfromBox(),
    icon: FontAwesomeIcons.envelope,
  ),
  const SizedBox(height: 10),
  ProfileUserDetails(
    title: UserDetails().readUserPhonefromBox(),
    icon: FontAwesomeIcons.phone,
  ),
  const SizedBox(height: 10),
  ProfileUserDetails(
    title: UserDetails().readUserPasswordfromBox(),
    icon: FontAwesomeIcons.lock,
  ),
];
