class NewsArticleModel {
  final String id;
  final String title; // Digunakan untuk judul utama di Rekomendasi
  final String? snippet; // Bisa digunakan untuk teks di Breaking News Card
  final String? imageUrl;
  final String? articleUrl; // URL ke artikel lengkap
  final DateTime publishedDate;
  final String? source; // Nama sumber berita, mis. "Kompass.com"
  final String? sourceIconUrl; // URL ikon sumber berita (opsional)
  final String? category; // Mis. "Bandung" untuk Rekomendasi
  final bool isBookmarked; // Untuk ikon bookmark

  NewsArticleModel({
    required this.id,
    required this.title,
    this.snippet,
    this.imageUrl,
    this.articleUrl,
    required this.publishedDate,
    this.source,
    this.sourceIconUrl,
    this.category,
    this.isBookmarked = false,
  });

  // factory NewsArticleModel.fromJson(Map<String, dynamic> json) { ... }
}