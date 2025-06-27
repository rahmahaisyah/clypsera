import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/theme/app_style.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/widgets/custom_textform.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 65),
                Text(
                  "Selamat Datang!👋🏻",
                  style: Style.headLineStyle8,
                ),
                SizedBox(height: 28),
                CustomTextform(
                  title: "Email",
                  textHint: "Your Email",
                  onChanged: (val) => controller.email.value = val,
                ),
                SizedBox(height: 22),
                Obx(() => CustomTextform(
                      title: "Kata Sandi",
                      textHint: "Password",
                      obscureText: controller.isPasswordHidden.value,
                      onChanged: (val) => controller.password.value = val,
                      onIconTap: controller.togglePasswordVisibility,
                    )),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Obx(
                          () => Checkbox(
                            value: controller.rememberMe.value,
                            onChanged: controller.toggleRememberMe,
                          ),
                        ),
                        Text(
                          "Ingat saya",
                          style: Style.headLineStyle5,
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: controller.goToForgotPassword,
                      child:
                          Text("Lupa kata sandi?", style: Style.headLineStyle5),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Obx(() {
                  if (controller.isLoading.value) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return CustomButton(
                    text: "Masuk",
                    onTap: controller.login,
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
