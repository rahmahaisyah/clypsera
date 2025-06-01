import 'package:clypsera/app/shared/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/rekomendasi_yayasan_controller.dart';
import 'yayasan_card.dart';

class RekomendasiYayasanSection extends StatelessWidget {
  const RekomendasiYayasanSection({super.key});

  @override
  Widget build(BuildContext context) {
    final RekomendasiYayasanController controller =
        Get.put(RekomendasiYayasanController());

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Rekomendasi yayasan', style: Style.headLineStyle12),
              TextButton(
                onPressed: controller.onSeeMoreTapped,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: const Size(50, 30),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Selengkapnya',
                  style: Style.headLineStyle4,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16.0),
          Obx(() {
            if (controller.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            if (controller.yayasanList.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text('Tidak ada rekomendasi yayasan saat ini.'),
                ),
              );
            }

            return SizedBox(
              height: 185,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.yayasanList.length,
                itemBuilder: (context, index) {
                  final yayasan = controller.yayasanList[index];
                  return YayasanCard(
                    yayasan: yayasan,
                    onTap: () => controller.onYayasanCardTapped(yayasan),
                  );
                },
              ),
            );
          }),
        ],
      ),
    );
  }
}
