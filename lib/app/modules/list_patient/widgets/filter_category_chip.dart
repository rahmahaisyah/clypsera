import 'package:flutter/material.dart';
import '../../../shared/theme/app_style.dart'; 

class FilterCategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  // Anda bisa menambahkan parameter icon jika setiap chip memiliki icon sendiri

  const FilterCategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        margin: const EdgeInsets.only(right: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? Style.primaryColor : Style.whiteColor, // Warna berdasarkan status terpilih
          borderRadius: BorderRadius.circular(20.0),
          border: Border.all(
            color: isSelected ? Style.primaryColor : Style.greyColor2, // Warna border
            width: 1.0,
          ),
          boxShadow: isSelected ? [
            BoxShadow(
              color: Style.primaryColor.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            )
          ] : [],
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Style.whiteColor : Style.primaryColor, // Warna teks
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            fontSize: 13, // Sesuaikan ukuran font
          ),
        ),
      ),
    );
  }
}
