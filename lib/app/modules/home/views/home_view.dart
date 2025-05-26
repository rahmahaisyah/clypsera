import 'package:clypsera/app/constants/uidata.dart';
import 'package:clypsera/app/shared/theme/app_style.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.whiteColor,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Clypsera',
              style: Style.headLineStyle2,
            ),
            
            Image.network(
              notifIcon,
              width: 16,
              height: 16,
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 16),
        ),
      ),
    );
  }
}
