import '../enums/gender.dart';

class UserProfileModel {
  final String id;
  final String name;
  final String email;
  final String? avatarUrl;
  final Gender gender;
  final String? job;
  final DateTime? dateOfBirth;
  final String? phoneNumber;
  final String? nik;
  final String? address;
  final String? type;
  final String? organizer;
  final String? uploadDate;
  final String? operationLocation;
  final String? operationTechnique;
  final String? operationDate;

  const UserProfileModel({
    required this.id,
    required this.name,
    required this.email,
    this.avatarUrl,
    required this.gender,
    this.job,
    this.dateOfBirth,
    this.phoneNumber,
    this.nik,
    this.address,
    this.type,
    this.organizer,
    this.uploadDate,
    this.operationLocation,
    this.operationTechnique,
    this.operationDate,
  });

  factory UserProfileModel.fromApiJson(Map<String, dynamic> json) {
    final operasi = json['operasi'] ?? {};
    return UserProfileModel(
      id: (json['id'] ?? '').toString(),
      name: json['nama_pasien'] ?? '',
      email: '', 
      avatarUrl: '',
      gender: _genderFromApiCode(json['jenis_kelamin']),
      dateOfBirth: DateTime.tryParse(json['tanggal_lahir'] ?? ''),
      phoneNumber: json['no_telepon'],
      address: json['alamat_pasien'],
      type: json['kelainan_kotigental'],
      operationLocation: operasi['lokasi_operasi'],
      operationTechnique: operasi['teknik_operasi'],
      operationDate: operasi['tanggal_operasi'],
    );
  }

// Method baru untuk mapping gender dari kode API
  static Gender _genderFromApiCode(String? genderCode) {
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
