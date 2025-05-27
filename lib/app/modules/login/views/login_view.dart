import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
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
        child: Center(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                CustomTextform(
                  title: "kata Sandi",
                  textHint: "Password",
                  obscureText: controller.isPasswordHidden.value,
                  onChanged: (val) => controller.password.value = val,
                  onIconTap: controller.togglePasswordVisibility,
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    SizedBox(width: 80),
                    GestureDetector(
                      onTap: () {},
                      child:
                          Text("Lupa kata sandi?", style: Style.headLineStyle5),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                CustomButton(
                  text: "Masuk",
                  onTap: () {
                    Get.offAllNamed(Routes.bottomnavigation);
                  },
                  textStyle: Style.headLineStyle6,
                  color: Style.primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
