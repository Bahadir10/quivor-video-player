import 'package:flutter/material.dart';

extension IconExtension on Icon {
  Icon copyWith({double? size, Color? color}) => Icon(
        icon,
        size: size ?? this.size,
        color: color ?? this.color,
      );
}
