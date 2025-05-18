// ignore_for_file: unnecessary_overrides
import 'package:get/get.dart';

class LoginController extends GetxController {
  var rememberMe = false.obs;
  var obscurePassword = true.obs;

  final email = ''.obs;
  final password = ''.obs;
  var isPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleRememberMe(bool? value) => rememberMe.value = value ?? false;

  Future<void> login() async {
    try {
      // final user = await _authService.login(email.value, password.value);
      // if (user != null) {
      //   Get.offNamed(Routes.BOTTOMNAVIGATION);
      // }
    } catch (e) {
      Get.snackbar('Login Failed', e.toString());
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      // // final user = await _authService.loginWithGoogle();
      // // if (user != null) {
      // //   Get.offNamed(Routes.BOTTOMNAVIGATION);
      // } else {
      //   Get.snackbar('Login Canceled', 'User canceled the Google sign-in.');
      // }
    } catch (e) {
      Get.snackbar('Login Failed', e.toString());
    }
  }

  void goToForgotPassword() {
    Get.toNamed('/forgot-password');
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
