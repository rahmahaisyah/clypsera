import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../constants/uidata.dart';
import '../theme/app_style.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Style.whiteColor,
      elevation: 0.5,
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Clypsera',
            style: Style.headLineStyle2,
          ),
          InkWell(
            onTap: () => Get.toNamed('/notification'),
            customBorder: const CircleBorder(),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(
                notifIcon,
                width: 20,
                height: 20,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.notifications_none, size: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}