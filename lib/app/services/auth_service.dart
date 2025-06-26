import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'api_service.dart';

class AuthService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    try {
      final response = await ApiService.dio.post(
        '/auth/login',
        data: {
          'email': email,
          'password': password,
        },
      );
      if (response.statusCode == 200) {
        final data = response.data;
        // Simpan token ke shared_preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('access_token', data['access_token']);
        if (data['refresh_token'] != null) {
          await prefs.setString('refresh_token', data['refresh_token']);
        }
        return data;
      } else {
        throw Exception(response.data['message'] ?? 'Login gagal');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Login gagal');
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  Future<void> forgetPassword(String email) async {
    try {
      final response = await ApiService.dio.post(
        '/auth/forgot-password',
        data: {'email': email},
      );
      if (response.statusCode == 200) {
        return;
      } else {
        throw Exception(
            response.data['message'] ?? 'Gagal mengirim reset password');
      }
    } on DioException catch (e) {
      print(e.response?.data);
      throw Exception(
          e.response?.data['message'] ?? 'Gagal mengirim reset password');
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}
