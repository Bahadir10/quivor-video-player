import 'package:app_materials/src/utils/colors.dart';
import 'package:flutter/material.dart';

@immutable
final class AppTypography {
  const AppTypography._();

  static const _color = AppColors.white1;

  static const TextStyle headingLarge =
      TextStyle(fontSize: 32, color: _color, fontFamily: 'PTSans');
  static const TextStyle headingMedium =
      TextStyle(fontSize: 28, color: _color, fontFamily: 'PTSans');
  static const TextStyle headingSmall =
      TextStyle(fontSize: 24, color: _color, fontFamily: 'PTSans');
  static const TextStyle title =
      TextStyle(fontSize: 22, color: _color, fontFamily: 'PTSans');
  static const TextStyle bodyLarge =
      TextStyle(fontSize: 16, color: _color, fontFamily: 'PTSans');
  static const TextStyle bodyMedium =
      TextStyle(fontSize: 14, color: _color, fontFamily: 'PTSans');
  static const TextStyle bodySmall =
      TextStyle(fontSize: 12, color: _color, fontFamily: 'PTSans');

  static const TextStyle bottomText =
      TextStyle(fontSize: 10, color: _color, fontFamily: 'PTSans');
}
