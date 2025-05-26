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
    // Definisikan ukuran ikon dan container ikon di sini agar mudah diubah
    const double iconRenderSize = 36.0; // Ukuran ikon akan dirender
    const double iconContainerSize = 60.0; // Ukuran container pembungkus ikon
    const double iconContainerBorderRadius = 12.0;

    return InkWell(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            // Container untuk latar belakang ikon
            width: iconContainerSize,
            height: iconContainerSize,
            decoration: BoxDecoration(
              color: Style.primaryColorOp4, // Warna latar belakang ikon
              borderRadius: BorderRadius.circular(iconContainerBorderRadius),
            ),
            child: Center(
              // Untuk memastikan ikon ada di tengah jika ada perbedaan ukuran
              child: ClipRRect(
                // Memastikan gambar ikon juga ter-clip
                borderRadius: BorderRadius.circular(iconContainerBorderRadius),
                child: Image.network(
                  cleftType.iconUrl,
                  width: iconRenderSize,
                  height: iconRenderSize,
                  fit: BoxFit.fitWidth,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const SizedBox(
                        width: iconRenderSize,
                        height: iconRenderSize,
                        child: Center(
                            child: CircularProgressIndicator(
                          strokeWidth: 2,
                        )));
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            cleftType.name,
            textAlign: TextAlign.center,
            style: Style.headLineStyle17, // Sesuaikan style ini agar cocok
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
