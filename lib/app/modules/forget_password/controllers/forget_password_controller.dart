import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../services/auth_service.dart';

class ForgetPasswordController extends GetxController {
  final emailController = TextEditingController();
  var isLoading = false.obs;

  final AuthService _authService = AuthService();

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }

  Future<void> sendResetLink() async {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      Get.snackbar('Error', 'Email tidak boleh kosong');
      return;
    }

    isLoading.value = true;
    try {
      final message = await _authService.forgetPassword(email);
      if (Get.isRegistered<ForgetPasswordController>()) {
        Get.snackbar('Info', message ?? 'Berhasil request reset password');
      }
    } catch (e) {
      if (Get.isRegistered<ForgetPasswordController>()) {
        Get.snackbar('Gagal', e.toString().replaceAll('Exception: ', ''));
      }
    } finally {
      if (Get.isRegistered<ForgetPasswordController>()) {
        isLoading.value = false;
      }
    }
  }
}