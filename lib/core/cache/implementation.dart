import 'package:nexor/nexor.dart';
import 'package:quivor/core/cache/interface.dart';
import 'package:quivor/core/enum/auto_play_mode.dart';
import 'package:quivor/core/models/cache/user_prefences.dart';
import 'package:shared_preferences/shared_preferences.dart';

final class CacheManager extends ICacheManager {
  @override
  Future<UserPrefrences> getUserPrefrences() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final volume = prefs.getDouble('volume');
    final autoPlayModeString = prefs.getString('autoPlayMode');
    final earlyTransitionSeconds = prefs.getInt('earlyTransitionSeconds');
    final seekDurationSeconds = prefs.getInt('seekDurationSeconds');

    // Parse auto play mode from string
    AutoPlayMode autoPlayMode = AutoPlayMode.early;
    if (autoPlayModeString != null) {
      try {
        autoPlayMode = AutoPlayMode.values.firstWhere(
          (mode) => mode.name == autoPlayModeString,
          orElse: () => AutoPlayMode.early,
        );
      } catch (_) {
        autoPlayMode = AutoPlayMode.early;
      }
    }

    return UserPrefrences(
      volume: volume ?? 80,
      autoPlayMode: autoPlayMode,
      earlyTransitionSeconds: earlyTransitionSeconds ?? 15,
      seekDurationSeconds: seekDurationSeconds ?? 10,
    );
  }

  @override
  FV setUserVolumeSelection(double volume) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('volume', volume);
  }

  @override
  FV setAutoPlayMode(String mode) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('autoPlayMode', mode);
  }

  @override
  FV setEarlyTransitionSeconds(int seconds) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('earlyTransitionSeconds', seconds);
  }

  @override
  FV setSeekDurationSeconds(int seconds) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('seekDurationSeconds', seconds);
  }
}
