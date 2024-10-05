import 'package:flutter/material.dart';

@immutable
final class Helper {
  const Helper._();

  static double getPercentage({
    required double max,
    required double progress,
  }) {
    final p = progress / max * 100;
    return p.isNaN ? 0.0 : p;
  }
}
