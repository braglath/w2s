import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:w2s/app/data/models/image_model.dart';
import 'package:w2s/app/data/services/api_services.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  late TabController tabController;
  final showFab = false.obs;
  final shouldAutoscroll = false.obs;
  final ScrollController scrollController = ScrollController();

  final List<Tab> myTabs = <Tab>[
    const Tab(
      text: 'Collections',
      icon: FaIcon(FontAwesomeIcons.music),
    ),
    const Tab(
      text: 'Profile',
      icon: FaIcon(FontAwesomeIcons.user),
    ),
  ];
  late Future<Model> musicData;

  @override
  void onInit() {
    super.onInit();
    musicData = Data.getData();
    tabController = TabController(length: 2, vsync: this);
    tabController.addListener(tabbarListener);
    scrollController.addListener(scrollListener);
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
    scrollController.removeListener(scrollListener);
  }

  void tabbarListener() {
    if (tabController.index == 0 || tabController.indexIsChanging) {
      // print('show fab - ${showFab.value}');
      showFab.value = false;
    } else {
      showFab.value = true;
    }
  }

  void scrollListener() {
    // print('tab - ${scrollController.position.pixels}');
    if (scrollController.position.pixels > 150) {
      shouldAutoscroll.value = true;
      // print('tab - ${shouldAutoscroll.value}');
    }
    if (scrollController.position.pixels < 150) {
      shouldAutoscroll.value = false;
      // print('tab - ${shouldAutoscroll.value}');
    }
  }

  void scrollToBottomm() {
    scrollController.animateTo(scrollController.position.extentAfter,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn);
  }

  void scrollToTop() {
    const double start = 0;
    scrollController.animateTo(start,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn);
  }
}
