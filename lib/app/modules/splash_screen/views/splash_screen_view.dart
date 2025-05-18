import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/splash_screen_controller.dart';

class SplashScreenView extends GetView<SplashScreenController> {
  const SplashScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), (() {
      Get.offAllNamed(Routes.LOGIN);
    }));

    return Scaffold(
        backgroundColor: Colors.white,
        body: SizedBox(
          width: Get.width,
          height: Get.height,
          child: Center(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/logo.png'),
                  scale: 2,
                ),
              ),
            ),
          ),
        ));
  }
}
