import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onTap;
  final Color? color;
  final TextStyle? textStyle;

  const CustomButton({
    super.key,
    this.text,
    this.onTap,
    this.color,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: Get.width,
          height: 53,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            splashColor: Color(0xFFF8F8F8),
            onTap: onTap,
            child: Ink(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text!,
                    style: textStyle,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
