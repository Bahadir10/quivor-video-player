import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:quivor/core/enum/auto_play_mode.dart';

part 'user_prefences.freezed.dart';

@freezed
class UserPrefrences with _$UserPrefrences {
  factory UserPrefrences({
    required double volume,
    @Default(AutoPlayMode.early) AutoPlayMode autoPlayMode,
    @Default(15) int earlyTransitionSeconds,
  }) = _UserPrefrences;
}
