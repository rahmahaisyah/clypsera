enum Gender { male, female, unknown }

class PatientModel {
  final String id;
  final String name;
  final Gender gender;
  final String cleftDescription;
  final String date;

  PatientModel({
    required this.id,
    required this.name,
    required this.gender,
    required this.cleftDescription,
    required this.date,
  });
}
