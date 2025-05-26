import 'package:flutter/material.dart';
import 'package:clypsera/app/data/models/patient_model.dart';
import 'package:clypsera/app/shared/theme/app_style.dart'; // Asumsi Style ada di sini
import 'package:clypsera/app/constants/uidata.dart'; // Asumsi genderFemaleIcon & genderMaleIcon ada di sini

class PatientListItem extends StatelessWidget {
  final PatientModel patient;
  final VoidCallback? onTap;

  const PatientListItem({
    super.key,
    required this.patient,
    this.onTap,
  });

  Widget _getGenderIcon(Gender gender) {
    // Anda perlu konstanta URL ikon gender di uidata.dart
    // Contoh: genderFemaleIcon, genderMaleIcon
    String iconUrl;
    switch (gender) {
      case Gender.female:
        iconUrl = genderFemaleIcon; // Dari uidata.dart
        break;
      case Gender.male:
        iconUrl = genderMaleIcon; // Dari uidata.dart
        break;
      default:
        return const SizedBox(width: 36, height: 36, child: Icon(Icons.person, size: 24)); // Fallback
    }
    return Image.network(
      iconUrl,
      width: 20, // Ukuran ikon gender yang lebih kecil
      height: 20,
      errorBuilder: (context, error, stackTrace) => const Icon(Icons.person_outline, size: 20),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: Style.whiteColor, // Atau warna card dari desain
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Avatar/Gender Icon Container
            Container(
              padding: const EdgeInsets.all(10), // Padding di dalam lingkaran
              decoration: BoxDecoration(
                color: Style.greyColor1 ?? Colors.grey[200], // Warna latar belakang lingkaran
                shape: BoxShape.circle,
              ),
              child: _getGenderIcon(patient.gender),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    patient.name,
                    style: Style.headLineStyle3?.copyWith(fontWeight: FontWeight.bold), // Sesuaikan style
                  ),
                  const SizedBox(height: 4),
                  Text(
                    patient.cleftDescription,
                    style: Style.textStyle?.copyWith(fontSize: 12, color: Style.greyColor1), // Sesuaikan style
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            Text(
              patient.date,
              style: Style.textStyle?.copyWith(fontSize: 12, color: Style.greyColor1), // Sesuaikan style
            ),
          ],
        ),
      ),
    );
  }
}