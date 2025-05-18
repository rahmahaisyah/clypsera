import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final String? icon;
  final VoidCallback onPress;
  final Color col;
  final Color borderColor;
  final TextStyle textStyle;

  const CustomButton(
      {super.key,
      required this.text,
      this.icon,
      required this.onPress,
      required this.col,
      required this.borderColor,
      required this.textStyle});

  @override
  Widget build(BuildContext context) {
    if (icon != null) {
      return Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          splashColor: Color(0xFFF8F8F8),
          onTap: onPress,
          child: Ink(
            width: 350,
            height: 53,
            decoration: BoxDecoration(
              border: Border.all(
                color: borderColor, // or any color you want
                width: 1, // border thickness
              ),
              color: col,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/icons/$icon',
                  height: 16, // Increased size
                  width: 16,
                ),
                SizedBox(width: 5),
                Text(
                  text,
                  style: textStyle,
                )
              ],
            ),
          ),
        ),
      );
    }
    return InkWell(
      borderRadius: BorderRadius.circular(10),
      splashColor: Color(0xFFF8F8F8),
      onTap: onPress,
      child: Ink(
        width: 350,
        height: 53,
        decoration: BoxDecoration(
          color: col,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: borderColor, // or any color you want
            width: 1.5, // border thickness
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: textStyle,
          ),
        ),
      ),
    );
  }
}
