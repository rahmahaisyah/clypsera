import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/api_url.dart';

class AuthService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse('$apiUrl/auth/login');
    final headers = {
      'Accept': 'application/json',
    };
    try {
      final response = await http.post(
        url,
        headers: headers,
        body: {
          'email': email,
          'password': password,
        },
      );
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        // Jika berhasil, kembalikan data JSON sebagai Map
        return json.decode(response.body);
      } else {
        // Jika gagal, coba decode error message jika itu JSON
        // Jika bukan, tampilkan pesan error umum
        try {
           final errorData = json.decode(response.body);
           throw Exception(errorData['message'] ?? 'Login Gagal');
        } catch (e) {
          // Ini akan menangkap error jika response body adalah HTML
          // dan json.decode di atas gagal.
          throw Exception('Gagal memproses respons dari server. Status code: ${response.statusCode}');
        }
      }
    } catch (e) {
      // Tangani error koneksi atau lainnya
      throw Exception('Terjadi kesalahan: ${e.toString()}');
    }
  }
}