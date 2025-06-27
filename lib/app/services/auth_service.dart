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
        final prefs = await SharedPreferences.getInstance();

        final accessToken = data['access_token'];
        if (accessToken != null && accessToken is String) {
          await prefs.setString('access_token', accessToken);
        } else {
          throw Exception('Akses token tidak ditemukan pada response');
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

  Future<String?> forgetPassword(String email) async {
    try {
      final response = await ApiService.dio.post(
        '/auth/forgot-password',
        data: {'email': email},
      );
      if (response.statusCode == 200) {
        return response.data['message'] ?? 'Berhasil request reset password';
      } else {
        throw Exception(
            response.data['message'] ?? 'Gagal mengirim reset password');
      }
    } on DioException catch (e) {
      throw Exception(
          e.response?.data['message'] ?? 'Gagal mengirim reset password');
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');
      await ApiService.dio.post(
        '/auth/logout',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      await prefs.clear();
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Logout gagal');
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}