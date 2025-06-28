import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../theme/app_style.dart';

class CustomTextform extends StatelessWidget {
  final String title;
  final String textHint;
  final String? icon;
  final bool? obscureText;
  final void Function(String)? onChanged;
  final VoidCallback? onIconTap;
  final TextEditingController? controller;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final bool readOnly;

  const CustomTextform({
    super.key,
    required this.title,
    required this.textHint,
    this.icon,
    this.obscureText,
    this.onChanged,
    this.onIconTap,
    this.controller,
    this.suffixIcon,
    this.keyboardType,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Style.headLineStyle5),
        SizedBox(
          width: Get.width,
          child: TextFormField(
            controller: controller,
            onChanged: onChanged,
            obscureText: obscureText ?? false,
            keyboardType: keyboardType,
            readOnly: readOnly,
            decoration: InputDecoration(
              hintText: textHint,
              hintStyle: Style.headLineStyle5,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              suffixIcon: suffixIcon ??
                  (onIconTap != null
                      ? Padding(
                          padding: const EdgeInsets.only(right: 12),
                          child: IconButton(
                            icon: Icon(
                              obscureText ?? false
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              size: 20,
                            ),
                            onPressed: onIconTap,
                          ),
                        )
                      : null),
            ),
          ),
        ),
      ],
    );
  }
}