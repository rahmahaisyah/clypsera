import 'package:clypsera/app/constants/uidata.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class RequestDataController extends GetxController {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final nikController = TextEditingController();
  final purposeController = TextEditingController();

  final selectedCategory = RxnInt();
  final categories = <Map<String, Object>> [
    {'icon': researchIcon, 'title': 'Riset dan penelitian', 'desc': 'Lorem ipsum dolor sit amet gajnahdo kaot jak.'},
    {'icon': commercialIcon, 'title': 'Komersial', 'desc': 'Lorem ipsum dolor sit amet gajnahdo kaot jak.'},
  ];

  @override
  void onClose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    nikController.dispose();
    purposeController.dispose();
    super.onClose();
  }
}