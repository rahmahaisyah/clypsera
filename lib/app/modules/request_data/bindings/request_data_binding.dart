import 'package:get/get.dart';
import '../../../services/auth_service.dart';
import '../controllers/request_data_controller.dart';

class RequestDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AuthService>(() => AuthService());
    Get.lazyPut<RequestDataController>(
      () => RequestDataController(),
    );
  }
}
