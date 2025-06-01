import 'package:flutter/material.dart';
import 'package:clypsera/app/data/models/cleft_type_model.dart';
import 'package:clypsera/app/shared/theme/app_style.dart';

class CleftTypeCard extends StatelessWidget {
  final CleftTypeModel cleftType;
  final VoidCallback? onTap;

  const CleftTypeCard({
    super.key,
    required this.cleftType,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    const double iconRenderSize = 36.0;
    const double iconContainerBorderRadius = 12.0;

    return InkWell(
      borderRadius: BorderRadius.circular(iconContainerBorderRadius),
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Style.primaryColorOp4,
              borderRadius: BorderRadius.circular(iconContainerBorderRadius),
            ),
            child: Center(
              child: ClipRRect(
                child: Image.network(
                  cleftType.iconUrl,
                  width: iconRenderSize,
                  height: iconRenderSize,
                  fit: BoxFit.contain,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const SizedBox(
                        width: iconRenderSize,
                        height: iconRenderSize,
                        child: Center(
                            child: CircularProgressIndicator(
                          strokeWidth: 2,
                        )));
                  },
                ),
              ),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            cleftType.name,
            textAlign: TextAlign.center,
            style: Style.headLineStyle17, 
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
