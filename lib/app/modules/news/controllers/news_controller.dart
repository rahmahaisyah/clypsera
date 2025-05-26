import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../data/models/news_article_model.dart';

class NewsController extends GetxController {
  final RxList<NewsArticleModel> breakingNewsList = <NewsArticleModel>[].obs;
  final RxList<NewsArticleModel> recommendationList = <NewsArticleModel>[].obs;
  
  final RxBool isLoadingBreaking = true.obs;
  final RxBool isLoadingRecommendations = true.obs;

  final RxInt breakingNewsCarouselIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBreakingNews();
    fetchRecommendationNews();
  }

  Future<void> fetchBreakingNews() async {
    isLoadingBreaking.value = true;
    //await Future.delayed(const Duration(milliseconds: 1200)); // Simulasi API

    // Data dummy untuk Breaking News
    breakingNewsList.assignAll([
      NewsArticleModel(
        id: 'bn1',
        title: 'Kamu makan apa hari ini, Kok enak sekali kelihatannya.', // Ini akan jadi snippet di kartu
        snippet: 'Kamu makan apa hari ini, Kok enak sekali kelihatannya.',
        imageUrl: 'https://images.unsplash.com/photo-1504674900247-0877df9cc836?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8Zm9vZHxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60', // Ganti dengan URL gambar yang relevan
        articleUrl: 'https://example.com/news/breaking1',
        publishedDate: DateTime.now().subtract(const Duration(hours: 6)),
        source: 'Kompass.com',
        isBookmarked: true,
      ),
      NewsArticleModel(
        id: 'bn2',
        title: 'Tips Jitu Menjaga Kesehatan Mental di Era Digital',
        snippet: 'Tips Jitu Menjaga Kesehatan Mental di Era Digital yang serba cepat.',
        imageUrl: 'https://images.unsplash.com/photo-1512436991641-6745cdb1723f?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Nnx8dGVjaG5vbG9neSUyMHdlbGxiZWluZ3xlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=800&q=60',
        articleUrl: 'https://example.com/news/breaking2',
        publishedDate: DateTime.now().subtract(const Duration(hours: 10)),
        source: 'TechTimes',
        isBookmarked: false,
      ),
       NewsArticleModel(
        id: 'bn3',
        title: 'Inovasi Terbaru dalam Energi Terbarukan',
        snippet: 'Penemuan baru menjanjikan solusi energi yang lebih bersih dan efisien untuk masa depan.',
        imageUrl: 'https://images.unsplash.com/photo-1497435334941-8c899ee9e8e9?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTF8fHNvbGFyJTIwcGFuZWxzfGVufDB8fDB8fHww&auto=format&fit=crop&w=800&q=60',
        articleUrl: 'https://example.com/news/breaking3',
        publishedDate: DateTime.now().subtract(const Duration(hours: 15)),
        source: 'GreenFuture News',
        isBookmarked: true,
      ),
    ]);
    isLoadingBreaking.value = false;
  }

  Future<void> fetchRecommendationNews() async {
    isLoadingRecommendations.value = true;
    await Future.delayed(const Duration(milliseconds: 1800)); // Simulasi API

    // Data dummy untuk Rekomendasi
    recommendationList.assignAll([
      NewsArticleModel(
        id: 'rec1',
        title: 'Penjelasan ilmiah dibalik kekenyangan massal',
        category: 'Bandung',
        imageUrl: 'https://images.unsplash.com/photo-1565958011703-44f9829ba187?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTB8fGZvb2QlMjBwbGF0ZXxlbnwwfHwwfHx8MA%3D%3D&auto=format&fit=crop&w=400&q=60',
        articleUrl: 'https://example.com/news/rec1',
        publishedDate: DateTime(2025, 2, 21), // Sesuai gambar
        source: 'Kompasdot.com',
        sourceIconUrl: 'https://seeklogo.com/images/K/kompas-logo-42E326930F-seeklogo.com.png' // Contoh URL ikon sumber
      ),
      NewsArticleModel(
        id: 'rec2',
        title: 'Tips Berkebun di Lahan Sempit untuk Pemula',
        category: 'Lifestyle',
        imageUrl: 'https://images.unsplash.com/photo-1461354464878-ad92f492a5a0?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8M3x8Z2FyZGVuaW5nfGVufDB8fDB8fHww&auto=format&fit=crop&w=400&q=60',
        articleUrl: 'https://example.com/news/rec2',
        publishedDate: DateTime.now().subtract(const Duration(days: 2)),
        source: 'RumahHijau.id',
        sourceIconUrl: 'https://via.placeholder.com/16/4CAF50/FFFFFF?text=R'
      ),
      NewsArticleModel(
        id: 'rec3',
        title: 'Panduan Memilih Laptop Terbaik untuk Produktivitas',
        category: 'Teknologi',
        imageUrl: 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8bGFwdG9wfGVufDB8fDB8fHww&auto=format&fit=crop&w=400&q=60',
        articleUrl: 'https://example.com/news/rec3',
        publishedDate: DateTime.now().subtract(const Duration(days: 4)),
        source: 'GadgetReview',
        // sourceIconUrl: null, // Contoh tanpa ikon sumber
      ),
    ]);
    isLoadingRecommendations.value = false;
  }

  void onBreakingNewsPageChanged(int index) {
    breakingNewsCarouselIndex.value = index;
  }

  void openArticle(NewsArticleModel article) async {
    Get.snackbar('Buka Artikel', article.title);
    // final Uri url = Uri.parse(article.articleUrl ?? 'https://example.com');
    // if (!await launchUrl(url)) {
    //   Get.snackbar('Error', 'Tidak bisa membuka link');
    // }
  }

  void onSeeMoreTap(String section) {
    Get.snackbar('Lihat Lebih Banyak', section);
    // Implementasi navigasi ke halaman daftar lengkap berita untuk section tersebut
  }

  void onNotificationTap() { // Metode ini bisa dipanggil dari AppBar
    Get.snackbar('Notifikasi', 'Tombol notifikasi ditekan!');
  }

  void toggleBookmark(NewsArticleModel article) {
    // Logika untuk mengubah status bookmark
    // Ini hanya contoh, Anda mungkin perlu menyimpan state ini secara persisten
    int index = breakingNewsList.indexWhere((a) => a.id == article.id);
    if (index != -1) {
      breakingNewsList[index] = NewsArticleModel(
        // Salin semua properti lain dan ubah isBookmarked
        id: breakingNewsList[index].id,
        title: breakingNewsList[index].title,
        snippet: breakingNewsList[index].snippet,
        imageUrl: breakingNewsList[index].imageUrl,
        articleUrl: breakingNewsList[index].articleUrl,
        publishedDate: breakingNewsList[index].publishedDate,
        source: breakingNewsList[index].source,
        sourceIconUrl: breakingNewsList[index].sourceIconUrl,
        category: breakingNewsList[index].category,
        isBookmarked: !breakingNewsList[index].isBookmarked,
      );
      breakingNewsList.refresh(); 
    }
  }
}

extension TimeAgoExtension on NewsController {
 String getTimeAgo(DateTime dateTime) {
    final now = DateTime.now();
    final difference = now.difference(dateTime);

    if (difference.inSeconds < 60) {
      return '${difference.inSeconds} detik lalu';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} menit lalu';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} jam lalu';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} hari lalu';
    } else {
      return DateFormat('dd MMM yyyy').format(dateTime);
    }
  }
}