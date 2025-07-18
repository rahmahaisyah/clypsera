import 'package:clypsera/app/data/models/user_profile_model.dart';
import 'package:clypsera/app/shared/theme/app_style.dart';
import 'package:flutter/material.dart';
import '../../../constants/uidata.dart';

class ProfileHeaderWidget extends StatelessWidget {
  final UserProfileModel user;
  final VoidCallback? onEditProfileTap;

  const ProfileHeaderWidget({
    super.key,
    required this.user,
    this.onEditProfileTap,
  });

  @override
  Widget build(BuildContext context) {
    const double avatarDiameter = 100.0;
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
          Container(
            width: avatarDiameter,
            height: avatarDiameter,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Style.primaryColor,
            ),
            child: Icon(
              Icons.person, // Ikon bawaan profil dari Flutter
              color: Style.whiteColor,
              size: avatarDiameter * 0.6, // Sesuaikan ukuran ikon
            ),
          ),
          const SizedBox(height: 16),
          Text(user.name, style: nameStyle, textAlign: TextAlign.center),
          const SizedBox(height: 4),
          Text(user.email, style: emailStyle, textAlign: TextAlign.center),
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
