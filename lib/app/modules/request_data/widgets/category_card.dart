import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String desc;
  final bool selected;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.icon,
    required this.title,
    required this.desc,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.only(right: 12),
        decoration: BoxDecoration(
          border: Border.all(
            color: selected ? Theme.of(context).primaryColor : Colors.grey[300]!,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12),
          color: selected ? Theme.of(context).primaryColor.withOpacity(0.08) : Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 32, color: selected ? Theme.of(context).primaryColor : Colors.grey),
            const SizedBox(height: 8),
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
            const SizedBox(height: 4),
            Text(desc, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
          ],
        ),
      ),
    );
  }
}