import 'package:get/get.dart';
import '../../../data/models/user_profile_model.dart';
import '../../../services/core/patient_service.dart';

class DetailPatientController extends GetxController {
  final RxBool isLoading = true.obs;
  final Rx<UserProfileModel?> patientData = Rx<UserProfileModel?>(null);

  final RxBool isPatientInfoExpanded = true.obs;
  final RxBool isDiseaseInfoExpanded = false.obs;
  final RxBool isTreatmentInfoExpanded = false.obs;

  String? patientId;

  @override
  void onInit() {
    super.onInit();

    // Get patient ID from arguments
    if (Get.arguments != null && Get.arguments is String) {
      patientId = Get.arguments as String;
    }

    print("Patient ID received: $patientId"); 


    fetchPatientDetails(patientId ?? "");
  }

  Future<void> fetchPatientDetails(String id) async {
    try {
      isLoading.value = true;

      print("Fetching patient details for ID: $id"); 

      if (id.isEmpty) {
        throw Exception('Patient ID tidak valid');
      }

      // Use the PatientService instead of direct Dio call
      final patientDetail = await PatientService.fetchPatientDetail(id);

      patientData.value = patientDetail;
      print("Patient data loaded successfully");
    } catch (e) {
      print("Error fetching patient details: $e");

      // Show user-friendly error message
      Get.snackbar(
        'Error',
        e.toString().replaceAll('Exception: ', ''),
        snackPosition: SnackPosition.TOP,
      );

      patientData.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  // Method untuk refresh data
  Future<void> refreshPatientData() async {
    if (patientId != null) {
      await fetchPatientDetails(patientId!);
    }
  }

  void togglePatientInfoExpansion(bool isExpanded) {
    isPatientInfoExpanded.value = isExpanded;
  }

  void toggleDiseaseInfoExpansion(bool isExpanded) {
    isDiseaseInfoExpanded.value = isExpanded;
  }

  void toggleTreatmentInfoExpansion(bool isExpanded) {
    isTreatmentInfoExpanded.value = isExpanded;
  }

  void onOtherInfoTapped(bool isExpanded) {
    Get.snackbar(
        'Navigasi', isExpanded ? 'Menuju Informasi Lainnya...' : 'Ditutup',
        snackPosition: SnackPosition.TOP);
  }

  void onImagesTapped(bool isExpanded) {
    Get.snackbar('Navigasi', isExpanded ? 'Menuju Galeri Gambar...' : 'Ditutup',
        snackPosition: SnackPosition.TOP);
  }
}
