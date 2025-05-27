import 'package:clypsera/app/constants/uidata.dart';

class YayasanModel {
  final String id;
  final String imageUrl; 
  final String name;
  final String location;

  YayasanModel({
    required this.id,
    required this.imageUrl,
    required this.name,
    required this.location,
  });

  // Contoh factory constructor jika Anda mengambil data dari JSON
  factory YayasanModel.fromJson(Map<String, dynamic> json) {
    return YayasanModel(
      id: json['id'] as String? ?? DateTime.now().millisecondsSinceEpoch.toString(),
      imageUrl: json['imageUrl'] as String? ?? noImage,
      name: json['name'] as String? ?? 'Nama Yayasan Tidak Tersedia',
      location: json['location'] as String? ?? 'Lokasi Tidak Diketahui',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'imageUrl': imageUrl,
      'name': name,
      'location': location,
    };
  }
}