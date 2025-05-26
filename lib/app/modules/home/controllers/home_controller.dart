import 'package:clypsera/app/data/models/cleft_type_model.dart';
import 'package:clypsera/app/data/models/patient_model.dart';
import 'package:clypsera/app/constants/uidata.dart'; // Untuk icon URLs
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxString searchQuery = ''.obs;
  final TextEditingController searchController = TextEditingController();

  // --- Data untuk Jenis Sumbing Bibir ---
  final RxList<CleftTypeModel> cleftTypes = <CleftTypeModel>[].obs;
  // Menampilkan 4 item awal, sisanya bisa di "Lainnya"
  final RxList<CleftTypeModel> displayedCleftTypes = <CleftTypeModel>[].obs;
  final RxBool showAllCleftTypes = false.obs;

  // --- Data untuk Daftar Pasien ---
  final RxList<PatientModel> patients = <PatientModel>[].obs;
  // Bisa juga tambahkan RxList<PatientModel> filteredPatients jika ada search

  @override
  void onInit() {
    super.onInit();
    _loadInitialData();
    searchController.addListener(() {
      searchQuery.value = searchController.text;
      // Implementasi filter jika diperlukan
      // _filterPatients();
    });
  }

  void _loadInitialData() {
    // Data dummy untuk Jenis Sumbing Bibir
    // Ganti URL ikon dengan konstanta dari uidata.dart
    cleftTypes.assignAll([
      CleftTypeModel(id: '1', name: 'Unilateral', iconUrl: unilateralIcon), // uidata.unilateralIcon
      CleftTypeModel(id: '2', name: 'Bilateral', iconUrl: bilateralIcon),   // uidata.bilateralIcon
      CleftTypeModel(id: '3', name: 'Palate Anatomy', iconUrl: plateAnatomyIcon),// uidata.palateAnatomyIcon
      CleftTypeModel(id: '4', name: 'Cutting Marking', iconUrl: cuttingMarkingIcon),// uidata.cuttingMarkingIcon
      CleftTypeModel(id: '5', name: 'Syndromic', iconUrl: notifIcon), // Ganti dengan ikon yang sesuai
      CleftTypeModel(id: '6', name: 'Submucous', iconUrl: notifIcon), // Ganti dengan ikon yang sesuai
    ]);
    _updateDisplayedCleftTypes();

    // Data dummy untuk Daftar Pasien
    patients.assignAll([
      PatientModel(id: 'p1', name: 'Nama Cewe', gender: Gender.female, cleftDescription: 'Unilateral cleft anatomy', date: '4 June'),
      PatientModel(id: 'p2', name: 'Nama Pria', gender: Gender.male, cleftDescription: 'Bilateral cleft anatomy', date: '22 June'),
      PatientModel(id: 'p3', name: 'Nama Cewe', gender: Gender.female, cleftDescription: 'Bilateral cleft anatomy', date: '4 June'),
      PatientModel(id: 'p4', name: 'Nama Cowo', gender: Gender.male, cleftDescription: 'Palate anatomy', date: '22 June'),
      PatientModel(id: 'p5', name: 'Nama Cewe', gender: Gender.female, cleftDescription: 'Bilateral cleft anatomy', date: '4 June'),
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
    // Implementasi navigasi atau aksi ketika jenis sumbing di-tap
    Get.snackbar('Tapped', 'Jenis Sumbing: ${cleftType.name}');
    // Contoh: Get.toNamed('/cleft-type-detail', arguments: cleftType.id);
  }

  void onPatientTap(PatientModel patient) {
    // Implementasi navigasi atau aksi ketika pasien di-tap
    Get.snackbar('Tapped', 'Pasien: ${patient.name}');
    // Contoh: Get.toNamed('/patient-detail', arguments: patient.id);
  }

  void onSeeMorePatientsTap() {
    // Implementasi navigasi ke halaman daftar pasien lengkap
    Get.snackbar('Tapped', 'Lihat semua pasien');
    // Contoh: Get.toNamed(Routes.PATIENT_LIST);
  }
  
  void onNotificationTap() {
    Get.snackbar('Tapped', 'Notifikasi');
    // Contoh: Get.toNamed(Routes.NOTIFICATIONS);
  }

  // void _filterPatients() {
  //   if (searchQuery.value.isEmpty) {
  //     // tampilkan semua atau reset ke daftar awal
  //   } else {
  //     // logika filter berdasarkan searchQuery.value
  //   }
  // }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}