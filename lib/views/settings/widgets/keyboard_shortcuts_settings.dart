import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:quivor/core/service/keyboard_shortcuts_service.dart';
import 'package:quivor/widgets/modern_card.dart';
import 'package:quivor/widgets/modern_button.dart';
import 'package:app_materials/app_materials.dart';

class KeyboardShortcutsSettings extends StatefulWidget {
  const KeyboardShortcutsSettings({super.key});

  @override
  State<KeyboardShortcutsSettings> createState() =>
      _KeyboardShortcutsSettingsState();
}

class _KeyboardShortcutsSettingsState extends State<KeyboardShortcutsSettings> {
  final _service = KeyboardShortcutsService();
  String? _editingId;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadShortcuts();
  }

  Future<void> _loadShortcuts() async {
    await _service.initialize();
    setState(() {});
  }

  Future<void> _resetAll() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset All Shortcuts'),
        content: const Text(
            'Are you sure you want to reset all keyboard shortcuts to defaults?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Reset', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      await _service.resetAllShortcuts();
      setState(() {
        _errorMessage = null;
      });
    }
  }

  void _startEditing(String id) {
    setState(() {
      _editingId = id;
      _errorMessage = null;
    });
  }

  void _cancelEditing() {
    setState(() {
      _editingId = null;
      _errorMessage = null;
    });
  }

  Future<void> _handleKeyPress(String id, LogicalKeyboardKey key) async {
    // Check if key is already used
    if (_service.isKeyUsed(key, excludeId: id)) {
      setState(() {
        _errorMessage = 'This key is already assigned to another action';
      });
      return;
    }

    await _service.updateShortcut(id, key);
    setState(() {
      _editingId = null;
      _errorMessage = null;
    });
  }

  Widget _buildShortcutItem(String id, ShortcutConfig config) {
    final isEditing = _editingId == id;

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isEditing
            ? Colors.blue.withValues(alpha: 0.05)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isEditing ? Colors.blue : Colors.grey.withValues(alpha: 0.2),
          width: isEditing ? 2 : 1,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(
              config.label,
              style: const TextStyle(fontSize: 14),
            ),
          ),
          const SizedBox(width: 16),
          if (isEditing)
            Expanded(
              child: Focus(
                autofocus: true,
                onKeyEvent: (node, event) {
                  if (event is KeyDownEvent) {
                    _handleKeyPress(id, event.logicalKey);
                    return KeyEventResult.handled;
                  }
                  return KeyEventResult.ignored;
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.blue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Colors.blue, width: 2),
                  ),
                  child: const Text(
                    'Press any key...',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          else
            Expanded(
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.grey1.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  config.keyLabel,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ),
          const SizedBox(width: 8),
          if (isEditing)
            IconButton(
              icon: const Icon(Icons.close, size: 20),
              onPressed: _cancelEditing,
              tooltip: 'Cancel',
            )
          else
            IconButton(
              icon: const Icon(Icons.edit, size: 20),
              onPressed: () => _startEditing(id),
              tooltip: 'Edit',
            ),
          IconButton(
            icon: const Icon(Icons.refresh, size: 20),
            onPressed: () async {
              await _service.resetShortcut(id);
              setState(() {});
            },
            tooltip: 'Reset to default',
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final shortcuts = _service.getShortcuts();

    return ModernCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.keyboard, color: Colors.blue),
              const SizedBox(width: 12),
              const Text(
                'Keyboard Shortcuts',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              ModernButton(
                text: 'Reset All',
                onPressed: _resetAll,
                isPrimary: false,
              ),
            ],
          ),
          const SizedBox(height: 16),
          if (_errorMessage != null)
            Container(
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      _errorMessage!,
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),
          ...shortcuts.entries
              .map((entry) => _buildShortcutItem(entry.key, entry.value)),
        ],
      ),
    );
  }
}
