import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/routes/app_pages.dart';
import 'app/shared/theme/app_style.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "Clypsera",
      initialRoute: AppPages.initial,
      getPages: AppPages.routes,
      theme: ThemeData(
        scaffoldBackgroundColor: Style.whiteColor,
      ),
    ),
  );
}
