import 'package:intl/intl.dart';
import '../enums/gender.dart';

class PatientDetailModel {
  final int id;
  final String name;
  final DateTime? dateOfBirth;
  final Gender gender;
  final String? address;
  final String? phoneNumber;

  final String? diseaseType;
  final String? diseaseOrganizer;
  final DateTime? uploadDate;

  final String? operationLocation;
  final String? operationTechnique;
  final DateTime? operationDate;
  final String? followUp;

  final String? familyHistory;
  final String? ethnicGroup;
  final int? childOrder;

  final String? beforeOperationImage;
  final String? afterOperationImage;

  const PatientDetailModel({
    required this.id,
    required this.name,
    this.dateOfBirth,
    this.gender = Gender.unknown,
    this.address,
    this.phoneNumber,
    this.diseaseType,
    this.diseaseOrganizer,
    this.uploadDate,
    this.operationLocation,
    this.operationTechnique,
    this.operationDate,
    this.followUp,
    this.familyHistory,
    this.ethnicGroup,
    this.childOrder,
    this.beforeOperationImage,
    this.afterOperationImage,
  });

  factory PatientDetailModel.fromJson(Map<String, dynamic> json) {
    final operasi = json['operasi'] ?? {};
    final jenisKelainan = operasi['jenis_kelainan'] ?? {};

    return PatientDetailModel(
      id: json['id'] ?? 0,
      name: json['nama_pasien'] ?? 'Tidak Diketahui',
      dateOfBirth: json['tanggal_lahir'] != null
          ? DateTime.tryParse(json['tanggal_lahir'])
          : null,
      gender: _parseGender(json['jenis_kelamin']),
      address: json['alamat_pasien'] ?? 'Alamat Tidak Tersedia',
      phoneNumber: json['no_telepon'] ?? 'Tidak Ada',

      // Disease Information
      diseaseType: jenisKelainan['nama_kelainan'] ?? 'Tidak Diketahui',
      diseaseOrganizer: operasi['nama_penyelenggara'] ?? 'Tidak Tersedia',
      uploadDate: json['created_at'] != null
          ? DateTime.tryParse(json['created_at'])
          : null,

      // Operation Information
      operationLocation: operasi['lokasi_operasi'] ?? 'Tidak Tersedia',
      operationTechnique: operasi['tehnik_operasi'] ?? 'Tidak Tersedia',
      operationDate: operasi['tanggal_operasi'] != null
          ? DateTime.tryParse(operasi['tanggal_operasi'])
          : null,
      followUp: operasi['follow_up'] ?? 'Tidak Ada Informasi Tindak Lanjut',

      // Additional Information
      familyHistory: json['riwayat_keluarga_pasien'] ?? 'Tidak Diketahui',
      ethnicGroup: json['suku_pasien'] ?? 'Tidak Diketahui',
      childOrder: json['pasien_anak_ke_berapa'],

      // Operation Images
      beforeOperationImage: operasi['foto_sebelum_operasi'],
      afterOperationImage: operasi['foto_setelah_operasi'],
    );
  }

  // Helper methods
  String formatDate(DateTime? date) {
    return date != null
        ? DateFormat('dd MMMM yyyy').format(date)
        : 'Tidak Tersedia';
  }

  String formatAge() {
    if (dateOfBirth == null) return 'Tidak Diketahui';

    final now = DateTime.now();
    int age = now.year - dateOfBirth!.year;

    // Check if birthday hasn't occurred this year
    if (now.month < dateOfBirth!.month ||
        (now.month == dateOfBirth!.month && now.day < dateOfBirth!.day)) {
      age--;
    }

    return '$age tahun';
  }

  static Gender _parseGender(String? genderCode) {
    switch (genderCode) {
      case 'L':
        return Gender.male;
      case 'P':
        return Gender.female;
      default:
        return Gender.unknown;
    }
  }
}
