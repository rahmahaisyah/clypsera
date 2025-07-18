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

      // Debug: Print all stored keys
      print('=== SharedPreferences Debug ===');
      final keys = prefs.getKeys();
      for (String key in keys) {
        final value = prefs.get(key);
        print('Key: $key, Value: $value');
      }
      print('=== End Debug ===');

      final name = prefs.getString('user_name') ?? '';
      final email = prefs.getString('email') ?? '';

      print('Loaded user_name: "$name"');
      print('Loaded email: "$email"');
      print('Name length: ${name.length}');
      print('Email length: ${email.length}');

      if (name.isNotEmpty && email.isNotEmpty) {
        currentUser.value = UserProfileModel(
          name: name,
          email: email,
        );
        print('User profile created successfully');
      } else {
        errorMessage.value = 'Data profil belum tersedia. Silakan login ulang.';
        print('Profile data is empty - Name: "$name", Email: "$email"');

        // Jika data kosong, coba redirect ke login
        Future.delayed(Duration(seconds: 2), () {
          Get.offAllNamed(Routes.login);
        });
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
