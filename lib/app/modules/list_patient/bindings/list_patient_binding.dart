import 'package:get/get.dart';

import '../controllers/list_patient_controller.dart';

class ListPatientBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ListPatientController>(
      () => ListPatientController(),
    );
  }
}
