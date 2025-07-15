import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../routes/app_pages.dart';

class SplashScreenController extends GetxController {
  SplashScreenController() {
    print('SplashScreenController: Constructor dipanggil');
  }
  @override
  void onInit() {
    super.onInit();
    print('SplashScreenController onInit');
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    print('SplashScreenController _checkLoginStatus');
    await Future.delayed(const Duration(seconds: 3));
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('access_token');
    print('TOKEN: $token');
    if (token != null && token.isNotEmpty) {
      print('Go to home');
      Get.offAllNamed(Routes.bottomnavigation);
    } else {
      print('Go to login');
      Get.offAllNamed(Routes.login);
    }
  }
}
