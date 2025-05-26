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

  // Fungsi ini sekarang hanya mengembalikan URL ikon dan warna tint berdasarkan gender
  // Pembuatan widget Image akan dilakukan di dalam build method agar bisa di-stack
  Map<String, dynamic> _getGenderIconData(Gender gender) {
    String iconUrl;
    // Warna tint untuk ikon gender (misalnya, biru tua untuk male, pink/biru muda untuk female)
    // Definisikan ini di app_style.dart
    Color iconTintColor;

    switch (gender) {
      case Gender.female:
        iconUrl = genderFemaleIcon; // Dari uidata.dart
        iconTintColor = Color(0xffA3BDCD); // Contoh warna
        break;
      case Gender.male:
        iconUrl = genderMaleIcon; // Dari uidata.dart
        iconTintColor = Style.primaryColor; // Contoh warna
        break;
      default:
        // Fallback jika gender tidak diketahui
        return {
          'iconData': Icons.person_rounded,
          'color': Colors.grey.shade600
        };
    }
    return {'url': iconUrl, 'color': iconTintColor};
  }

  @override
  Widget build(BuildContext context) {
    final Color cardBackgroundColor = Style.whiteColor ?? Colors.white;
    // Warna untuk lingkaran besar di belakang ikon gender (abu-abu sangat muda)
    final Color avatarCircleBackgroundColor = Colors.grey.shade200;
    // Ukuran untuk lingkaran avatar besar dan ikon gender
    const double avatarCircleDiameter =
        52.0; // Diameter lingkaran abu-abu besar
    const double genderIconContainerDiameter =
        28.0; // Diameter lingkaran berwarna ikon gender
    const double genderIconSize =
        16.0; // Ukuran render ikon gender di dalam lingkarannya

    final genderData = _getGenderIconData(patient.gender);

    // Style teks
    final TextStyle patientNameStyle = Style.headLineStyle9;
    final TextStyle patientDetailStyle = Style.headLineStyle15;

    return Card(
      elevation: 1.5,
      margin: const EdgeInsets.only(bottom: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(16), // Radius lebih besar untuk kartu
      ),
      color: cardBackgroundColor,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // --- Bagian Avatar dan Ikon Gender ---
              SizedBox(
                width: avatarCircleDiameter +
                    (genderIconContainerDiameter /
                        3), // Lebar total untuk Stack
                height: avatarCircleDiameter,
                child: Stack(
                  alignment: Alignment
                      .centerLeft, // Atau Alignment.center untuk posisi tengah
                  children: [
                    // Lingkaran Abu-abu Besar (Avatar Placeholder)
                    Container(
                      width: avatarCircleDiameter,
                      height: avatarCircleDiameter,
                      decoration: BoxDecoration(
                        color: avatarCircleBackgroundColor,
                        shape: BoxShape.circle,
                      ),
                      // Anda bisa menambahkan Image.network di sini jika ada URL avatar pasien
                      // child: patient.avatarUrl != null
                      //   ? ClipOval(child: Image.network(patient.avatarUrl!, fit: BoxFit.cover))
                      //   : null,
                    ),
                    // Lingkaran Ikon Gender yang Menumpuk
                    Positioned(
                      // Sesuaikan posisi agar sedikit tumpang tindih dan ke kanan bawah
                      right: 0,
                      bottom: 0,
                      child: Container(
                        width: genderIconContainerDiameter,
                        height: genderIconContainerDiameter,
                        decoration: BoxDecoration(
                            color: genderData['color']
                                as Color, // Warna latar ikon gender (biru/pink)
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: cardBackgroundColor,
                                width: 2.0), // Border putih
                            boxShadow: [
                              // Shadow halus untuk ikon gender
                              BoxShadow(
                                color: Colors.black.withOpacity(0.15),
                                blurRadius: 3,
                                offset: const Offset(1, 1),
                              )
                            ]),
                        child: Center(
                          child: genderData['iconData'] != null
                              ? Icon(genderData['iconData'] as IconData,
                                  color: Colors.white, size: genderIconSize)
                              : Image.network(
                                  genderData['url'] as String,
                                  width: genderIconSize,
                                  height: genderIconSize,
                                  color: Colors
                                      .white, // Ikon gender berwarna putih di atas latar berwarna
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(Icons.person,
                                          size: genderIconSize,
                                          color: Colors.white),
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      patient.name,
                      style: patientNameStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      patient.cleftDescription,
                      style: patientDetailStyle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Text(
                patient.date,
                style: patientDetailStyle.copyWith(fontSize: 11),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
