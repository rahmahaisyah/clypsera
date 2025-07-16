import 'package:flutter/material.dart';

import '../../../constants/uidata.dart';
import '../../../data/enums/gender.dart';
import '../../../shared/theme/app_style.dart';

class PatientAvatarWidget extends StatelessWidget {
  final String? avatarUrl;
  final Gender gender;

  const PatientAvatarWidget({
    super.key,
    required this.avatarUrl,
    required this.gender,
  });

  Widget _buildGenderIcon(Gender gender, BuildContext context) {
    String iconAsset;
    Color bgColor;

    switch (gender) {
      case Gender.male:
        iconAsset = genderMaleIcon; 
        bgColor = Style.primaryColor; 
        break;
      case Gender.female:
        iconAsset = genderFemaleIcon; 
        bgColor = Style.blueColor2; 
        break;
      case Gender.unknown: 
        return const SizedBox.shrink(); 
    }

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        border: Border.all(color: Style.whiteColor),
      ),
      child: Image.network(
        iconAsset,
        width: 14,
        height: 14,
        color: Style.whiteColor,
        errorBuilder: (context, error, stackTrace) =>
            Icon(Icons.error, size: 14, color: Style.whiteColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double avatarDiameter = 100.0;
    const double genderIconDiameter = 30.0;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: avatarDiameter + genderIconDiameter * 0.2,
            height: avatarDiameter + genderIconDiameter * 0.2,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: avatarDiameter,
                  height: avatarDiameter,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Style.primaryColor.withOpacity(0.1),
                    image: (avatarUrl != null && avatarUrl!.isNotEmpty)
                        ? DecorationImage(
                            image: NetworkImage(
                                avatarUrl!),
                            fit: BoxFit.cover,
                            onError: (exception, stackTrace) {
                              print('Error loading avatar: $exception');
                            },
                          )
                        : null,
                  ),
                  child: (avatarUrl == null || avatarUrl!.isEmpty)
                      ? ClipOval(
                          child: Image.network(
                            profileIcon,
                            fit: BoxFit.cover,
                            color: Style.primaryColor.withOpacity(0.7),
                            errorBuilder: (context, error, stackTrace) => Icon(
                                Icons.person,
                                size: avatarDiameter * 0.6,
                                color: Style.primaryColor),
                          ),
                        )
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: SizedBox(
                    width: genderIconDiameter,
                    height: genderIconDiameter,
                    child: _buildGenderIcon(gender, context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
