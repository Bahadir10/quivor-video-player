import 'package:flutter/material.dart';

extension ColorExtension on Color {
  WidgetStateProperty<Color> get widgetStatePropertyAll =>
      WidgetStatePropertyAll(this);
}
