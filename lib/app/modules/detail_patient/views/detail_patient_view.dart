  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:intl/intl.dart';
  import '../../../data/models/user_profile_model.dart';
  import '../../../routes/app_pages.dart';
  import '../../../shared/theme/app_style.dart';
  import '../widgets/info_row_widget.dart';
  import '../widgets/info_section_widget.dart';
  import '../widgets/patient_avatar_widget.dart';
  import '../controllers/detail_patient_controller.dart';

  class DetailPatientView extends GetView<DetailPatientController> {
    const DetailPatientView({super.key});

    String _formatDate(DateTime? date) {
      if (date == null) return 'N/A';
      return DateFormat.yMMMMd().format(date);
    }

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
        backgroundColor: Style.whiteColor,
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
            'Detail Pasien',
            style: Style.headLineStyle12,
          ),
          centerTitle: false,
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }
          final patient = controller.patientData.value;
          if (patient == null) {
            return const Center(child: Text('Data pasien tidak ditemukan.'));
          }
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  color: Style.whiteColor,
                  alignment: Alignment.center,
                  child: PatientAvatarWidget(
                    avatarUrl: patient.avatarUrl,
                    gender: patient.gender,
                  ),
                ),
                const SizedBox(height: 8),
                Obx(() => InfoSectionWidget(
                      title: 'Informasi pasien',
                      isExpanded: controller.isPatientInfoExpanded.value,
                      onExpansionChanged: controller.togglePatientInfoExpansion,
                      children: [
                        InfoRowWidget(label: 'Nama', value: patient.name),
                        InfoRowWidget(
                            label: 'Gender',
                            value: _getGenderString(patient.gender)),
                        InfoRowWidget(
                            label: 'Tanggal lahir',
                            value: _formatDate(patient.dateOfBirth)),
                        InfoRowWidget(
                            label: 'Alamat', value: patient.address ?? 'N/A'),
                        if (patient.email.isNotEmpty)
                          InfoRowWidget(label: 'Email', value: patient.email),
                        if (patient.phoneNumber != null &&
                            patient.phoneNumber!.isNotEmpty)
                          InfoRowWidget(
                              label: 'Telepon', value: patient.phoneNumber!),
                        if (patient.nik != null && patient.nik!.isNotEmpty)
                          InfoRowWidget(label: 'NIK', value: patient.nik!),
                        if (patient.job != null && patient.job!.isNotEmpty)
                          InfoRowWidget(label: 'Pekerjaan', value: patient.job!),
                      ],
                    )),
                Divider(color: Colors.grey[200], height: 1),
                Obx(() => InfoSectionWidget(
                      title: 'Informasi penyakit',
                      isExpanded: controller.isDiseaseInfoExpanded.value,
                      onExpansionChanged: controller.toggleDiseaseInfoExpansion,
                      children: [
                        InfoRowWidget(
                            label: 'Jenis', value: patient.type ?? 'N/A'),
                        InfoRowWidget(
                            label: 'Penyelenggara',
                            value: patient.organizer ?? 'N/A'),
                        InfoRowWidget(
                            label: 'Tanggal upload',
                            value: patient.uploadDate ?? 'N/A'),
                      ],
                    )),
                Divider(color: Colors.grey[200], height: 1),
                Obx(() => InfoSectionWidget(
                      title: 'Informasi pengobatan',
                      isExpanded: controller.isTreatmentInfoExpanded.value,
                      onExpansionChanged: controller.toggleTreatmentInfoExpansion,
                      children: [
                        InfoRowWidget(
                            label: 'Lokasi operasi',
                            value: patient.operationLocation ?? 'N/A'),
                        InfoRowWidget(
                            label: 'Teknik operasi',
                            value: patient.operationTechnique ?? 'N/A'),
                        InfoRowWidget(
                            label: 'Tanggal Operasi',
                            value: patient.operationDate ?? 'N/A'),
                      ],
                    )),
                Divider(color: Colors.grey[200], height: 1),
                InfoSectionWidget(
                  title: 'Informasi lainnya',
                  isExpanded: false,
                  onExpansionChanged: controller.onOtherInfoTapped,
                  children: const [],
                ),
                Divider(color: Colors.grey[200], height: 1),
                InfoSectionWidget(
                  title: 'Gambar',
                  isExpanded: false,
                  onExpansionChanged: controller.onImagesTapped,
                  children: const [],
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Style.primaryColor,
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                  onPressed: () {
                    final patient = controller.patientData.value;
                    if (patient == null) {
                      Get.snackbar('Error', 'Data pasien belum tersedia');
                      return;
                    }
                    Get.toNamed(
                      Routes.requestData,
                      arguments: patient,
                    );
                  },
                  child: Text(
                    'Request data',
                    style: TextStyle(
                        fontSize: 16,
                        color: Style.whiteColor,
                        fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        }),
      );
    }
  }
