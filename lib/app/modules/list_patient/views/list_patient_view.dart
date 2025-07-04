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
                  height: 45,
                  child: Row(
                    children: [
                      Obx(() => FilterCategoryChip(
                            label: "Semua",
                            isSelected:
                                controller.selectedCleftTypeId.value == '',
                            onTap: () {
                              controller.selectCleftTypeFilter('');
                            },
                          )),
                      Expanded(
                        child: Obx(() {
                          final actualCleftTypes = controller
                              .displayedCleftTypesForFilter
                              .where((type) => type.id != '')
                              .toList();

                          if (actualCleftTypes.isEmpty &&
                              controller.allCleftTypes.isNotEmpty) {
                            return const SizedBox.shrink();
                          }
                          if (controller.displayedCleftTypesForFilter.isEmpty &&
                              controller.allCleftTypes.isEmpty) {
                            return const Center(
                                child: Text('Memuat filter...'));
                          }
                          return ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: actualCleftTypes.length,
                            physics: const BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              final cleftType = actualCleftTypes[index];
                              return FilterCategoryChip(
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
              child: PatientListSection(
                showHeader: false,
                patientsToDisplay: controller.filteredPatients,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
