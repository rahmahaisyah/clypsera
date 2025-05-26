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
          style: Style.headLineStyle12,
        ),
        const SizedBox(height: 5),
        Obx(
          () => GridView.builder(
            itemCount: controller.displayedCleftTypes.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4, // 4 item per baris
              childAspectRatio:
                  0.8, 
              crossAxisSpacing: 10,
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
        const SizedBox(
          height: 5,
        ),
        Align(
          alignment: Alignment.center,
          child: TextButton(
            onPressed: controller.toggleShowAllCleftTypes,
            child: Obx(() => Text(
                  controller.showAllCleftTypes.value
                      ? 'Lebih Sedikit'
                      : 'Lainnya',
                  style: Style.headLineStyle16,
                )),
          ),
        ),
      ],
    );
  }
}
