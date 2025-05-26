import 'package:flutter/material.dart';
import 'package:clypsera/app/shared/theme/app_style.dart';
import 'package:flutter/cupertino.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onTap;
  final TextEditingController? controller;

  const CustomSearchBar({
    super.key,
    this.hintText = 'Cari kata kunci',
    this.onChanged,
    this.onTap,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onTap, 
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: Style.primaryColorOp4, 
          borderRadius: BorderRadius.circular(18), 
        ),
        child: Row(
          children: [
            Icon(CupertinoIcons.search, color: Style.greyColor1),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                enabled:
                    onTap == null, 
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: Style.headLineStyle4,
                  border: InputBorder.none,
                  isDense: true, 
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
