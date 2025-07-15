import 'package:dio/dio.dart';
import '../../data/models/patient_model.dart';
import '../../data/models/user_profile_model.dart';
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
  static Future<UserProfileModel> fetchPatientDetail(String patientId) async {
    try {
      print('Fetching patient detail for ID: $patientId');
      
      if (patientId.isEmpty) {
        throw Exception('Patient ID tidak valid');
      }

      final response = await ApiService.dio.get('/pasien/$patientId');

      print('Response status: ${response.statusCode}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        final responseData = response.data;

        // Handle different response structures
        if (responseData is Map<String, dynamic>) {
          UserProfileModel patientDetail;
          
          if (responseData.containsKey('data')) {
            // Response wrapped in 'data' key
            patientDetail = UserProfileModel.fromJson(responseData['data']);
          } else if (responseData.containsKey('patient')) {
            // Response wrapped in 'patient' key
            patientDetail = UserProfileModel.fromJson(responseData['patient']);
          } else {
            // Direct response
            patientDetail = UserProfileModel.fromJson(responseData);
          }
          
          print('Successfully parsed patient detail');
          return patientDetail;
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
        throw Exception('Data pasien tidak ditemukan');
      } else if (e.response?.statusCode == 500) {
        throw Exception('Server error');
      } else {
        throw Exception('Gagal mengambil detail pasien: ${e.message}');
      }
    } catch (e) {
      print('General error: $e');
      throw Exception('Terjadi kesalahan: $e');
    }
  }
}
