enum Gender { male, female, unknown }

class PatientModel {
  final String id;
  final String name;
  final Gender gender;
  final String cleftDescription;
  final String date;

  PatientModel({
    required this.id,
    required this.name,
    required this.gender,
    required this.cleftDescription,
    required this.date,
  });

  factory PatientModel.fromJson(Map<String, dynamic> json) {
    Gender gender;
    switch ((json['jenis_kelamin'] as String?)?.toUpperCase()) {
      case 'L':
        gender = Gender.male;
        break;
      case 'P':
        gender = Gender.female;
        break;
      default:
        gender = Gender.unknown;
    }

    // Ambil nama kelainan dari operasi jika ada, jika tidak fallback ke kelainan_kotigental
    String cleftDesc = json['operasi']?['jenis_kelainan']?['nama_kelainan'] ??
        json['kelainan_kotigental'] ??
        '-';

    // Ambil tanggal operasi jika ada, jika tidak fallback ke tanggal_lahir
    String date =
        json['operasi']?['tanggal_operasi'] ?? json['tanggal_lahir'] ?? '-';

    return PatientModel(
      id: json['id'].toString(),
      name: json['nama_pasien'] ?? '-',
      gender: gender,
      cleftDescription: cleftDesc,
      date: date,
    );
  }
}
