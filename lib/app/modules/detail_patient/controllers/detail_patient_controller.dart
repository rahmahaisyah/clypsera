import 'package:get/get.dart';
import '../../../data/models/user_profile_model.dart';

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
    if (Get.arguments != null && Get.arguments is String) {
      patientId = Get.arguments as String;
    }
    fetchPatientDetails(patientId ?? "dummy_id_123");
  }

  Future<void> fetchPatientDetails(String id) async {
    try {
      isLoading.value = true;
      await Future.delayed(
          const Duration(seconds: 1)); // Simulasi network delay

      // --- Simulasi pengambilan data dari API atau sumber lain ---
      // Data dummy sekarang menggunakan UserProfileModel tunggal
      final dummyData = UserProfileModel(
        id: id,
        name: 'Rehan Merbabu',
        email:
            'rehan.merbabu@example.com', // Tambahkan email jika ada di UI atau diperlukan
        avatarUrl:
            'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8ZmFjZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=300&q=60',
        gender: Gender.male,
        dateOfBirth: DateTime(2002, 4, 24),
        address: 'Asrama putra telkom university, Gedung 7 kamar no.122',
        phoneNumber: '081234567890', // Contoh
        nik: '3201234567890001', // Contoh
        job: 'Mahasiswa', // Contoh

        // Informasi Penyakit
        type: 'Unilateral cleft lip',
        organizer: 'Yayasan baik mulia',
        uploadDate:
            '08 Juni 2025', // Ini bisa jadi String atau DateTime tergantung kebutuhan

        // Informasi Pengobatan
        operationLocation: 'RS. Mana aja yang deket bojongsoang',
        operationTechnique: 'Teknik C',
        operationDate: '12 Juni 2025', // Ini bisa jadi String atau DateTime
      );
      patientData.value = dummyData;
      // --- Akhir Simulasi ---
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memuat detail pasien: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
      );
      print("Error fetching patient details: $e");
    } finally {
      isLoading.value = false;
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
