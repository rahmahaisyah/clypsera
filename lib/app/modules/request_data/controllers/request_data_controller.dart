import 'package:clypsera/app/constants/uidata.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../data/models/patient_detail_model.dart';
import '../../../data/models/patient_request_model.dart';
import '../../../services/auth_service.dart';
import '../../../services/core/request_data_service.dart';
import '../widgets/request_dialog.dart';

class RequestDataController extends GetxController {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final nikController = TextEditingController();
  final purposeController = TextEditingController();
  final Rx<PatientDetailModel?> selectedPatient = Rx<PatientDetailModel?>(null);
  final selectedCategory = RxnInt();
  final isLoading = false.obs;
  final AuthService _authService = Get.find<AuthService>();

  final categories = <Map<String, Object>>[
    {
      'icon': researchIcon,
      'title': 'Riset dan penelitian',
      'desc': 'Lorem ipsum dolor sit amet gajnahdo kaot jak.'
    },
    {
      'icon': commercialIcon,
      'title': 'Komersial',
      'desc': 'Lorem ipsum dolor sit amet gajnahdo kaot jak.'
    },
  ];

  @override
  void onInit() {
    super.onInit();
    final patient = Get.arguments as PatientDetailModel?;
    if (patient != null) {
      selectPatient(patient);
    }
  }

  void selectPatient(PatientDetailModel patient) {
    selectedPatient.value = patient;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  bool _isValidPhoneNumber(String phone) {
    return RegExp(r'^[0-9]{10,12}$').hasMatch(phone);
  }

  bool _isValidNIK(String nik) {
    return RegExp(r'^\d{15}$').hasMatch(nik);
  }

  Future<void> submitData() async {
    if (!_validateInputs()) return;

    try {
      isLoading.value = true;

      final userId = await _authService.getCurrentUserId();
      if (userId == null) {
        Get.snackbar(
          'Error',
          'Gagal mendapatkan ID pengguna. Silakan login ulang.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        return;
      }

      final userScope = await _authService.getCurrentUserScope() ?? 'sendiri';
      final categoryId = selectedCategory.value != null
          ? (selectedCategory.value! + 1).toString()
          : throw Exception('Category not selected');

      final request = PatientRequestModel(
        userId: userId, 
        kategoriId: categoryId,
        namaPemohon: nameController.text.trim(),
        nikPemohon: nikController.text.trim(),
        emailPemohon: emailController.text.trim(),
        noTelepon: phoneController.text.trim(),
        statusPermohonan: "pending",
        alasanPermohonan: purposeController.text.trim(),
        operasiId: selectedPatient.value!.id.toString(),
        scope: userScope,
      );

      await RequestDataService.submitRequest(request);
      Get.dialog(const RequestDialog());
      _resetForm();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal mengirim permintaan: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  bool _validateInputs() {
    if (nameController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Nama pemohon harus diisi');
      return false;
    }

    if (phoneController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Nomor telepon harus diisi');
      return false;
    }

    if (!_isValidPhoneNumber(phoneController.text.trim())) {
      Get.snackbar('Error', 'Nomor telepon tidak valid (10-12 digit)');
      return false;
    }

    if (emailController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Email harus diisi');
      return false;
    }

    if (!_isValidEmail(emailController.text.trim())) {
      Get.snackbar('Error', 'Format email tidak valid');
      return false;
    }

    if (nikController.text.trim().isEmpty) {
      Get.snackbar('Error', 'NIK harus diisi');
      return false;
    }

    if (!_isValidNIK(nikController.text.trim())) {
      Get.snackbar('Error', 'NIK harus terdiri dari 16 digit');
      return false;
    }

    if (selectedCategory.value == null) {
      Get.snackbar('Error', 'Kategori harus dipilih');
      return false;
    }

    if (purposeController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Tujuan penggunaan data harus diisi');
      return false;
    }

    if (selectedPatient.value == null) {
      Get.snackbar('Error', 'Pasien harus dipilih');
      return false;
    }

    return true;
  }

  void _resetForm() {
    nameController.clear();
    phoneController.clear();
    emailController.clear();
    nikController.clear();
    purposeController.clear();
    selectedCategory.value = null;
    selectedPatient.value = null;
  }

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
