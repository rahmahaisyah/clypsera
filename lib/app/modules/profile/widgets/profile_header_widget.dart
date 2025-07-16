import 'package:clypsera/app/data/models/user_profile_model.dart';
import 'package:clypsera/app/shared/theme/app_style.dart';
import 'package:flutter/material.dart';
import '../../../constants/uidata.dart';
import '../../../data/enums/gender.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final UserProfileModel user;
  final VoidCallback? onEditProfileTap;

  const ProfileHeaderWidget({
    super.key,
    required this.user,
    this.onEditProfileTap,
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
      default:
        return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
        border: Border.all(color: Style.whiteColor),
      ),
      child: Image.network(iconAsset, width: 14, height: 14),
    );
  }

  @override
  Widget build(BuildContext context) {
    const double avatarDiameter = 100.0;
    const double genderIconDiameter = 28.0;
    final TextStyle nameStyle = Style.headLineStyle2;
    final TextStyle emailStyle = Style.headLineStyle14;

    final ButtonStyle editButtonStyle = ElevatedButton.styleFrom(
      backgroundColor: Style.blueColor2,
      foregroundColor: Style.whiteColor,
      elevation: 0,
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      textStyle: Style.headLineStyle14,
    );

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
                // Avatar Utama
                Container(
                  width: avatarDiameter,
                  height: avatarDiameter,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Style.primaryColor,
                    image: (user.avatarUrl?.isNotEmpty ?? false)
                        ? DecorationImage(
                            image: NetworkImage(user.avatarUrl!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: (user.avatarUrl == null || user.avatarUrl!.isEmpty)
                      ? Image.network(
                          profileIcon,
                          color: Style.whiteColor,
                        )
                      : null,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: SizedBox(
                    width: genderIconDiameter,
                    height: genderIconDiameter,
                    child: _buildGenderIcon(user.gender, context),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(user.name, style: nameStyle, textAlign: TextAlign.center),
          const SizedBox(height: 4),
          Text(user.email,
              style: emailStyle, textAlign: TextAlign.center),
          const SizedBox(height: 20),
          if (onEditProfileTap != null)
            ElevatedButton(
              onPressed: onEditProfileTap,
              style: editButtonStyle,
              child: const Text('Edit profil'),
            )
        ],
      ),
    );
  }
}
