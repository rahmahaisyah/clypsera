import 'package:clypsera/app/shared/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; 

class ProfileInfoCardWidget extends StatelessWidget {
  final String? job;
  final DateTime? dateOfBirth;

  const ProfileInfoCardWidget({
    super.key,
    this.job,
    this.dateOfBirth,
  });

  Widget _buildInfoItem(BuildContext context, {required IconData icon, required String label, required String value}) {
    // Warna ikon dan teks dari desain
    final Color iconColor = Style.primaryColor ;
    final TextStyle labelStyle = Style.headLineStyle15;
    final TextStyle valueStyle = Style.headLineStyle13;

    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: Style.whiteColor,
          borderRadius: BorderRadius.circular(12), // Radius kartu
          boxShadow: [ // Shadow halus
            BoxShadow(
              color: Colors.grey.shade200,
              spreadRadius: 1,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 26, color: iconColor),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: labelStyle),
                  const SizedBox(height: 3),
                  Text(value, style: valueStyle, maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormatter = DateFormat('dd/MM/yyyy');
    bool hasJob = job != null && job!.isNotEmpty;
    bool hasDob = dateOfBirth != null;

    if (!hasJob && !hasDob) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Row(
        children: [
          if (hasJob)
            _buildInfoItem(
              context,
              icon: Icons.badge_outlined, 
              label: 'Pekerjaan',
              value: job!,
            ),
          if (hasJob && hasDob) 
            const SizedBox(width: 12),
          if (hasDob)
            _buildInfoItem(
              context,
              icon: Icons.calendar_month_outlined,
              label: 'Tanggal lahir',
              value: dateFormatter.format(dateOfBirth!),
            ),
          if ((hasJob && !hasDob) || (!hasJob && hasDob))
            const Expanded(child: SizedBox.shrink()),
        ],
      ),
    );
  }
}
