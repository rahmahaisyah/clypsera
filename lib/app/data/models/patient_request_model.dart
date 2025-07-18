class PatientRequestModel {
  final int? userId;
  final String kategoriId;
  final String namaPemohon;
  final String nikPemohon;
  final String emailPemohon;
  final String noTelepon;
  final String statusPermohonan;
  final String alasanPermohonan;
  final String operasiId;
  final String? scope;

  PatientRequestModel({
    this.userId,
    required this.kategoriId,
    required this.namaPemohon,
    required this.nikPemohon,
    required this.emailPemohon,
    required this.noTelepon,
    required this.statusPermohonan,
    required this.alasanPermohonan,
    required this.operasiId,
    this.scope,  
  });

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'kategori_id': kategoriId,
      'nama_pemohon': namaPemohon,
      'nik_pemohon': nikPemohon,
      'email_pemohon': emailPemohon,
      'no_telepon': noTelepon,
      'status_permohonan': statusPermohonan,
      'alasan_permohonan': alasanPermohonan,
      'operasi_id': operasiId,
      'scope': scope
    };
  }
}