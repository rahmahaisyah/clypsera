import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_service.dart';

class LoginController extends GetxController {
  // Instance dari AuthService
  final AuthService _authService = AuthService(); 

  // State untuk UI
  var rememberMe = false.obs;
  var isPasswordHidden = true.obs;
  var isLoading = false.obs; 

  // State untuk form
  final email = ''.obs;
  final password = ''.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleRememberMe(bool? value) => rememberMe.value = value ?? false;

  Future<void> login() async {
    // Validasi sederhana agar tidak memanggil API jika form kosong
    if (email.value.isEmpty || password.value.isEmpty) {
      Get.snackbar('Error', 'Email dan password tidak boleh kosong');
      return;
    }

    try {
      isLoading.value = true; // Mulai loading
      final responseData = await _authService.login(email.value, password.value);

      // Jika berhasil, simpan token
      final accessToken = responseData['access_token'];
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', accessToken);

      Get.snackbar('Sukses', 'Login berhasil!');
      Get.offAllNamed(Routes.bottomnavigation); 

    } catch (e) {
      Get.snackbar('Login Gagal', e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false; 
    }
  }

  void goToForgotPassword() {
    // Get.toNamed('/forgot-password'); // Uncomment jika route sudah ada
    Get.snackbar('Info', 'Fitur ini belum tersedia');
  }

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}