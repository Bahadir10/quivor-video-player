import 'package:flutter/material.dart';


class NexorSpacerThemeExtension
    extends ThemeExtension<NexorSpacerThemeExtension> {


  final Map<String, double> standarts;

  const NexorSpacerThemeExtension({
    this.standarts = const {'low': 4},

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

  @override
  ThemeExtension<NexorSpacerThemeExtension> copyWith({
    Map<String, double>? standarts,

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

  }
}
