import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_service.dart';
import '../../../data/models/user_profile_model.dart';
import '../../../shared/theme/app_style.dart';

class ProfileController extends GetxController {
  final AuthService _authService = AuthService();
  final Rx<UserProfileModel?> currentUser = Rx<UserProfileModel?>(null);
  final RxBool isLoading = true.obs;
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchUserProfile();
  }

  Future<void> fetchUserProfile() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final prefs = await SharedPreferences.getInstance();
      final name = prefs.getString('user_name');
      final email = prefs.getString('user_email');

      if (name != null && email != null) {
        currentUser.value = UserProfileModel(
          name: name,
          email: email,
        );
      } else {
        final loginData = await _authService.getLoginData();
        if (loginData != null) {
          currentUser.value = UserProfileModel(
            name: loginData['name'] ?? '',
            email: loginData['email'] ?? '',
          );
          
          await prefs.setString('user_name', currentUser.value!.name);
          await prefs.setString('user_email', currentUser.value!.email);
        } else {
          errorMessage.value = 'Gagal memuat data profil.';
        }
      }
    } catch (e) {
      errorMessage.value = "Terjadi kesalahan: ${e.toString()}";
      print("Error fetching profile: $e");
    } finally {
      isLoading.value = false;
    }
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
          if (Get.isDialogOpen ?? false) {
            Get.back();
          }
          isLoading.value = true;
          await _authService.logout();
          isLoading.value = false;
          Get.offAllNamed(Routes.login);
        } catch (e) {
          isLoading.value = false;
          Get.snackbar(
            'Logout Gagal',
            e.toString(),
          );
        }
      },
      onCancel: () {
        if (Get.isDialogOpen ?? false) {
          Get.back();
        }
      },
    );
  }
}
