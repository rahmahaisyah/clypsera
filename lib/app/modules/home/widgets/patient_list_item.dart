import 'package:flutter/material.dart';
import 'package:clypsera/app/data/models/patient_model.dart'; // Pastikan enum Gender ada di sini
import 'package:clypsera/app/shared/theme/app_style.dart';
import 'package:clypsera/app/constants/uidata.dart'; // Pastikan genderFemaleIcon dan genderMaleIcon didefinisikan di sini

class PatientListItem extends StatelessWidget {
  final PatientModel patient;
  final VoidCallback? onTap;

  const PatientListItem({
    super.key,
    required this.patient,
    this.onTap,
  });

  Map<String, dynamic> _getGenderIconData(Gender gender) {
    String iconUrl;
    Color iconContainerColor; // Mengganti nama variabel agar lebih jelas (warna background container ikon)

    switch (gender) {
      case Gender.female:
        iconUrl = genderFemaleIcon; // Dari uidata.dart
        iconContainerColor = Style.blueColor2; // Warna background untuk Female
        break; // <-- BREAK YANG HILANG DITAMBAHKAN DI SINI
      case Gender.male:
        iconUrl = genderMaleIcon; // Dari uidata.dart
        iconContainerColor = Style.primaryColor; // Warna background untuk Male
        break;
      default: // Untuk Gender.unknown atau kasus lainnya
        // Jika Gender.unknown, kita akan menampilkan ikon placeholder
        return {
          'isIconData': true, // Flag untuk membedakan antara IconData dan URL
          'iconData': Icons.person_outline_rounded, // Menggunakan IconData
          'color': Colors.grey.shade400 // Warna background untuk Unknown
        };
    }
    // Mengembalikan URL dan warna background container jika Male atau Female
    return {'isIconData': false, 'url': iconUrl, 'color': iconContainerColor};
  }

  @override
  Widget build(BuildContext context) {
    final Color cardBackgroundColor = Style.whiteColor;
    final Color avatarCircleBackgroundColor = Colors.grey.shade200;
    const double avatarCircleDiameter = 52.0;
    const double genderIconContainerDiameter = 28.0;
    const double genderIconSize = 16.0; // Ukuran untuk ikon di dalam container

    final genderData = _getGenderIconData(patient.gender);
    final bool useIconData = genderData['isIconData'] as bool;

    // Style teks
    final TextStyle patientNameStyle = Style.headLineStyle9;
    final TextStyle patientDetailStyle = Style.headLineStyle15;

    return Card(
      elevation: 1.5,
      margin: const EdgeInsets.only(bottom: 12.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
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
              SizedBox(
                width: avatarCircleDiameter + (genderIconContainerDiameter / 3),
                height: avatarCircleDiameter,
                child: Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Container( // Avatar placeholder
                      width: avatarCircleDiameter,
                      height: avatarCircleDiameter,
                      decoration: BoxDecoration(
                        color: avatarCircleBackgroundColor,
                        shape: BoxShape.circle,
                        // Anda bisa menambahkan gambar avatar pasien di sini jika ada
                        // image: patient.avatarUrl != null ? DecorationImage(image: NetworkImage(patient.avatarUrl!), fit: BoxFit.cover) : null,
                      ),
                      // child: patient.avatarUrl == null ? Icon(Icons.person, color: Colors.grey.shade400, size: 30) : null, // Placeholder jika tidak ada avatar
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0, // Sesuaikan posisi jika perlu, gambar Anda menunjukkan sedikit ke atas
                      child: Container(
                        width: genderIconContainerDiameter,
                        height: genderIconContainerDiameter,
                        decoration: BoxDecoration(
                            color: genderData['color'] as Color,
                            shape: BoxShape.circle,
                            border: Border.all(
                                color: cardBackgroundColor, // Border putih seperti di gambar
                                width: 2.0),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.15),
                                  blurRadius: 3,
                                  offset: const Offset(1, 1))
                            ]),
                        child: Center(
                          child: useIconData
                              ? Icon( // Untuk Gender.unknown
                                  genderData['iconData'] as IconData,
                                  color: Colors.white, // Ikon putih di atas background berwarna
                                  size: genderIconSize)
                              : Image.network( // Untuk Gender.male/female
                                  genderData['url'] as String,
                                  width: genderIconSize,
                                  height: genderIconSize,
                                  color: Colors.white, // Penting: membuat gambar ikon menjadi putih
                                  fit: BoxFit.contain,
                                  // Error builder jika URL gambar gagal dimuat
                                  errorBuilder: (context, error, stackTrace) =>
                                      Icon(Icons.help_outline, // Ikon placeholder jika gambar error
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
                patient.date, // Asumsi patient.date adalah string tanggal yang sudah diformat
                style: patientDetailStyle.copyWith(fontSize: 11, color: Style.greyColor2), // Sedikit lebih kecil dan abu-abu
              ),
            ],
          ),
        ),
      ),
    );
  }
}