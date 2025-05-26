import 'package:clypsera/app/shared/theme/app_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/bottomnavigation_controller.dart';

class BottomnavigationView extends GetView<BottomnavigationController> {
  const BottomnavigationView({super.key});

  bool _isNetworkUrl(String path) {
    if (path.isEmpty) return false;
    return path.startsWith('http://') || path.startsWith('https://');
  }

  Widget _buildIconWidget(String path, double size, Color color,
      {bool isActiveIconOnPrimary = false}) {
    final Color effectiveErrorIconColor =
        isActiveIconOnPrimary ? Style.whiteColor : color;

    if (path.isEmpty) {
      print('Warning: Empty icon path provided.');
      return Icon(Icons.help_outline,
          color: effectiveErrorIconColor, size: size);
    }

    if (_isNetworkUrl(path)) {
      return Image.network(
        path,
        width: size,
        height: size,
        color: color,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          print('Error loading network image: $path, $error');
          return Icon(Icons.error_outline,
              color: effectiveErrorIconColor, size: size);
        },
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return SizedBox(
            width: size,
            height: size,
            child: Center(
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor:
                    AlwaysStoppedAnimation<Color>(effectiveErrorIconColor),
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded /
                        loadingProgress.expectedTotalBytes!
                    : null,
              ),
            ),
          );
        },
      );
    } else {
      return Image.asset(
        path,
        width: size,
        height: size,
        color: color, // Terapkan tint warna
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          print('Error loading asset image: $path, $error');
          return Icon(Icons.broken_image_outlined,
              color: effectiveErrorIconColor, size: size);
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final Color activePillColor = Style.primaryColor;
    final Color activeContentColor = Style.whiteColor;
    final Color inactiveIconColor = Style.bottomNavPillColor;
    const double iconSize = 24.0;
    const double bottomNavHeight = kBottomNavigationBarHeight + 16.0;
    const Duration animationDuration = Duration(milliseconds: 300);

    final screenWidth = MediaQuery.of(context).size.width;
    final itemWidth = screenWidth / controller.navigationItems.length;

    return Scaffold(
      body: Obx(() => SafeArea(child: controller.currentScreen)),
      bottomNavigationBar: Obx(
        () => Container(
          height: bottomNavHeight,
          decoration: BoxDecoration(
            color: Style.whiteColor,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 5,
                offset: const Offset(0, -1),
              ),
            ],
          ),
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: controller.navigationItems.map((item) {
                  final int index = controller.navigationItems.indexOf(item);
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => controller.changePage(index),
                      behavior: HitTestBehavior.opaque,
                      child: Container(
                        height: bottomNavHeight,
                        alignment: Alignment.center,
                        child: _buildIconWidget(
                          item.inactiveIconPath,
                          iconSize,
                          inactiveIconColor,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
              AnimatedPositioned(
                duration: animationDuration,
                curve: Curves.easeInOut,
                left: controller.currentIndex.value * itemWidth +
                    (itemWidth - (itemWidth * 0.75)) / 2,
                top: (bottomNavHeight - (iconSize + 16 + 5)) / 2,
                height: iconSize + 16 + 5,
                width: itemWidth * 0.75,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  decoration: BoxDecoration(
                    color: activePillColor,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildIconWidget(
                        controller
                            .navigationItems[controller.currentIndex.value]
                            .activeIconPath,
                        iconSize,
                        activeContentColor,
                        isActiveIconOnPrimary: true,
                      ),
                      const SizedBox(width: 6),
                      Flexible(
                        child: Text(
                          controller
                              .navigationItems[controller.currentIndex.value]
                              .label,
                          style: TextStyle(
                            color: activeContentColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                          overflow: TextOverflow.clip,
                          maxLines: 1,
                          softWrap: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
