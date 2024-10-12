import 'package:flutter/widgets.dart';

@immutable
final class UserPrefrences {
  final double volume;
  const UserPrefrences({
    required this.volume,
  });

  UserPrefrences copyWith({
    double? volume,
  }) {
    return UserPrefrences(
      volume: volume ?? this.volume,
    );
  }
}
