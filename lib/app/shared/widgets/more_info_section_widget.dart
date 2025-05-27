import 'package:clypsera/app/shared/theme/app_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MoreInfoSectionWidget extends StatelessWidget {
  final String? phoneNumber;
  final String? nik;
  final String? address;

  const MoreInfoSectionWidget({
    super.key,
    this.phoneNumber,
    this.nik,
    this.address,
  });

  Widget _buildInfoRow(BuildContext context,
      {required IconData icon, required String label, required String? value}) {
    if (value == null || value.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(icon, size: 26, color: Style.primaryColor),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Style.headLineStyle15,
                ),
                const SizedBox(height: 3),
                Text(
                  value,
                  style: Style.headLineStyle13,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Informasi Lebih',
            style: Style.headLineStyle19,
          ),
          const SizedBox(height: 8),
          _buildInfoRow(
            context,
            icon: CupertinoIcons.phone,
            label: 'Nomor telpon',
            value: phoneNumber,
          ),
          Divider(color: Colors.grey[200], height: 1),
          _buildInfoRow(
            context,
            icon: Icons.description_outlined,
            label: 'NIK',
            value: nik,
          ),
          Divider(color: Colors.grey[200], height: 1),
          _buildInfoRow(
            context,
            icon: Icons.location_on_outlined,
            label: 'Alamat',
            value: address,
          ),
        ],
      ),
    );
  }
}
