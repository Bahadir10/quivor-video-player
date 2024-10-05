import 'package:nexor/nexor.dart';
import 'package:quivor/core/cache/interface.dart';
import 'package:quivor/core/models/cache/user_prefences.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class CacheManager extends ICacheManager {
  @override
  Future<UserPrefrences> getUserPrefrences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final volume = prefs.getDouble('volume');
    return UserPrefrences(volume: volume ?? 80);
  }

  @override
  FV setUserVolumeSelection(double volume) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('volume', volume);
  }
}
