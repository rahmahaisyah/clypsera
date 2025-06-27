import 'package:get/get.dart';

import '../controllers/request_data_controller.dart';

class RequestDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RequestDataController>(
      () => RequestDataController(),
    );
  }
}
