import 'package:clypsera/app/shared/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/widgets/custom_appbar.dart';
import '../widgets/more_info_section_widget.dart';
import '../widgets/profile_header_widget.dart';
import '../widgets/profile_info_card_widget.dart';
import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(),
      backgroundColor:
          Style.whiteColor,
      body: Obx(() {
        if (controller.isLoading.value &&
            controller.currentUser.value == null) {
          return Center(
              child: CircularProgressIndicator(
                  color: Style.primaryColor));
        }
        if (controller.errorMessage.isNotEmpty &&
            controller.currentUser.value == null) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(controller.errorMessage.value,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Style.redColor)),
            ),
          );
        }
        if (controller.currentUser.value == null) {
          return const Center(
              child:
                  Text('Tidak dapat memuat data profil. Silakan coba lagi.'));
        }
        final user = controller.currentUser.value!;

        return RefreshIndicator(
          onRefresh: controller.fetchUserProfile,
          color: Style.primaryColor ,
          child: ListView(
            physics: const AlwaysScrollableScrollPhysics(
                parent: BouncingScrollPhysics()),
            children: [
              ProfileHeaderWidget(
                user: user,
                onEditProfileTap: controller.navigateToEditProfile,
              ),
              ProfileInfoCardWidget(
                job: user.job,
                dateOfBirth: user.dateOfBirth,
              ),
              MoreInfoSectionWidget(
                phoneNumber: user.phoneNumber,
                nik: user.nik,
                address: user.address,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 16.0),
                child: TextButton.icon(
                  icon: Icon(Icons.logout_rounded, color: Style.redColor, size: 26,),
                  label: Text(
                    'Log Out',
                    style: Style.headLineStyle21,
                  ),
                  onPressed: controller.logout,
                  style: TextButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20), 
            ],
          ),
        );
      }),
    );
  }
}
