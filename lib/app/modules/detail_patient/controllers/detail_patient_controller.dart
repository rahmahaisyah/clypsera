import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/models/patient_detail_model.dart';
import '../../../services/core/patient_service.dart';

class DetailPatientController extends GetxController {
  final RxBool isLoading = true.obs;
  final Rx<PatientDetailModel?> patientData = Rx<PatientDetailModel?>(null);
  final RxBool isPatientInfoExpanded = true.obs;
  final RxBool isDiseaseInfoExpanded = false.obs;
  final RxBool isTreatmentInfoExpanded = false.obs;
  final RxBool isImagesExpanded = false.obs;

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
}