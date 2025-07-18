import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/widgets/custom_textform.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/theme/app_style.dart';
import '../controllers/request_data_controller.dart';
import '../widgets/category_card.dart';

class RequestDataView extends GetView<RequestDataController> {
  const RequestDataView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.whiteColor,
      appBar: AppBar(
        backgroundColor: Style.whiteColor,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Style.blackColor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Formulir Permintaan Data',
          style: Style.headLineStyle12,
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            CustomTextform(
              title: 'Nama pemohon',
              textHint: 'Nama lengkap',
              controller: controller.nameController,
            ),
            const SizedBox(height: 16),
            CustomTextform(
              title: 'Nomor telpon',
              textHint: 'Masukan nomor telpon',
              controller: controller.phoneController,
            ),
            const SizedBox(height: 16),
            CustomTextform(
              title: 'Email',
              textHint: 'Namakamu@gmail.com',
              controller: controller.emailController,
            ),
            const SizedBox(height: 16),
            CustomTextform(
              title: 'NIK',
              textHint: 'NIK kamu',
              controller: controller.nikController,
            ),
            const SizedBox(height: 24),
            Text('Data pasien', style: Style.headLineStyle5),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Obx(() {
                final patient = controller.selectedPatient.value;

                if (patient == null) {
                  return Row(
                    children: [
                      const CircleAvatar(child: Icon(Icons.person)),
                      const SizedBox(width: 12),
                      Text(
                        'Pilih Pasien',
                        style: Style.headLineStyle9,
                      ),
                    ],
                  );
                }

                return GestureDetector(
                  onTap: () => Get.toNamed(Routes.detailPatient,
                      arguments: patient.id.toString()),
                  child: Row(
                    children: [
                      const CircleAvatar(child: Icon(Icons.person)),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(patient.name, style: Style.headLineStyle9),
                            const SizedBox(height: 4),
                            Text(patient.diseaseType ?? '-',
                                style: Style.headLineStyle15),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ),
            const SizedBox(height: 24),
            Text('Kategori pengajuan', style: Style.headLineStyle5),
            const SizedBox(height: 12),
            Obx(() => SizedBox(
                  height: null,
                  child: Row(
                    children: List.generate(controller.categories.length, (i) {
                      final cat = controller.categories[i];
                      return Expanded(
                        child: CategoryCard(
                          icon: cat['icon'] as String,
                          title: cat['title'] as String,
                          desc: cat['desc'] as String,
                          selected: controller.selectedCategory.value == i,
                          onTap: () => controller.selectedCategory.value = i,
                        ),
                      );
                    }),
                  ),
                )),
            const SizedBox(height: 16),
            CustomTextform(
              title: 'Tujuan penggunaan data',
              textHint: 'Ketik disini',
              controller: controller.purposeController,
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: 'Ajukan data',
              onTap: () {
                controller.submitData();
              },
              color: Style.primaryColor,
              textStyle: Style.headLineStyle6.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
