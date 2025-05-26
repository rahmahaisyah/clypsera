import 'package:flutter/material.dart';

class NavigationItemModel {
  final String activeIconPath;
  final String inactiveIconPath;
  final String label;
  final Widget screen;

  NavigationItemModel({
    required this.activeIconPath,
    required this.inactiveIconPath,
    required this.label,
    required this.screen,
  });
}