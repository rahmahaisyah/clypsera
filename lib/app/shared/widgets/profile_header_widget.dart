import 'package:clypsera/app/data/models/user_profile_model.dart';
import 'package:clypsera/app/shared/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../constants/uidata.dart';

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
  
  switch (gender) {
    case Gender.male:
      iconAsset = genderMaleIcon;
      break;
    case Gender.female:
      iconAsset = genderFemaleIcon;
      break;
    default:
      return const SizedBox.shrink();
  }

  return Container(
    padding: const EdgeInsets.all(5),
    decoration: BoxDecoration(
      color: Style.primaryColor,
      shape: BoxShape.circle,
      border: Border.all(color: Style.whiteColor),
    ),
    child: Image.network(iconAsset, width: 14, height: 14), 
  );
}


  @override
  Widget build(BuildContext context) {
    const double avatarDiameter = 100.0; // Diameter avatar utama
    const double genderIconDiameter = 28.0; // Diameter container ikon gender

    // Style untuk nama dan email (gunakan fallback jika Style belum lengkap)
    final TextStyle nameStyle = Style.headLineStyle14;
    final TextStyle emailStyle = Style.headLineStyle14;

    // Style untuk tombol Edit Profile
    final ButtonStyle editButtonStyle = ElevatedButton.styleFrom(
      backgroundColor:
          Style.primaryColorOp4, // Warna latar tombol (abu-abu kebiruan muda)
      foregroundColor: Style.primaryColor, // Warna teks tombol (biru tua)
      elevation: 0, // Tanpa shadow
      padding: const EdgeInsets.symmetric(
          horizontal: 40, vertical: 12), // Padding tombol
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25), // Radius tombol pill
      ),
      textStyle: Style.headLineStyle14,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 24.0), // Padding atas dan bawah untuk seluruh header
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            // Container untuk Stack avatar dan ikon gender
            width: avatarDiameter +
                genderIconDiameter *
                    0.2, // Lebar disesuaikan agar ikon gender pas
            height:
                avatarDiameter + genderIconDiameter * 0.2, // Tinggi disesuaikan
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Avatar Utama
                Container(
                  width: avatarDiameter,
                  height: avatarDiameter,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    // Warna placeholder jika tidak ada avatarUrl (biru tua seperti di desain)
                    color: Style.primaryColor,
                    image:
                        (user.avatarUrl != null && user.avatarUrl!.isNotEmpty)
                            ? DecorationImage(
                                image: NetworkImage(user.avatarUrl!),
                                fit: BoxFit.cover,
                              )
                            : null,
                  ),
                  // Ikon placeholder jika tidak ada avatarUrl
                  child: (user.avatarUrl == null || user.avatarUrl!.isEmpty)
                      ? Icon(CupertinoIcons.person_fill,
                          size: avatarDiameter * 0.6,
                          color: Colors.white.withOpacity(0.9))
                      : null,
                ),
                // Ikon Gender Overlay
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: SizedBox(
                      // Beri ukuran eksplisit untuk container ikon gender
                      width: genderIconDiameter,
                      height: genderIconDiameter,
                      child: _buildGenderIcon(user.gender, context),

                    )),
              ],
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
              child: const Text('Edit profile'),
            )
        ],
      ),
    );
  }
}
