import 'package:clypsera/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:clypsera/app/shared/theme/app_style.dart';
import 'patient_list_item.dart';
import '../../../data/models/patient_model.dart';

class PatientListSection extends StatelessWidget {
  final bool showHeader;
  final List<PatientModel>? patientsToDisplay;
  final VoidCallback? onSeeMoreTap;

  const PatientListSection({
    super.key,
    this.showHeader = true,
    this.patientsToDisplay,
    this.onSeeMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    final List<PatientModel>? currentPatients = patientsToDisplay;

    Widget header() => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Daftar Pasien',
              style: Style.headLineStyle12,
            ),
            if (onSeeMoreTap != null)
              TextButton(
                onPressed: onSeeMoreTap,
                child: Text(
                  'Selengkapnya',
                  style: Style.headLineStyle4,
                ),
              ),
          ],
        );

    // Loading/null state
    if (currentPatients == null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showHeader) header(),
          if (showHeader) const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: Text(
                'Memuat data pasien...',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      );
    }

    // Empty state
    if (currentPatients.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showHeader) header(),
          if (showHeader) const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: Text(
                'Tidak ada data pasien.',
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      );
    }

    // Data state
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showHeader) header(),
        if (showHeader) const SizedBox(height: 8),
        ListView.builder(
          itemCount: currentPatients.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final patient = currentPatients[index];
            return PatientListItem(
              patient: patient,
              onTap: () =>
                  Get.toNamed(Routes.detailPatient, arguments: patient.id),
            );
          },
        ),
      ],
    );
  }
}
