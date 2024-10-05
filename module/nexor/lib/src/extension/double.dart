import 'package:flutter/widgets.dart';

extension DoubleWidgetExtension on double {
  SizedBox get verticalSpace => SizedBox(
        height: this,
      );
  SizedBox get horizontalSpace => SizedBox(
        width: this,
      );
}
