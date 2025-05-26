import 'package:flutter/material.dart';
import 'package:clypsera/app/shared/theme/app_style.dart'; 

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
      onTap: onTap, // Jika search bar tidak langsung aktif dan perlu di-tap dulu
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Style.greyColor1 ?? Colors.grey[200], // Warna dari desain
          borderRadius: BorderRadius.circular(30), // Radius dari desain
        ),
        child: Row(
          children: [
            Icon(Icons.search, color: Style.greyColor1 ?? Colors.grey[600]),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: controller,
                onChanged: onChanged,
                enabled: onTap == null, // Hanya aktif jika tidak ada onTap custom
                decoration: InputDecoration(
                  hintText: hintText,
                  hintStyle: Style.textStyle?.copyWith(color: Style.greyColor1 ?? Colors.grey[600]),
                  border: InputBorder.none,
                  isDense: true, // Mengurangi padding internal TextField
                  contentPadding: EdgeInsets.zero,
                ),
                style: Style.textStyle, // Gaya teks input
              ),
            ),
          ],
        ),
      ),
    );
  }
}