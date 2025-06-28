enum Gender { male, female, unknown }

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

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] as String,
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      avatarUrl: json['avatarUrl'] as String?,
      gender: _genderFromString(json['gender'] as String?),
      job: json['job'] as String?,
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.tryParse(json['dateOfBirth'] as String)
          : null,
      phoneNumber: json['phoneNumber'] as String?,
      nik: json['nik'] as String?,
      address: json['address'] as String?,
      type: json['type'] as String? ?? 'N/A',
      organizer: json['organizer'] as String? ?? 'N/A',
      uploadDate: json['uploadDate'] as String? ?? 'N/A',
      operationLocation: json['operationLocation'] as String? ?? 'N/A',
      operationTechnique: json['operationTechnique'] as String? ?? 'N/A',
      operationDate: json['operationDate'] as String? ?? 'N/A',
    );
  }

  // Method untuk mengubah instance menjadi JSON (engirim ke server)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'avatarUrl': avatarUrl,
      'gender': gender,
      'job': job,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'phoneNumber': phoneNumber,
      'nik': nik,
      'address': address,
      'type': type,
      'organizer': organizer,
      'uploadDate': uploadDate,
      'operationLocation': operationLocation,
      'operationTechnique': operationTechnique,
      'operationDate': operationDate,
    };
  }

  // Helper untuk konversi Gender dari/ke String (untuk JSON)
  static Gender _genderFromString(String? genderString) {
    switch (genderString?.toLowerCase()) {
      case 'male':
        return Gender.male;
      case 'female':
        return Gender.female;
      default:
        return Gender.unknown;
    }
  }
}
