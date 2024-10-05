import 'package:flutter/material.dart';

extension ObjectExtension on Object {
  WidgetStateProperty widgetStatePropertyAll<T>({T? data}) =>
      WidgetStatePropertyAll(data ?? this);
}

extension NullableObjectExtension on Object? {
  bool get isNull => this == null;
  bool get isNotNull => this != null;
}
