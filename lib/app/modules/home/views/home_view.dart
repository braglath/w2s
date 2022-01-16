import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:w2s/app/data/assets/image_assets.dart';
import 'package:w2s/app/data/models/image_model.dart';
import 'package:w2s/app/modules/profile/controllers/profile_controller.dart';
import 'package:w2s/app/modules/profile/views/profile_view.dart';
import 'package:w2s/app/views/animation/shimmer_animation.dart';
import 'package:w2s/app/views/animation/top_to_bottom_animation.dart';
import 'package:w2s/app/views/views/custom_image_viewer.dart';
import 'package:w2s/app/views/views/custom_profile_image_view.dart';
import 'package:w2s/app/views/animation/faded_scale_animation.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final profileController = Get.put<ProfileController>(ProfileController());

  @override
  Widget build(BuildContext context) {
    // print(' is user logged in - ${UserLoggedIn().checkisUserLoggedIn()}');

    return Scaffold(
        floatingActionButton: Fab(
          controller: controller,
        ),
        body: NestedScrollView(
          physics: const BouncingScrollPhysics(),
          floatHeaderSlivers: true,
          controller: controller.scrollController,
          headerSliverBuilder: (contex, innerBosIsScrolled) => [
            SliverAppBar(
              pinned: true,
              floating: true,
              snap: false,
              title: Builder(builder: (context) {
                return const AppBarTitle();
              }),
              centerTitle: true,
              bottom: TabBar(
                controller: controller.tabController,
                tabs: controller.myTabs,
                indicatorWeight: 3,
                enableFeedback: true,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ProfileImage(
                    outerRadius: 13,
                    innerRadius: 12,
                    onTap: () => controller.tabController.animateTo(1,
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.fastOutSlowIn),
                    strokeColor: Colors.white,
                  ),
                )
              ],
            ),
          ],
          body: TabBarView(
            controller: controller.tabController,
            children: [HomeTab(controller: controller), const ProfileView()],
          ),
        ));
  }
}

class Fab extends StatelessWidget {
  const Fab({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return controller.showFab.isFalse
          ? FadedScaleAnimation(
              controller.shouldAutoscroll.isTrue
                  ? FloatingActionButton(
                      heroTag: null,
                      mini: true,
                      tooltip: 'scroll to top',
                      child: const FaIcon(
                        FontAwesomeIcons.chevronUp,
                        color: Colors.white,
                      ),
                      onPressed: () => controller.scrollToTop())
                  : Container(
                      color: Colors.transparent,
                      height: 1,
                      width: 1,
                    ),
            )
          : const SizedBox.shrink();
    });
  }
}

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          width: 5,
        ),
        const Text('W2S '),
        TopToBottomAnimationView(
          duration: const Duration(milliseconds: 1000),
          child: SizedBox(
              height: 25,
              width: 25,
              child: Image.asset(
                ImageAssets.logo,
                fit: BoxFit.contain,
                color: Colors.white,
              )),
        ),
        const Text(' Store'),
      ],
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final HomeController controller;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: FutureBuilder<Model>(
          future: controller.musicData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return RefreshIndicator(
                onRefresh: () => controller.musicData,
                child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    physics: const BouncingScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.feed.entry.length,
                    itemBuilder: (context, index) {
                      final name =
                          snapshot.data!.feed.entry[index].imName.label;
                      final image2x =
                          snapshot.data!.feed.entry[index].imImage[2].label;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          onTap: () => ImageView(
                                  imagePath: image2x,
                                  imageTitle: name,
                                  isImageFromPath: false)
                              .showImage(context),
                          leading: Image.network(image2x),
                          title: Text(name),
                        ),
                      );
                    }),
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const Center(
              child: ShimmerAnimation(),
            );
          },
        ),
      ),
    );
  }
}
