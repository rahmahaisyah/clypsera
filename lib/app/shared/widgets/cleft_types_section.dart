import 'package:flutter/cupertino.dart';
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
        const SizedBox(height: 10),
        Obx(
          () => GridView.builder(
            itemCount: controller.displayedCleftTypes.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              childAspectRatio: 0.8,
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
        if (controller.cleftTypes.length > 4)
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Divider(
              color: Style.primaryColorOp4,
              thickness: 4,
              height: 4,
            ),
          ),
        Align(
          alignment: Alignment.center,
          child: InkWell(
            onTap: controller.toggleShowAllCleftTypes,
            borderRadius: BorderRadius.circular(8.0),
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4),
              child: Obx(() {
                final bool isShowingAll = controller.showAllCleftTypes.value;
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      isShowingAll ? 'Lebih Sedikit' : 'Lainnya',
                      style: Style.headLineStyle16,
                    ),
                    const SizedBox(width: 8),
                    Icon(
                      isShowingAll
                          ? CupertinoIcons.chevron_up
                          : CupertinoIcons.chevron_down,
                      size: 18,
                      color: Style
                          .primaryColor, 
                    ),
                  ],
                );
              }),
            ),
          ),
        ),
      ],
    );
  }
}
