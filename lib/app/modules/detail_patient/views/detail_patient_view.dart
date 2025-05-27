import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/theme/app_style.dart';
import '../controllers/detail_patient_controller.dart';

class DetailPatientView extends GetView<DetailPatientController> {
  const DetailPatientView({super.key});
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
          'Detail Pasien',
          style: Style.headLineStyle12,
        ),
        centerTitle: false,
      ),
      body: const Center(
        child: Text(
          'DetailPatientView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
