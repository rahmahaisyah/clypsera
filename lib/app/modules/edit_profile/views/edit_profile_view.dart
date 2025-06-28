import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/widgets/custom_textform.dart';
import '../../../shared/widgets/custom_button.dart';
import '../../../shared/theme/app_style.dart';
import '../controllers/edit_profile_controller.dart';

class EditProfileView extends GetView<EditProfileController> {
  const EditProfileView({super.key});

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
          'Ubah profile',
          style: Style.headLineStyle12,
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Avatar dengan edit icon
            Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CircleAvatar(
                    radius: 38,
                    backgroundColor: Style.primaryColor,
                    backgroundImage: controller.avatarUrl.value.isNotEmpty
                        ? NetworkImage(controller.avatarUrl.value)
                        : null,
                    child: controller.avatarUrl.value.isEmpty
                        ? Icon(Icons.person, color: Colors.white, size: 38)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: controller.onEditAvatarTap,
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: Style.whiteColor,
                          shape: BoxShape.circle,
                          border: Border.all(color: Style.primaryColor, width: 1.5),
                        ),
                        child: Icon(Icons.edit, size: 18, color: Style.primaryColor),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            CustomTextform(
              title: 'Username',
              textHint: 'Nama lengkap',
              controller: controller.nameController,
            ),
            const SizedBox(height: 16),
            CustomTextform(
              title: 'Alamat email',
              textHint: 'Email kamu@gmail.com',
              controller: controller.emailController,
            ),
            const SizedBox(height: 16),
            CustomTextform(
              title: 'Tanggal lahir',
              textHint: '00/00/0000',
              controller: controller.dobController,
              suffixIcon: IconButton(
                icon: Icon(Icons.calendar_today, size: 20, color: Style.primaryColor),
                onPressed: controller.onPickDate,
              ),
            ),
            const SizedBox(height: 24),
            Text('Additional Info', style: Style.headLineStyle5.copyWith(color: Style.primaryColor)),
            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              value: controller.selectedJob.value,
              items: controller.jobList
                  .map((job) => DropdownMenuItem(value: job, child: Text(job)))
                  .toList(),
              onChanged: controller.onJobChanged,
              decoration: InputDecoration(
                labelText: 'Pekerjaan',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 16),
            CustomTextform(
              title: 'Nomor telpon',
              textHint: '+62 Nomor telepon anda',
              controller: controller.phoneController,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: 16),
            CustomTextform(
              title: 'NIK',
              textHint: 'Nomor induk keluarga',
              controller: controller.nikController,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),

            // Detail alamat
            CustomTextform(
              title: 'Detail alamat',
              textHint: 'Masukan alamat',
              controller: controller.addressController,
            ),
            const SizedBox(height: 16),

            // Pin lokasi (dummy map)
            Container(
              height: 120,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: ElevatedButton(
                  onPressed: controller.onPinLocationTap,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Style.primaryColor,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  ),
                  child: const Text('Pin lokasi'),
                ),
              ),
            ),
            const SizedBox(height: 32),
            CustomButton(
              text: 'Simpan',
              onTap: controller.onSaveProfile,
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