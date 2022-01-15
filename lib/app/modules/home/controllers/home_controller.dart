import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'package:w2s/app/data/models/image_model.dart';
import 'package:w2s/app/data/services/api_services.dart';

class HomeController extends GetxController with SingleGetTickerProviderMixin {
  late TabController tabController;
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
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }
}
