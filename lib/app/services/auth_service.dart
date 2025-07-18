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
          await prefs.setInt('user_id', data['user']['id']);
          await prefs.setString(
              'user_scope', data['user']['scope'] ?? 'sendiri');
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

  Future<Map<String, dynamic>?> getLoginData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('access_token');

      if (token == null) return null;

      final response = await ApiService.dio.get(
        '/auth/login',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        return {
          'name': response.data['user']['name'],
          'email': response.data['user']['email'],
        };
      }
    } catch (e) {
      print('Error getting login data: $e');
    }
    return null;
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

      if (token == null) {
        await prefs.clear();
        return;
      }

      final response = await ApiService.dio.post(
        '/auth/logout',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        await prefs.remove('access_token');
        await prefs.remove('user_id');
        await prefs.remove('user_scope');
      } else {
        throw Exception(response.data['message'] ?? 'Logout gagal');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();
      } else {
        throw Exception(e.response?.data['message'] ?? 'Logout gagal');
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  Future<int?> getCurrentUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('user_id');

    if (userId == null) {
      print('User ID tidak ditemukan');
      return null;
    }

    return userId;
  }

  Future<String?> getCurrentUserScope() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_scope') ?? 'sendiri';
  }

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }
}
