import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../data/enums/gender.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/theme/app_style.dart';
import '../../../shared/widgets/custom_button.dart';
import '../widgets/info_row_widget.dart';
import '../widgets/info_section_widget.dart';
import '../widgets/patient_avatar_widget.dart';
import '../controllers/detail_patient_controller.dart';

class DetailPatientView extends GetView<DetailPatientController> {
  const DetailPatientView({super.key});

  String _getGenderString(Gender gender) {
    switch (gender) {
      case Gender.male:
        return 'Pria';
      case Gender.female:
        return 'Wanita';
      case Gender.unknown:
        return 'Tidak diketahui';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pasien', style: Style.headLineStyle12),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Style.blackColor),
          onPressed: () => Get.offAllNamed(Routes.bottomnavigation),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final patient = controller.patientData.value;
        if (patient == null) {
          return const Center(child: Text('Data pasien tidak ditemukan'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              PatientAvatarWidget(
                gender: patient.gender,
                avatarUrl: null,
              ),
              Obx(() => InfoSectionWidget(
                title: 'Informasi Pasien',
                isExpanded: controller.isPatientInfoExpanded.value,
                onExpansionChanged: (value) {
                  controller.togglePatientInfoExpansion(value);
                },
                children: [
                  InfoRowWidget(label: 'Nama', value: patient.name),
                  InfoRowWidget(label: 'Jenis Kelamin', value: _getGenderString(patient.gender)),
                  InfoRowWidget(label: 'Tanggal Lahir', value: patient.formatDate(patient.dateOfBirth)),
                  InfoRowWidget(label: 'Usia', value: patient.formatAge()),
                  InfoRowWidget(label: 'Alamat', value: patient.address ?? '-'),
                  InfoRowWidget(label: 'No. Telepon', value: patient.phoneNumber ?? '-'),
                ],
              )),
              Obx(() => InfoSectionWidget(
                title: 'Informasi Penyakit',
                isExpanded: controller.isDiseaseInfoExpanded.value,
                onExpansionChanged: (value) {
                  controller.toggleDiseaseInfoExpansion(value);
                },
                children: [
                  InfoRowWidget(label: 'Jenis Penyakit', value: patient.diseaseType ?? '-'),
                  InfoRowWidget(label: 'Penyelenggara', value: patient.diseaseOrganizer ?? '-'),
                  InfoRowWidget(label: 'Tanggal Upload', value: patient.formatDate(patient.uploadDate)),
                ],
              )),
              Obx(() => InfoSectionWidget(
                title: 'Informasi Operasi',
                isExpanded: controller.isTreatmentInfoExpanded.value,
                onExpansionChanged: (value) {
                  controller.toggleTreatmentInfoExpansion(value);
                },
                children: [
                  InfoRowWidget(label: 'Lokasi Operasi', value: patient.operationLocation ?? '-'),
                  InfoRowWidget(label: 'Teknik Operasi', value: patient.operationTechnique ?? '-'),
                  InfoRowWidget(label: 'Tanggal Operasi', value: patient.formatDate(patient.operationDate)),
                  InfoRowWidget(label: 'Tindak Lanjut', value: patient.followUp ?? '-'),
                ],
              )),
              Obx(() => InfoSectionWidget(
                title: 'Informasi Gambar',
                isExpanded: controller.isImagesExpanded.value,
                onExpansionChanged: (value) {
                  controller.toggleImagesExpansion(value);
                },
                children: [
                  if (patient.beforeOperationImage != null) 
                    Column(
                      children: [
                        InfoRowWidget(label: 'Sebelum Operasi', value: ''),
                        Image.network(
                          patient.beforeOperationImage!,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(child: CircularProgressIndicator());
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const Text('Gagal memuat gambar');
                          },
                        ),
                      ],
                    ) else
                    const InfoRowWidget(label: 'Sebelum Operasi', value: 'Gambar tidak tersedia'),
                  if (patient.afterOperationImage != null) 
                    Column(
                      children: [
                        InfoRowWidget(label: 'Setelah Operasi', value: ''),
                        Image.network(
                          patient.afterOperationImage!,
                          fit: BoxFit.contain,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(child: CircularProgressIndicator());
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return const Text('Gagal memuat gambar');
                          },
                        ),
                      ],
                    ) else
                    const InfoRowWidget(label: 'Setelah Operasi', value: 'Gambar tidak tersedia'),
                ],
              )),
              const SizedBox(height: 15),
              CustomButton(
                text: "Request data",
                onTap: () {
                  Get.toNamed(
                    Routes.requestData,
                    arguments: patient,
                  );
                },
                textStyle: Style.headLineStyle6,
                color: Style.primaryColor,
              ),
              const SizedBox(height: 24),
            ],
          ),
        );
      }),
    );
  }
}