import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Keyboard shortcuts service for managing and executing keyboard shortcuts
class KeyboardShortcutsService {
  static final KeyboardShortcutsService _instance =
      KeyboardShortcutsService._internal();
  factory KeyboardShortcutsService() => _instance;
  KeyboardShortcutsService._internal();

  static const String _prefsPrefix = 'keyboard_shortcut_';

  // Default shortcuts
  static final Map<String, ShortcutConfig> _defaultShortcuts = {
    'playPause': ShortcutConfig(
      key: LogicalKeyboardKey.space,
      label: 'Play/Pause',
      action: 'playPause',
    ),
    'playPauseK': ShortcutConfig(
      key: LogicalKeyboardKey.keyK,
      label: 'Play/Pause (K)',
      action: 'playPause',
    ),
    'seekBackward': ShortcutConfig(
      key: LogicalKeyboardKey.arrowLeft,
      label: 'Seek Backward 10s',
      action: 'seekBackward',
    ),
    'seekForward': ShortcutConfig(
      key: LogicalKeyboardKey.arrowRight,
      label: 'Seek Forward 10s',
      action: 'seekForward',
    ),
    'seekBackwardJ': ShortcutConfig(
      key: LogicalKeyboardKey.keyJ,
      label: 'Seek Backward 10s (J)',
      action: 'seekBackward',
    ),
    'seekForwardL': ShortcutConfig(
      key: LogicalKeyboardKey.keyL,
      label: 'Seek Forward 10s (L)',
      action: 'seekForward',
    ),
    'volumeUp': ShortcutConfig(
      key: LogicalKeyboardKey.arrowUp,
      label: 'Volume Up',
      action: 'volumeUp',
    ),
    'volumeDown': ShortcutConfig(
      key: LogicalKeyboardKey.arrowDown,
      label: 'Volume Down',
      action: 'volumeDown',
    ),
    'toggleMute': ShortcutConfig(
      key: LogicalKeyboardKey.keyM,
      label: 'Toggle Mute',
      action: 'toggleMute',
    ),
    'toggleFullscreen': ShortcutConfig(
      key: LogicalKeyboardKey.keyF,
      label: 'Toggle Fullscreen',
      action: 'toggleFullscreen',
    ),
    'nextVideo': ShortcutConfig(
      key: LogicalKeyboardKey.keyN,
      label: 'Next Video',
      action: 'nextVideo',
    ),
    'previousVideo': ShortcutConfig(
      key: LogicalKeyboardKey.keyP,
      label: 'Previous Video',
      action: 'previousVideo',
    ),
  };

  Map<String, ShortcutConfig> _shortcuts = {};

  /// Initialize shortcuts from preferences
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    _shortcuts = Map.from(_defaultShortcuts);

    // Load custom shortcuts from preferences
    for (final entry in _defaultShortcuts.entries) {
      final savedKey = prefs.getString('$_prefsPrefix${entry.key}');
      if (savedKey != null) {
        final keyId = int.tryParse(savedKey);
        if (keyId != null) {
          _shortcuts[entry.key] = entry.value.copyWith(
            key: LogicalKeyboardKey(keyId),
          );
        }
      }
    }
  }

  /// Get all shortcuts
  Map<String, ShortcutConfig> getShortcuts() => Map.unmodifiable(_shortcuts);

  /// Get shortcut by action
  List<ShortcutConfig> getShortcutsByAction(String action) {
    return _shortcuts.values.where((s) => s.action == action).toList();
  }

  /// Update a shortcut
  Future<void> updateShortcut(String id, LogicalKeyboardKey newKey) async {
    if (!_shortcuts.containsKey(id)) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('$_prefsPrefix$id', newKey.keyId.toString());

    _shortcuts[id] = _shortcuts[id]!.copyWith(key: newKey);
  }

  /// Reset shortcut to default
  Future<void> resetShortcut(String id) async {
    if (!_defaultShortcuts.containsKey(id)) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('$_prefsPrefix$id');

    _shortcuts[id] = _defaultShortcuts[id]!;
  }

  /// Reset all shortcuts to defaults
  Future<void> resetAllShortcuts() async {
    final prefs = await SharedPreferences.getInstance();
    for (final key in _defaultShortcuts.keys) {
      await prefs.remove('$_prefsPrefix$key');
    }
    _shortcuts = Map.from(_defaultShortcuts);
  }

  /// Check if a key is already used
  bool isKeyUsed(LogicalKeyboardKey key, {String? excludeId}) {
    return _shortcuts.entries.any((entry) =>
        entry.key != excludeId && entry.value.key.keyId == key.keyId);
  }

  /// Get action for a key press
  String? getActionForKey(LogicalKeyboardKey key) {
    final shortcut = _shortcuts.values.firstWhere(
      (s) => s.key.keyId == key.keyId,
      orElse: () => ShortcutConfig(
        key: LogicalKeyboardKey.space,
        label: '',
        action: '',
      ),
    );
    return shortcut.action.isEmpty ? null : shortcut.action;
  }
}

/// Shortcut configuration model
class ShortcutConfig {
  final LogicalKeyboardKey key;
  final String label;
  final String action;

  ShortcutConfig({
    required this.key,
    required this.label,
    required this.action,
  });

  ShortcutConfig copyWith({
    LogicalKeyboardKey? key,
    String? label,
    String? action,
  }) {
    return ShortcutConfig(
      key: key ?? this.key,
      label: label ?? this.label,
      action: action ?? this.action,
    );
  }

  String get keyLabel {
    final label = key.keyLabel;
    if (label.isNotEmpty) return label.toUpperCase();

    // Handle special keys
    switch (key.keyId) {
      case 0x20:
        return 'SPACE';
      case 0x100000301:
        return '←';
      case 0x100000302:
        return '→';
      case 0x100000303:
        return '↑';
      case 0x100000304:
        return '↓';
      default:
        return 'KEY';
    }
  }
}
