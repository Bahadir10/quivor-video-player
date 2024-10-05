import 'package:flutter/material.dart';
import 'package:nexor/src/extension/double.dart';

class NexorSpacerThemeExtension
    extends ThemeExtension<NexorSpacerThemeExtension> {
  // final double low;
  // final double medium;
  // final double high;

  final Map<String, double> standarts;

  const NexorSpacerThemeExtension({
    this.standarts = const {'low': 4},
    // this.low = 4,
    // this.medium = 8,
    // this.high = 16,
  });

  SizedBox all(
    String key,
  ) {
    final value = standarts[key];
    return SizedBox(
      height: value,
      width: value,
    );
  }

  SizedBox horizontal(
    String key,
  ) {
    final value = standarts[key];
    return SizedBox(
      width: value,
    );
  }

  SizedBox vertical(
    String key,
  ) {
    final value = standarts[key];
    return SizedBox(
      height: value,
    );
  }
  // SizedBox get verticalLow => low.verticalSpace;
  // SizedBox get verticalMedium => medium.verticalSpace;
  // SizedBox get verticalHigh => high.verticalSpace;

  // SizedBox get horizontalLow => low.horizontalSpace;
  // SizedBox get horizontalMedium => medium.horizontalSpace;
  // SizedBox get horizontalHigh => high.horizontalSpace;

  @override
  ThemeExtension<NexorSpacerThemeExtension> copyWith({
    Map<String, double>? standarts,
    // double? low,
    // double? medium,
    // double? high,
  }) {
    return NexorSpacerThemeExtension(standarts: standarts ?? this.standarts);
  }

  @override
  ThemeExtension<NexorSpacerThemeExtension> lerp(
      covariant ThemeExtension<NexorSpacerThemeExtension>? other, double t) {
    if (other is! Spacer) {
      return this;
    }
    return this;
    // return NexorSpacerThemeExtension();
  }
}
