import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:submission_final/core/theme/app_colors.dart';

class ColoredStatusBar extends StatelessWidget {
  const ColoredStatusBar({
    Key? key,
    required this.child,
    this.color = AppColors.primary,
    this.brightness = Brightness.dark,
    this.coloredBottomBar = false,
  }) : super(key: key);

  final Color? color;
  final Brightness brightness;
  final bool coloredBottomBar;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    Brightness iconBrightness;
    if (Platform.isIOS) {
      (brightness == Brightness.dark)
          ? iconBrightness = Brightness.light
          : iconBrightness = Brightness.dark;
    } else {
      iconBrightness = brightness;
    }
    const defaultColor = AppColors.primary;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarColor: color ?? defaultColor,
        statusBarIconBrightness: iconBrightness,
        statusBarBrightness: iconBrightness,
      ),
      child: Container(
        color: color ?? defaultColor,
        child: SafeArea(
          left: false,
          right: false,
          bottom: coloredBottomBar,
          child: child,
        ),
      ),
    );
  }
}
