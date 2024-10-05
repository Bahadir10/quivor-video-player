import 'package:flutter/material.dart';

@immutable
abstract class IEntity {
  final int id;
  const IEntity({required this.id});
}
