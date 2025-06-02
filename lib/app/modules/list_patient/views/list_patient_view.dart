import 'package:clypsera/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/theme/app_style.dart';
import '../../../shared/widgets/custom_search_bar.dart';
import '../../home/widgets/patient_list_section.dart';
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
          'Deftar Pasien',
          style: Style.headLineStyle12,
        ),
        centerTitle: false,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CustomSearchBar(
                  controller: controller.searchController,
                  hintText: "Nama Seseorang",
                ),
                const SizedBox(height: 16),

                // Filter Bar Section
                SizedBox(
                  height: 45, // Tinggi untuk filter bar
                  child: Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(right: 8.0),
                        decoration: BoxDecoration(
                          color: Style.whiteColor,
                          borderRadius: BorderRadius.circular(12.0),
                          border: Border.all(
                              color: Style.greyColor2.withOpacity(0.5)),
                        ),
                        child: IconButton(
                          icon: Icon(Icons.filter_list_rounded,
                              color: Style.primaryColor, size: 20),
                          onPressed: controller.openAdvancedFilter,
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                        ),
                      ),

                      // Daftar Kategori Filter Horizontal
                      Expanded(
                        child: Obx(() {
                          if (controller.displayedCleftTypesForFilter.isEmpty) {
                            return const Center(
                                child: Text('Memuat filter...'));
                          }
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount:
                                controller.displayedCleftTypesForFilter.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final cleftType = controller
                                  .displayedCleftTypesForFilter[index];
                              return Obx(() => FilterCategoryChip(
                                    label: cleftType.name,
                                    isSelected:
                                        controller.selectedCleftTypeId.value ==
                                            cleftType.id,
                                    onTap: () {
                                      controller
                                          .selectCleftTypeFilter(cleftType.id);
                                    },
                                  ));
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

          // Daftar Pasien
          Padding(
            padding: const EdgeInsets.all(16),
            child: Expanded(
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
