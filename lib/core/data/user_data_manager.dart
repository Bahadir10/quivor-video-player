// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:nexor/nexor.dart';
import 'package:quivor/core/cache/interface.dart';
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

  Future<UserPrefrences> get userPrefrences async =>
      _userPref ??= await cacheManager.getUserPrefrences();
}
