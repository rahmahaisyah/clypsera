import 'package:clypsera/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:clypsera/app/modules/home/controllers/home_controller.dart'; // Komentari jika tidak digunakan
import 'package:clypsera/app/shared/theme/app_style.dart';
import 'patient_list_item.dart'; // Pastikan PatientListItem sudah ada
import '../../../data/models/patient_model.dart'; // Pastikan path ini benar

class PatientListSection extends StatelessWidget {
  final bool showHeader;
  final List<PatientModel>? patientsToDisplay; // Tetap nullable
  final VoidCallback? onSeeMoreTap;

  const PatientListSection({
    super.key,
    this.showHeader = true,
    this.patientsToDisplay,
    this.onSeeMoreTap,
  });

  @override
  Widget build(BuildContext context) {
    // Gunakan variabel lokal untuk keamanan null dan keterbacaan
    final List<PatientModel>? currentPatients = patientsToDisplay;

    // 1. Handle kasus jika currentPatients adalah null
    if (currentPatients == null) {
      if (!showHeader) {
        return const SizedBox.shrink(); // Jangan tampilkan apa-apa jika header disembunyikan
      }
      // Tampilkan header dan pesan "Tidak ada data" jika header ditampilkan
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showHeader) // Header hanya ditampilkan jika showHeader true
            Row(
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
            ),
          if (showHeader) const SizedBox(height: 8),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: Text(
                'Memuat data pasien...', // Atau pesan yang sesuai untuk null state
                style: TextStyle(color: Colors.grey),
              ),
            ),
          ),
        ],
      );
    }

    // 2. Handle kasus jika currentPatients tidak null, tapi kosong
    // Pada titik ini, currentPatients dijamin tidak null
    if (currentPatients.isEmpty) {
      if (!showHeader) {
        return const SizedBox.shrink();
      }
      // Tampilkan header dan pesan "Tidak ada data pasien"
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (showHeader)
            Row(
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
            ),
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

    // 3. Jika currentPatients tidak null dan tidak kosong, tampilkan daftar
    // Pada titik ini, currentPatients dijamin tidak null dan tidak kosong
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showHeader)
          Row(
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
          ),
        if (showHeader) const SizedBox(height: 8),
        ListView.builder(
          itemCount: currentPatients.length, // Tidak perlu '!'
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            final patient = currentPatients[index]; // Tidak perlu '!'
            return PatientListItem(
              patient: patient,
              onTap: () => Get.toNamed(Routes.detailPatient, arguments: patient.id),
            );
          },
        ),
      ],
    );
  }
}
