import 'package:dio/dio.dart';
import '../../data/models/patient_request_model.dart';
import '../api_service.dart';
import '../auth_service.dart';

class RequestDataService {
  static Future<void> submitRequest(PatientRequestModel request) async {
    try {
      final authService = AuthService();
      final token = await authService.getToken();

      final response = await ApiService.dio.post(
        '/permohonan/store',
        data: request.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Accept': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("API response: ${response.data}");
        print("Data to submit: ${request.toJson()}");

        return;
      } else {
        throw Exception(
            response.data['message'] ?? 'Gagal menyimpan permintaan');
      }
    } on DioException catch (e) {
      if (e.response != null) {
        throw Exception(
            e.response?.data['message'] ?? 'Gagal mengirim permintaan');
      } else {
        throw Exception('Kesalahan jaringan: ${e.message}');
      }
    } catch (e) {
      throw Exception('Gagal mengirim permintaan: $e');
    }
  }
}
