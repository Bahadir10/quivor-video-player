import 'package:nexor/nexor.dart';
import 'package:quivor/core/models/cache/user_prefences.dart';

abstract class ICacheManager {
  Future<UserPrefrences> getUserPrefrences();
  FV setUserVolumeSelection(double volume);
}
