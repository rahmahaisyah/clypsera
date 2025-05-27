import 'package:get/get.dart';

import '../../../data/models/yayasan_model.dart';

class RekomendasiYayasanController extends GetxController {
  final RxBool isLoading = true.obs;
  final RxList<YayasanModel> yayasanList = <YayasanModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchRekomendasiYayasan();
  }

  Future<void> fetchRekomendasiYayasan() async {
    try {
      isLoading.value = true;
      // Simulasi pengambilan data dari API 
      await Future.delayed(const Duration(seconds: 1));

      // Data dummy berdasarkan gambar Anda
      // Pastikan path gambar di 'imageUrl' sesuai dengan struktur aset Anda
      // atau ganti dengan URL jika gambar dari network.
      final List<YayasanModel> dummyData = [
        YayasanModel(
          id: '1',
          imageUrl: 'https://images.unsplash.com/photo-1739372074271-0a4cc5dcbfd2?q=80&w=1171&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          name: 'Yayasan 1',
          location: 'Bandung, jawa barat',
        ),
        YayasanModel(
          id: '2',
          imageUrl: 'https://images.unsplash.com/photo-1554743365-a80c1243316e?q=80&w=1170&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D',
          name: 'Yayasan 2',
          location: 'Bojongsoang, jawa barat',
        ),
         YayasanModel(
          id: '3',
          imageUrl: 'https://plus.unsplash.com/premium_photo-1733306615664-19552f01fe63?q=80&w=1136&auto=format&fit=crop&ixlib=rb-4.1.0&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D', 
          name: 'Yayasan Peduli Anak',
          location: 'Surabaya, Jawa Timur',
        ),
      ];
      yayasanList.assignAll(dummyData);
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal memuat rekomendasi yayasan: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
      print("Error fetching recommendations: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void onSeeMoreTapped() {
    // Implementasi aksi "See more"
    // Contoh: Get.to(() => AllYayasanPage());
    Get.snackbar('Info', 'Tombol "See more" ditekan!', snackPosition: SnackPosition.TOP);
  }

  void onYayasanCardTapped(YayasanModel yayasan) {
    // Implementasi aksi saat kartu yayasan ditekan
    // Contoh: Get.to(() => YayasanDetailPage(yayasan: yayasan));
    Get.snackbar('Info', 'Yayasan "${yayasan.name}" ditekan!', snackPosition: SnackPosition.TOP);
  }
}