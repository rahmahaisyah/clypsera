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
              'Daftar Pasien',
              style: Style.headLineStyle12,
            ),
            TextButton(
              onPressed: controller.onSeeMorePatientsTap,
              child: Text(
                'Tampilkan Semua',
                style: Style.headLineStyle4,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8), 
        Obx(
          () => ListView.builder(
            itemCount: controller.patients.length > 5 ? 5 : controller.patients.length, 
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