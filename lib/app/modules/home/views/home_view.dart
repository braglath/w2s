import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:w2s/app/data/assets/image_assets.dart';

import 'package:w2s/app/data/models/image_model.dart';
import 'package:w2s/app/modules/profile/controllers/profile_controller.dart';
import 'package:w2s/app/modules/profile/views/profile_view.dart';
import 'package:w2s/app/views/views/custom_profile_image_view.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({Key? key}) : super(key: key);

  final profileController = Get.put<ProfileController>(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const AppBarTitle(),
          centerTitle: true,
          bottom: TabBar(
            controller: controller.tabController,
            tabs: controller.myTabs,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: ProfileImage(
                outerRadius: 13,
                innerRadius: 10,
                onTap: () => controller.tabController.animateTo(1,
                    duration: const Duration(milliseconds: 400),
                    curve: Curves.fastOutSlowIn),
              ),
            )
          ],
        ),
        body: TabBarView(
          controller: controller.tabController,
          children: [HomeTab(controller: controller), const ProfileView()],
        ));
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
        Hero(
          tag: 'logo',
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
    return Padding(
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
                    final name = snapshot.data!.feed.entry[index].imName.label;
                    final image2x =
                        snapshot.data!.feed.entry[index].imImage[1].label;
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        leading: Image.network(image2x),
                        title: Text(name),
                      ),
                    );
                  }),
            );
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
