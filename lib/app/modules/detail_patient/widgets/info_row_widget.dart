import 'package:clypsera/app/shared/theme/app_style.dart';
import 'package:flutter/material.dart';

class InfoRowWidget extends StatelessWidget {
  final String label;
  final String value;
  final VoidCallback?
      onTap; 
  final bool isNavigation; 

  const InfoRowWidget({
    super.key,
    required this.label,
    required this.value,
    this.onTap,
    this.isNavigation = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2, 
              child: Text(label, style: Style.headLineStyle4),
            ),
            const SizedBox(width: 8),
            Expanded(
              flex: 3, 
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Text(
                      value,
                      textAlign: TextAlign.right,
                      style: Style.headLineStyle5,
                    ),
                  ),
                  if (isNavigation)
                    Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Icon(Icons.arrow_forward_ios,
                          size: 16, color: Style.primaryColor),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
