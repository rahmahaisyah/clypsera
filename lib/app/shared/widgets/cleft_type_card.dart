import 'package:flutter/material.dart';
import 'package:clypsera/app/data/models/cleft_type_model.dart';
import 'package:clypsera/app/shared/theme/app_style.dart';

class CleftTypeCard extends StatelessWidget {
  final CleftTypeModel cleftType;
  final VoidCallback? onTap;

  const CleftTypeCard({
    super.key,
    required this.cleftType,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12), // Untuk efek ripple yang sesuai
      child: Container(
        width: 80, // Sesuaikan lebar berdasarkan desain
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              cleftType.iconUrl,
              width: 36, // Ukuran ikon dari desain
              height: 36,
              errorBuilder: (context, error, stackTrace) => const Icon(Icons.broken_image, size: 36),
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;
                return const SizedBox(
                    width: 36, height: 36, child: Center(child: CircularProgressIndicator(strokeWidth: 2,)));
              },
            ),
            const SizedBox(height: 8),
            Text(
              cleftType.name,
              textAlign: TextAlign.center,
              style: Style.textStyle?.copyWith(fontSize: 12, fontWeight: FontWeight.w500), // Sesuaikan style
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}