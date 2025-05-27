import 'package:get/get.dart';

import '../controllers/detail_patient_controller.dart';

class DetailPatientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPatientController>(
      () => DetailPatientController(),
    );
  }
}
