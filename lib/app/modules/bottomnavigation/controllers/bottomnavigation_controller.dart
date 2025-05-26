import 'package:clypsera/app/modules/home/views/home_view.dart';
import 'package:clypsera/app/modules/news/views/news_view.dart';
import 'package:clypsera/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/uidata.dart';

class NavigationItemModel {
  final String activeIconPath;
  final String inactiveIconPath;
  final String label;
  final Widget screen;

  NavigationItemModel({
    required this.activeIconPath,
    required this.inactiveIconPath,
    required this.label,
    required this.screen,
  });
}

class BottomnavigationController extends GetxController {
  RxInt currentIndex = 0.obs;

  final List<NavigationItemModel> navigationItems = [
    NavigationItemModel(
      activeIconPath: homeActiveIcon,
      inactiveIconPath: homeIcon,
      label: 'Beranda',
      screen: const HomeView(),
    ),
    NavigationItemModel(
      activeIconPath: newsActiveIcon,
      inactiveIconPath: newsIcon,
      label: 'Berita',
      screen: const NewsView(),
    ),
    NavigationItemModel(
      activeIconPath: profileActiveIcon,
      inactiveIconPath: profileIcon,
      label: 'Profil',
      screen: const ProfileView(),
    ),
  ];

  Widget get currentScreen => navigationItems[currentIndex.value].screen;

  void changePage(int index) {
    if (currentIndex.value == index) return;
    currentIndex.value = index;
  }
}
