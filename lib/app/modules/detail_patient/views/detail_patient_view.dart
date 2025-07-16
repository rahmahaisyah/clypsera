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
        actions: [
          IconButton(
            icon: Icon(Icons.refresh, color: Style.blackColor),
            onPressed: () => controller.refreshPatientData(),
          ),
        ],
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
                      InfoRowWidget(
                          label: 'Jenis Kelamin',
                          value: _getGenderString(patient.gender)),
                      InfoRowWidget(
                          label: 'Tanggal Lahir',
                          value: patient.formatDate(patient.dateOfBirth)),
                      InfoRowWidget(label: 'Usia', value: patient.formatAge()),
                      InfoRowWidget(
                          label: 'Alamat', value: patient.address ?? '-'),
                      InfoRowWidget(
                          label: 'No. Telepon',
                          value: patient.phoneNumber ?? '-'),
                    ],
                  )),
              Obx(() => InfoSectionWidget(
                    title: 'Informasi Penyakit',
                    isExpanded: controller.isDiseaseInfoExpanded.value,
                    onExpansionChanged: (value) {
                      controller.toggleDiseaseInfoExpansion(value);
                    },
                    children: [
                      InfoRowWidget(
                          label: 'Jenis Penyakit',
                          value: patient.diseaseType ?? '-'),
                      InfoRowWidget(
                          label: 'Penyelenggara',
                          value: patient.diseaseOrganizer ?? '-'),
                      InfoRowWidget(
                          label: 'Tanggal Upload',
                          value: patient.formatDate(patient.uploadDate)),
                    ],
                  )),
              Obx(() => InfoSectionWidget(
                    title: 'Informasi Operasi',
                    isExpanded: controller.isTreatmentInfoExpanded.value,
                    onExpansionChanged: (value) {
                      controller.toggleTreatmentInfoExpansion(value);
                    },
                    children: [
                      InfoRowWidget(
                          label: 'Lokasi Operasi',
                          value: patient.operationLocation ?? '-'),
                      InfoRowWidget(
                          label: 'Teknik Operasi',
                          value: patient.operationTechnique ?? '-'),
                      InfoRowWidget(
                          label: 'Tanggal Operasi',
                          value: patient.formatDate(patient.operationDate)),
                      InfoRowWidget(
                          label: 'Tindak Lanjut',
                          value: patient.followUp ?? '-'),
                    ],
                  )),
              Obx(() => InfoSectionWidget(
                    title: 'Informasi Gambar',
                    isExpanded: controller.isImagesExpanded.value,
                    onExpansionChanged: (value) {
                      controller.toggleImagesExpansion(value);
                    },
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (patient.beforeOperationImage != null) {
                            controller.showImageDialog('Gambar Sebelum Operasi',
                                patient.beforeOperationImage!);
                          } else {
                            Get.snackbar(
                              'Informasi',
                              'Tidak ada gambar sebelum operasi',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        },
                        child: InfoRowWidget(
                          label: 'Sebelum Operasi',
                          value: patient.beforeOperationImage != null
                              ? 'Lihat Gambar'
                              : 'Tidak Ada Gambar',
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (patient.afterOperationImage != null) {
                            controller.showImageDialog('Gambar Setelaj Operasi',
                                patient.afterOperationImage!);
                          } else {
                            Get.snackbar(
                              'Informasi',
                              'Tidak ada gambar setelah operasi',
                              snackPosition: SnackPosition.BOTTOM,
                            );
                          }
                        },
                        child: InfoRowWidget(
                          label: 'Setelah Operasi',
                          value: patient.afterOperationImage != null
                              ? 'Lihat Gambar'
                              : 'Tidak Ada Gambar',
                        ),
                      ),
                    ],
                  )),
              const SizedBox(height: 15),
              Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return CustomButton(
                text: "Request data",
                onTap: () {
                  Get.toNamed(
                    Routes.requestData,
                    arguments: patient,
                  );
                },
                textStyle: Style.headLineStyle6,
                color: Style.primaryColor,
              );
              }),
              const SizedBox(height: 24),
            ],
          ),
        );
      }),
    );
  }
}
