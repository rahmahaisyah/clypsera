class UserProfileModel {
  final String name;
  final String email;

  UserProfileModel({
    required this.name,
    required this.email,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      name: json['name'] ,
      email: json['email'],
    );
  }
}
