import 'package:clypsera/app/modules/home/views/home_view.dart';
import 'package:clypsera/app/modules/news/views/news_view.dart';
import 'package:clypsera/app/modules/profile/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/uidata.dart';
import '../../../data/models/navigation_item_model.dart';
import '../../home/controllers/home_controller.dart';
import '../../news/controllers/news_controller.dart';
import '../../profile/controllers/profile_controller.dart';

class BottomnavigationController extends GetxController {
  RxInt currentIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<NewsController>(
        () => NewsController());
    Get.lazyPut<ProfileController>(
        () => ProfileController()); 
  }

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
