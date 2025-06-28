import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final dobController = TextEditingController();
  final phoneController = TextEditingController();
  final nikController = TextEditingController();
  final addressController = TextEditingController();

  final avatarUrl = ''.obs;

  final jobList = ['Unknown', 'Dokter', 'Mahasiswa', 'Guru', 'Lainnya'];
  final selectedJob = 'Unknown'.obs;

  @override
  void onInit() {
    super.onInit();
    // TODO: Load user data here, for now dummy
    nameController.text = 'Nama lengkap';
    emailController.text = 'email@kamu.com';
    dobController.text = '01/01/2000';
    phoneController.text = '';
    nikController.text = '';
    addressController.text = '';
    avatarUrl.value = '';
    selectedJob.value = 'Unknown';
  }

  void onEditAvatarTap() {
    // TODO: Implement pick image logic
    Get.snackbar('Info', 'Fitur ubah foto belum tersedia');
  }

  void onPickDate() async {
    DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      dobController.text = '${picked.day.toString().padLeft(2, '0')}/${picked.month.toString().padLeft(2, '0')}/${picked.year}';
    }
  }

  void onJobChanged(String? value) {
    if (value != null) selectedJob.value = value;
  }

  void onPinLocationTap() {
    // TODO: Implement pin location logic
    Get.snackbar('Info', 'Fitur pin lokasi belum tersedia');
  }

  void onSaveProfile() {
    // TODO: Implement save profile logic
    Get.snackbar('Berhasil', 'Profil berhasil disimpan');
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    dobController.dispose();
    phoneController.dispose();
    nikController.dispose();
    addressController.dispose();
    super.onClose();
  }
}