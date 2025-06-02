import 'package:clypsera/app/data/models/cleft_type_model.dart';
import 'package:clypsera/app/data/models/patient_model.dart';
import 'package:clypsera/app/constants/uidata.dart';
import 'package:clypsera/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxString searchQuery = ''.obs;
  final TextEditingController searchController = TextEditingController();

  final RxList<CleftTypeModel> cleftTypes = <CleftTypeModel>[].obs;
  final RxList<CleftTypeModel> displayedCleftTypes = <CleftTypeModel>[].obs;
  final RxBool showAllCleftTypes = false.obs;

  final RxList<PatientModel> patients = <PatientModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadInitialData();
    searchController.addListener(() {
      searchQuery.value = searchController.text;
    });
  }

  void _loadInitialData() {
    cleftTypes.assignAll([
      CleftTypeModel(id: '1', name: 'Unilateral', iconUrl: unilateralIcon),
      CleftTypeModel(id: '2', name: 'Bilateral', iconUrl: bilateralIcon),
      CleftTypeModel(
          id: '3', name: 'Palate Anatomy', iconUrl: plateAnatomyIcon),
      CleftTypeModel(
          id: '4', name: 'Cutting Marking', iconUrl: cuttingMarkingIcon),
      CleftTypeModel(id: '5', name: 'Syndromic', iconUrl: notifIcon),
      CleftTypeModel(id: '6', name: 'Submucous', iconUrl: notifIcon),
    ]);
    _updateDisplayedCleftTypes();

    patients.assignAll([
      PatientModel(
          id: 'p1',
          name: 'Nama Cewe',
          gender: Gender.female,
          cleftDescription: 'Unilateral cleft anatomy',
          date: '4 June'),
      PatientModel(
          id: 'p2',
          name: 'Nama Pria',
          gender: Gender.male,
          cleftDescription: 'Bilateral cleft anatomy',
          date: '22 June'),
      PatientModel(
          id: 'p3',
          name: 'Nama Cewe',
          gender: Gender.female,
          cleftDescription: 'Bilateral cleft anatomy',
          date: '4 June'),
      PatientModel(
          id: 'p4',
          name: 'Nama Cowo',
          gender: Gender.male,
          cleftDescription: 'Palate anatomy',
          date: '22 June'),
      PatientModel(
          id: 'p5',
          name: 'Nama Cewe',
          gender: Gender.female,
          cleftDescription: 'Bilateral cleft anatomy',
          date: '4 June'),
    ]);
  }

  void _updateDisplayedCleftTypes() {
    if (showAllCleftTypes.value) {
      displayedCleftTypes.assignAll(cleftTypes);
    } else {
      displayedCleftTypes.assignAll(cleftTypes.take(4).toList());
    }
  }

  void toggleShowAllCleftTypes() {
    showAllCleftTypes.value = !showAllCleftTypes.value;
    _updateDisplayedCleftTypes();
  }

  void onCleftTypeTap(CleftTypeModel cleftType) {
    Get.snackbar('Tapped', 'Jenis Sumbing: ${cleftType.name}');
  }

  void onSeeMorePatientsTap() {
    Get.offAllNamed(Routes.listPatient);
  }

  void onNotificationTap() {
    Get.snackbar('Tapped', 'Notifikasi');
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
