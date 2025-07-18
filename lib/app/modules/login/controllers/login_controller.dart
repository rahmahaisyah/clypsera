import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../routes/app_pages.dart';
import '../../../services/auth_service.dart';

class LoginController extends GetxController {
  final AuthService _authService = AuthService();

  var rememberMe = false.obs;
  var isPasswordHidden = true.obs;
  var isLoading = false.obs;

  final email = ''.obs;
  final password = ''.obs;

  @override
  void onInit() {
    super.onInit();
    _loadRememberedEmail();
  }

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleRememberMe(bool? value) => rememberMe.value = value ?? false;

  Future<void> login() async {
    if (email.value.isEmpty || password.value.isEmpty) {
      Get.snackbar('Error', 'Email dan password tidak boleh kosong');
      return;
    }

    try {
      isLoading.value = true;
      final responseData = await _authService.login(email.value, password.value);

      // Handle remember me functionality
      final prefs = await SharedPreferences.getInstance();
      if (rememberMe.value) {
        await prefs.setString('remember_email', email.value);
      } else {
        await prefs.remove('remember_email');
      }

      // Get user name from response or stored data
      final userName = responseData['user']?['name'] ?? 
                       responseData['user']?['nama'] ?? 
                       prefs.getString('user_name') ?? 
                       'User';

      Get.snackbar('Sukses', 'Selamat datang, $userName');
      Get.offAllNamed(Routes.bottomnavigation);
    } catch (e) {
      Get.snackbar('Login Gagal', e.toString().replaceAll('Exception: ', ''));
    } finally {
      isLoading.value = false;
    }
  }

  void goToForgotPassword() {
    Get.offAllNamed(Routes.forgetPassword);
  }

  void _loadRememberedEmail() async {
    final prefs = await SharedPreferences.getInstance();
    final rememberedEmail = prefs.getString('remember_email');
    if (rememberedEmail != null) {
      email.value = rememberedEmail;
      rememberMe.value = true;
    }
  }
}