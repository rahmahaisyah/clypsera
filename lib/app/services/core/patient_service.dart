import '../../data/models/patient_model.dart';
import '../api_service.dart';

class PatientService {
  static Future<List<PatientModel>> fetchPatients() async {
    final response = await ApiService.dio.get('/pasien');
    final List data = response.data['data'];
    return data.map((json) => PatientModel.fromJson(json)).toList();
  }
}
