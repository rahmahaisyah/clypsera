import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 3));
    // final prefs = await SharedPreferences.getInstance();
    // final token = prefs.getString('access_token');
    // print('TOKEN READ: $token');
    // if (token != null && token.isNotEmpty) {
    //   Get.offAllNamed(Routes.bottomnavigation);
    // } else {
    //   Get.offAllNamed(Routes.bottomnavigation);
    // }
    Get.offAllNamed(Routes.bottomnavigation);
  }
}
