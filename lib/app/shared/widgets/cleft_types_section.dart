import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clypsera/app/modules/home/controllers/home_controller.dart';
import 'package:clypsera/app/shared/theme/app_style.dart';

import 'cleft_type_card.dart';

class CleftTypesSection extends GetView<HomeController> {
  const CleftTypesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Jenis sumbing bibir',
          style: Style.headLineStyle3?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Obx(
          () => GridView.builder(
            itemCount: controller.displayedCleftTypes.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // 4 item per baris
              childAspectRatio: 0.85, // Sesuaikan rasio agar pas
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (context, index) {
              final cleftType = controller.displayedCleftTypes[index];
              return CleftTypeCard(
                cleftType: cleftType,
                onTap: () => controller.onCleftTypeTap(cleftType),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
        if (controller.cleftTypes.length > 4) // Tampilkan tombol "Lainnya" jika item lebih dari 4
          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: controller.toggleShowAllCleftTypes,
              child: Obx(() => Text(
                controller.showAllCleftTypes.value ? 'Lebih Sedikit' : 'Lainnya',
                style: Style.textStyle?.copyWith(color: Style.primaryColor, fontWeight: FontWeight.bold),
              )),
            ),
          ),
      ],
    );
  }
}