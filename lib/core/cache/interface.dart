import 'package:nexor/nexor.dart';
import 'package:quivor/core/cache/implementation.dart';
import 'package:quivor/core/models/cache/user_prefences.dart';

abstract class ICacheManager {
  const ICacheManager();

  Future<UserPrefrences> getUserPrefrences();
  FV setUserVolumeSelection(double volume);
  FV setAutoPlayMode(String mode);
  FV setEarlyTransitionSeconds(int seconds);

  factory ICacheManager.scoped() => CacheManager();
}
