import 'package:clypsera/app/constants/uidata.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/theme/app_style.dart';
import '../controllers/notification_controller.dart';

class NotificationView extends GetView<NotificationController> {
  const NotificationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Style.whiteColor,
      appBar: AppBar(
        backgroundColor: Style.whiteColor,
        elevation: 0.5,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Style.blackColor),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Notifikasi',
          style: Style.headLineStyle12,
        ),
        centerTitle: false,
      ),
      body: Obx(() => ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: controller.notifications.length,
            separatorBuilder: (_, __) =>
                Divider(color: Colors.grey[200], height: 24),
            itemBuilder: (context, i) {
              final notif = controller.notifications[i];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(approveIcon, width: 60, height: 60),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notif.title,
                          style: Style.headLineStyle5,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Style.primaryColor,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 18, vertical: 8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      // TODO: Implement download logic
                    },
                    child: Text(
                      'Download',
                      style: Style.headLineStyle6,
                    ),
                  ),
                ],
              );
            },
          )),
    );
  }
}
