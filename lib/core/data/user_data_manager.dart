// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:nexor/nexor.dart';
import 'package:quivor/core/cache/interface.dart';
import 'package:quivor/core/enum/auto_play_mode.dart';
import 'package:quivor/core/models/cache/user_prefences.dart';

final class UserDataManager {
  static final UserDataManager _UserDataManager = UserDataManager._internal();

  factory UserDataManager() {
    return _UserDataManager;
  }

  UserDataManager._internal();

  UserPrefrences? _userPref;

  final ICacheManager cacheManager = ICacheManager.scoped();

  FV setVolume(double volume) async {
    final x = await userPrefrences;
    _userPref = x.copyWith(volume: volume);
    await cacheManager.setUserVolumeSelection(volume);
  }

  FV setAutoPlayMode(String mode) async {
    final x = await userPrefrences;
    final autoPlayMode = AutoPlayMode.values.firstWhere(
      (m) => m.name == mode,
      orElse: () => AutoPlayMode.early,
    );
    _userPref = x.copyWith(autoPlayMode: autoPlayMode);
    await cacheManager.setAutoPlayMode(mode);
  }

  FV setEarlyTransitionSeconds(int seconds) async {
    final x = await userPrefrences;
    _userPref = x.copyWith(earlyTransitionSeconds: seconds);
    await cacheManager.setEarlyTransitionSeconds(seconds);
  }

  FV setSeekDurationSeconds(int seconds) async {
    final x = await userPrefrences;
    _userPref = x.copyWith(seekDurationSeconds: seconds);
    await cacheManager.setSeekDurationSeconds(seconds);
  }

  Future<UserPrefrences> get userPrefrences async =>
      _userPref ??= await cacheManager.getUserPrefrences();
}
