import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clypsera/app/modules/home/controllers/home_controller.dart';
import 'package:clypsera/app/shared/theme/app_style.dart';
import 'patient_list_item.dart';

class PatientListSection extends GetView<HomeController> {
  const PatientListSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'daftar pasien',
              style: Style.headLineStyle3?.copyWith(fontWeight: FontWeight.bold),
            ),
            TextButton(
              onPressed: controller.onSeeMorePatientsTap,
              child: Text(
                'See more',
                style: Style.textStyle?.copyWith(color: Style.primaryColor, fontSize: 12),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8), // Sedikit spasi sebelum list
        Obx(
          () => ListView.builder(
            itemCount: controller.patients.length > 5 ? 5 : controller.patients.length, // Tampilkan maks 5, atau semua jika < 5
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final patient = controller.patients[index];
              return PatientListItem(
                patient: patient,
                onTap: () => controller.onPatientTap(patient),
              );
            },
          ),
        ),
      ],
    );
  }
}