import 'package:clypsera/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/theme/app_style.dart';
import '../../../shared/widgets/custom_search_bar.dart';
import '../../home/widgets/patient_list_section.dart'; // Pastikan path ini benar
import '../controllers/list_patient_controller.dart';
import '../widgets/filter_category_chip.dart';

class ListPatientView extends GetView<ListPatientController> {
  const ListPatientView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.whiteColor,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Style.blackColor),
          onPressed: () {
            Get.offAllNamed(Routes.bottomnavigation);
          },
        ),
        title: Text(
          'Daftar Pasien',
          style: Style.headLineStyle12,
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomSearchBar(
                  controller: controller.searchController,
                  hintText: "Nama Seseorang",
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 45, // Tinggi untuk filter bar
                  child: Row(
                    children: [
                      // Ganti IconButton dengan FilterCategoryChip "Semua"
                      Obx(() => FilterCategoryChip(
                            label: "Semua",
                            isSelected: controller.selectedCleftTypeId.value == '', // Terpilih jika tidak ada ID filter lain
                            onTap: () {
                              controller.selectCleftTypeFilter(''); // ID kosong untuk "Semua"
                            },
                          )),
                      // Beri sedikit jarak antara chip "Semua" dan daftar kategori
                      // const SizedBox(width: 8.0), // Opsional, jika diperlukan

                      // Daftar Kategori Filter Horizontal
                      Expanded(
                        child: Obx(() {
                          // Filter keluar item "Semua" dari controller.displayedCleftTypesForFilter
                          // karena sudah kita tampilkan secara manual di atas.
                          final actualCleftTypes = controller.displayedCleftTypesForFilter
                              .where((type) => type.id != '') // Hanya tampilkan tipe selain "Semua"
                              .toList();

                          if (actualCleftTypes.isEmpty && controller.allCleftTypes.isNotEmpty) {
                             // Ini berarti hanya ada filter "Semua" dan tidak ada kategori lain
                             // Anda bisa memilih untuk tidak menampilkan ListView.builder atau menampilkan pesan
                             return const SizedBox.shrink(); // Atau widget lain jika perlu
                          }
                          if (controller.displayedCleftTypesForFilter.isEmpty && controller.allCleftTypes.isEmpty) {
                            return const Center(
                                child: Text('Memuat filter...'));
                          }
                          
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: actualCleftTypes.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final cleftType = actualCleftTypes[index];
                              // Obx di dalam itemBuilder tidak diperlukan jika Obx sudah membungkus ListView.builder
                              // dan FilterCategoryChip sudah di-observe di level atasnya.
                              // Namun, jika Anda ingin setiap chip bereaksi individual, bisa dipertahankan.
                              return FilterCategoryChip( // Tidak perlu Obx lagi di sini jika ListView sudah Obx
                                    label: cleftType.name,
                                    isSelected:
                                        controller.selectedCleftTypeId.value ==
                                            cleftType.id,
                                    onTap: () {
                                      controller
                                          .selectCleftTypeFilter(cleftType.id);
                                    },
                                  );
                            },
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (controller.filteredPatients.isEmpty &&
                    controller.searchQuery.value.isNotEmpty) {
                  return const Center(child: Text('Pasien tidak ditemukan.'));
                }
                if (controller.filteredPatients.isEmpty &&
                    controller.selectedCleftTypeId.value.isNotEmpty) {
                  return const Center(
                      child: Text('Tidak ada pasien dengan kriteria ini.'));
                }
                if (controller.filteredPatients.isEmpty &&
                    controller.searchQuery.value.isEmpty &&
                    controller.selectedCleftTypeId.value.isEmpty &&
                    !controller.isLoading.value ) {
                       return const Center(child: Text('Belum ada data pasien.'));
                    }

                return PatientListSection(
                  showHeader: false,
                  patientsToDisplay: controller.filteredPatients,
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
