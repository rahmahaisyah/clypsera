import 'package:clypsera/app/constants/uidata.dart';
import 'package:clypsera/app/shared/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/widgets/cleft_types_section.dart';
import '../../../shared/widgets/custom_search_bar.dart';
import '../../../shared/widgets/patient_list_section.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Style.whiteColor,
        elevation: 0.5, // Sedikit shadow untuk appbar
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Clypsera',
              style: Style.headLineStyle2, // Pastikan warna teks sesuai
            ),
            InkWell(
              onTap: controller.onNotificationTap,
              customBorder: const CircleBorder(),
              child: Padding(
                padding: const EdgeInsets.all(8.0), 
                child: Image.network(
                  notifIcon, 
                  width: 20, 
                  height: 20,
                  errorBuilder: (context, error, stackTrace) => const Icon(Icons.notifications_none, size: 20),
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding( // Mengganti Container dengan Padding untuk konsistensi
          padding: const EdgeInsets.all(16.0), // Padding keseluruhan
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomSearchBar(
                controller: controller.searchController,
                // onChanged: (value) => controller.onSearchChanged(value), // Jika ada fungsi search
              ),
              const SizedBox(height: 24),
              const CleftTypesSection(),
              const SizedBox(height: 24),
              const PatientListSection(),
              const SizedBox(height: 24), // Spasi di akhir scroll
            ],
          ),
        ),
      ),
    );
  }
}
