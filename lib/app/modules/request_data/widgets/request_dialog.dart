import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/uidata.dart';
import '../../../routes/app_pages.dart';
import '../../../shared/theme/app_style.dart';

class RequestDialog extends StatefulWidget {
  const RequestDialog({super.key});

  @override
  State<RequestDialog> createState() => _RequestDialogState();
}

class _RequestDialogState extends State<RequestDialog> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Get.offAllNamed(Routes.bottomnavigation);
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      backgroundColor: Style.whiteColor,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(sentRequestIcon, width: 100, height: 100),
            const SizedBox(height: 24),
            Text(
              'Permintaan anda sedang diproses',
              style: Style.headLineStyle2,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              'Kami akan segera mengabari anda kembali',
              style: Style.headLineStyle6.copyWith(
                color: Colors.grey[300],
                fontWeight: FontWeight.normal,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
