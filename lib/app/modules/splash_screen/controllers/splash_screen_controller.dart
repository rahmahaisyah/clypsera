import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../routes/app_pages.dart';

class SplashScreenController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    print('TOKEN READ: $token');
    if (token != null && token.isNotEmpty) {
      Get.offAllNamed(Routes.bottomnavigation);
    } else {
      Get.offAllNamed(Routes.login);
    }
  }
}