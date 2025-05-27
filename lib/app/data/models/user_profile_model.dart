import 'package:equatable/equatable.dart';

enum Gender { male, female, unknown }

class UserProfileModel extends Equatable {
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
  });

  // Factory constructor untuk membuat instance dari JSON (data dari API)
  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      gender: _genderFromString(json['gender'] as String?),
      job: json['job'] as String?,
      dateOfBirth: json['dateOfBirth'] != null 
                   ? DateTime.tryParse(json['dateOfBirth'] as String) 
                   : null,
      phoneNumber: json['phoneNumber'] as String?,
      nik: json['nik'] as String?,
      address: json['address'] as String?,
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
    };
  }

  // CopyWith untuk update immutable
  UserProfileModel copyWith({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
    Gender? gender,
    String? job,
    DateTime? dateOfBirth,
    String? phoneNumber,
    String? nik,
    String? address,
    String? bio,
  }) {
    return UserProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      gender: gender ?? this.gender,
      job: job ?? this.job,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      nik: nik ?? this.nik,
      address: address ?? this.address,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        avatarUrl,
        gender,
        job,
        dateOfBirth,
        phoneNumber,
        nik,
        address,
      ];

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