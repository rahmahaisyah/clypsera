class NewsArticleModel {
  final String id;
  final String title; 
  final String? snippet; 
  final String? imageUrl;
  final String? articleUrl; 
  final DateTime publishedDate;
  final String? source; 
  final String? sourceIconUrl; 
  final bool isBookmarked; 

  NewsArticleModel({
    required this.id,
    required this.title,
    this.snippet,
    this.imageUrl,
    this.articleUrl,
    required this.publishedDate,
    this.source,
    this.sourceIconUrl,
    this.isBookmarked = false,
  });

  // factory NewsArticleModel.fromJson(Map<String, dynamic> json) { ... }
}