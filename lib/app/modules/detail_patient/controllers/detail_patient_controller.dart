import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/patient_detail_model.dart';
import '../../../services/core/patient_service.dart';

class DetailPatientController extends GetxController {
  final RxBool isLoading = true.obs;
  final Rx<PatientDetailModel?> patientData = Rx<PatientDetailModel?>(null);
  final RxBool isRequestDataAvailable = false.obs;
  final RxBool isImagesExpanded = false.obs;
  final RxBool isPatientInfoExpanded = true.obs;
  final RxBool isDiseaseInfoExpanded = false.obs;
  final RxBool isTreatmentInfoExpanded = false.obs;

  String? patientId;

  @override
  void onInit() {
    super.onInit();
    patientId = Get.arguments as String?;
    if (patientId != null) {
      fetchPatientDetails(patientId!);
    }
  }

  Future<void> fetchPatientDetails(String id) async {
    try {
      isLoading.value = true;
      final patient = await PatientService.fetchPatientDetail(id);
      patientData.value = patient;
    } catch (e) {
      print('Error: $e');
      Get.snackbar(
        'Error',
        'Gagal memuat detail pasien',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshPatientData() async {
    if (patientId != null) {
      await fetchPatientDetails(patientId!);
    }
  }

  void requestAdditionalData() {
    try {
      Get.snackbar(
        'Berhasil',
        'Link reset berhasil dikirim',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Gagal',
        'Gagal mengirim link reset',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void togglePatientInfoExpansion(bool value) {
    isPatientInfoExpanded.value = value;
  }

  void toggleDiseaseInfoExpansion(bool value) {
    isDiseaseInfoExpanded.value = value;
  }

  void toggleTreatmentInfoExpansion(bool value) {
    isTreatmentInfoExpanded.value = value;
  }

  void toggleImagesExpansion(bool value) {
    isImagesExpanded.value = value;
  }

  void viewBeforeOperationImage() {
    final beforeImage = patientData.value?.beforeOperationImage;
    if (beforeImage != null) {
      showImageDialog('Gambar Sebelum Operasi', beforeImage);
    } else {
      Get.snackbar(
        'Informasi',
        'Tidak ada gambar sebelum operasi',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void viewAfterOperationImage() {
    final afterImage = patientData.value?.afterOperationImage;
    if (afterImage != null) {
      showImageDialog('Gambar Setelah Operasi', afterImage);
    } else {
      Get.snackbar(
        'Informasi',
        'Tidak ada gambar setelah operasi',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void showImageDialog(String title, String imageUrl) {
    if (imageUrl.startsWith('file:///') || !imageUrl.startsWith('http')) {
      Get.dialog(
        AlertDialog(
          title: Text(title),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.error, color: Colors.red, size: 50),
              const SizedBox(height: 10),
              Text(
                'Gagal memuat gambar\nFormat URL tidak valid: $imageUrl',
                textAlign: TextAlign.center,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: const Text('Tutup'),
            ),
          ],
        ),
      );
      return;
    }
    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Image.network(
          imageUrl,
          fit: BoxFit.contain,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(child: CircularProgressIndicator());
          },
          errorBuilder: (context, error, stackTrace) {
            print('Image load error: $error');
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.error, color: Colors.red, size: 50),
                const SizedBox(height: 10),
                Text(
                  'Gagal memuat gambar\n$error',
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Tutup'),
          ),
        ],
      ),
      barrierDismissible: true,
    );
  }
}
