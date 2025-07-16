import 'package:dio/dio.dart';
import '../../data/models/patient_detail_model.dart';
import '../../data/models/patient_model.dart';
import '../api_service.dart';

class PatientService {
  static Future<List<PatientModel>> fetchPatients() async {
    try {
      print('Fetching patients from API...');
      final response = await ApiService.dio.get('/pasien');

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        final responseData = response.data;

        if (responseData is Map<String, dynamic> &&
            responseData.containsKey('data')) {
          final List data = responseData['data'];
          print('Found ${data.length} patients in response');

          return data
              .map((json) {
                try {
                  return PatientModel.fromJson(json);
                } catch (e) {
                  print('Error parsing patient data: $e');
                  print('Patient data: $json');
                  return null;
                }
              })
              .whereType<PatientModel>()
              .toList();
        } else {
          print('Unexpected response structure: $responseData');
          throw Exception('Format response tidak sesuai');
        }
      } else {
        throw Exception('HTTP Error: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('DioException: ${e.message}');
      if (e.response != null) {
        print('Error response: ${e.response?.data}');
        print('Error status: ${e.response?.statusCode}');
      }

      if (e.response?.statusCode == 401) {
        throw Exception('Token expired atau tidak valid');
      } else if (e.response?.statusCode == 403) {
        throw Exception('Akses ditolak');
      } else if (e.response?.statusCode == 404) {
        throw Exception('Endpoint tidak ditemukan');
      } else if (e.response?.statusCode == 500) {
        throw Exception('Server error');
      } else {
        throw Exception('Gagal mengambil data: ${e.message}');
      }
    } catch (e) {
      print('General error: $e');
      throw Exception('Terjadi kesalahan: $e');
    }
  }

  String _formatImageUrl(String? localPath) {
    if (localPath == null) return '';

    // If it's already a full URL, return as is
    if (localPath.startsWith('http://') || localPath.startsWith('https://')) {
      return localPath;
    }

    // Construct a full URL based on your backend configuration
    return 'https://your-backend-domain.com/images/$localPath';
  }

  static Future<PatientDetailModel?> fetchPatientDetail(
      String patientId) async {
    try {
      final response = await ApiService.dio.get('/pasien/show/$patientId');

      if (response.statusCode == 200) {
        final responseData = response.data;
        final List dataList = responseData['data'];

        if (dataList.isNotEmpty) {
          return PatientDetailModel.fromJson(dataList.first);
        }
      }
      throw Exception('Tidak dapat menemukan data pasien');
    } on DioException catch (e) {
      print('Error fetching patient detail: ${e.message}');
      throw Exception('Gagal mengambil detail pasien: ${e.message}');
    }
  }
}
