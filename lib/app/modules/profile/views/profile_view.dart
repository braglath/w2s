import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:w2s/app/data/resources/colour_resources.dart';
import 'package:w2s/app/data/resources/strings.dart';
import 'package:w2s/app/data/user/user_data.dart';
import 'package:w2s/app/views/views/custom_image_viewer.dart';
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
                backgroundColor: ColourResources.grey,
                color: ColourResources.blue,
              )))
            : const SizedBox.shrink()
      ],
    );
  }

  Widget _mainBody(BuildContext context) => Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Spacer(
              flex: 3,
            ),
            ProfileImage(
                outerRadius: 65,
                innerRadius: 62,
                onTap: () => ImageView(
                        imagePath: UserDetails().readUserProfilePicfromBox(),
                        imageTitle: '',
                        isImageFromPath: true)
                    .showImage(context),
                strokeColor: ColourResources.blue),
            const SizedBox(height: 50),
            ..._userDetails,
            const Spacer(
              flex: 3,
            ),
            Center(
              child: ElevatedButton(
                onPressed: () => controller.logoutUser(),
                child: Text(
                  Strings.logout,
                  style: context.theme.textTheme.headline6
                      ?.copyWith(color: ColourResources.white),
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
            color: ColourResources.blue,
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            title,
            style: context.theme.textTheme.headline6
                ?.copyWith(color: ColourResources.grey),
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
    icon: FontAwesomeIcons.phoneAlt,
  ),
  const SizedBox(height: 10),
  ProfileUserDetails(
    title: UserDetails().readUserPasswordfromBox(),
    icon: FontAwesomeIcons.lock,
  ),
];
