// lib/features/home/widgets/yayasan_card.dart

import 'package:flutter/material.dart';

import '../../data/models/yayasan_model.dart';
import '../theme/app_style.dart';

class YayasanCard extends StatelessWidget {
  final YayasanModel yayasan;
  final VoidCallback? onTap;

  const YayasanCard({
    super.key,
    required this.yayasan,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 230, 
          margin: const EdgeInsets.only(right: 16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.0),
            
            
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: Image.network(
                  yayasan.imageUrl,
                  height: 110, 
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 110,
                      width: double.infinity,
                      color: Colors.grey[200],
                      child: Icon(Icons.business_rounded, color: Colors.grey[400], size: 40),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      yayasan.name,
                      style:  Style.headLineStyle17,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4.0),
                    Text(
                      yayasan.location,
                      style:  Style.headLineStyle15,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}