import 'package:flutter/material.dart';
import 'package:nexor/nexor.dart';

extension NexorBuildContextExtension on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  Size get size => MediaQuery.of(this).size;

  double get column => size.width / 12;

  double col(int x) => (size.width / 12) * x;

  double get width => size.width;
  double get height => size.height;
  NexorSpacerThemeExtension get spacer =>
      Theme.of(this).extension<NexorSpacerThemeExtension>() ??
      const NexorSpacerThemeExtension();
}
