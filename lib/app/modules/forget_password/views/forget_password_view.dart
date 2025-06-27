import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/theme/app_style.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_textform.dart';
import '../controllers/forget_password_controller.dart';

class ForgetPasswordView extends GetView<ForgetPasswordController> {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.whiteColor,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56),
        child: AppBar(
          backgroundColor: Style.whiteColor,
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () => Get.offAllNamed(Routes.login),
          ),
        ),
      ),
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 15),
              Text(
                "Lupa Kata Sandi?",
                style: Style.headLineStyle8,
              ),
              const SizedBox(height: 12),
              Text(
                'Masukkan email Anda untuk mengatur ulang kata sandi.',
                style: Style.textStyle,
                textAlign: TextAlign.left,
              ),
              const SizedBox(height: 28),
              CustomTextform(
                title: "Email",
                textHint: "Your Email",
                controller: controller.emailController,
              ),
              const SizedBox(height: 30),
              Obx(() {
                if (controller.isLoading.value) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return CustomButton(
                  text: "Kirim Link Reset",
                  onTap: controller.sendResetLink,
                  textStyle: Style.headLineStyle6,
                  color: Style.primaryColor,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
