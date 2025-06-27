import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
              child: Row(
                children: [
                  CircleAvatar(child: Icon(Icons.person)),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text('Nama cowo',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        Text('Palate anatomy',
                            style: TextStyle(fontSize: 12, color: Colors.grey)),
                      ],
                    ),
                  ),
                  Icon(Icons.keyboard_arrow_down),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Text('Kategori pengajuan', style: Style.headLineStyle5),
            const SizedBox(height: 12),
            SizedBox(
              height: 120,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: controller.categories.length,
                itemBuilder: (context, i) {
                  final cat = controller.categories[i];
                  return CategoryCard(
                    icon: cat['icon'] as IconData,
                    title: cat['title'] as String,
                    desc: cat['desc'] as String,
                    selected: controller.selectedCategory.value == i,
                    onTap: () => controller.selectedCategory.value = i,
                  );
                },
              ),
            ),
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
                // TODO: Implement submit logic
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
