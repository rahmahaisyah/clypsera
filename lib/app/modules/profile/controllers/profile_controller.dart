import 'package:clypsera/app/data/models/user_profile_model.dart';
import 'package:clypsera/app/shared/theme/app_style.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../data/enums/gender.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_service.dart';

class ProfileController extends GetxController {
  final AuthService _authService = AuthService();
  final Rx<UserProfileModel?> currentUser = Rx<UserProfileModel?>(null);
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;
  final DateFormat _dateFormatter = DateFormat('dd/MM/yyyy');

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      // TODO: Ganti dengan logika pengambilan data pengguna dari service/API
      // currentUser.value = await _authService.getCurrentUserProfile();

      // Data dummy sesuai desain image_5f7ad7.png
      await Future.delayed(const Duration(seconds: 1));
      currentUser.value = UserProfileModel(
        id: 'user123',
        name: 'Rahmah Aisyah',
        email: 'rahmahasyh@gmail.com',
        avatarUrl: '',
        gender: Gender.female,
        job: 'Mahasiswa',
        dateOfBirth: DateTime(2006, 03, 19),
        phoneNumber: '0857-1633-7149',
        nik: '127183617771666280',
        address: 'Jl. Telekomunikasi, Telkom University.',
      );

      if (currentUser.value == null) {
        errorMessage.value = 'Gagal memuat data profil.';
      }
    } catch (e) {
      errorMessage.value = "Terjadi kesalahan: ${e.toString()}";
      print("Error fetching profile: $e");
    } finally {
      isLoading.value = false;
    }
  }

  String getFormattedDateOfBirth() {
    if (currentUser.value?.dateOfBirth != null) {
      return _dateFormatter.format(currentUser.value!.dateOfBirth!);
    }
    return 'N/A';
  }

  void onNotificationTap() {
    Get.snackbar('Tapped', 'Notifikasi');
  }

  void navigateToEditProfile() {
    Get.toNamed(Routes.editProfile);
  }

  Future<void> logout() async {
    Get.defaultDialog(
      title: "Konfirmasi Logout",
      middleText: "Apakah Anda yakin ingin keluar?",
      textConfirm: "Ya, Keluar",
      textCancel: "Batal",
      confirmTextColor: Style.whiteColor,
      onConfirm: () async {
        try {
          Get.back();
          isLoading.value = true;
          await _authService.logout();
          isLoading.value = false;
          Get.offAllNamed(Routes.login);
          Get.snackbar("Logout", "Anda telah berhasil keluar.");
        } catch (e) {
          isLoading.value = false;
          Get.snackbar(
              "Logout Gagal", e.toString().replaceAll('Exception: ', ''));
        }
      },
      onCancel: () {
        if (Get.isDialogOpen ?? false) Get.back();
      },
    );
  }
}
