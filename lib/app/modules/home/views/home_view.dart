import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/widgets/custom_appbar.dart';
import '../widgets/cleft_types_section.dart';
import '../../../shared/widgets/custom_search_bar.dart';
import '../widgets/patient_list_section.dart';
import '../widgets/rekomendasi_yayasan_section.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSearchBar(
                controller: controller.searchController,
              ),
              const SizedBox(height: 24),
              const CleftTypesSection(),
              const SizedBox(height: 15),
              const RekomendasiYayasanSection(),
              const SizedBox(height: 15),
              Obx(() => PatientListSection(
                    patientsToDisplay: controller.patients.toList(),
                    onSeeMoreTap: controller.onSeeMorePatientsTap,
                  )),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
