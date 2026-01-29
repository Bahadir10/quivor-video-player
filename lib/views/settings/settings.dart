import 'dart:io';

import 'package:flutter/material.dart';
import 'package:quivor/core/service/env/env_config_service.dart';
import 'package:quivor/core/service/opensubtitles/implementation.dart';
import 'package:quivor/widgets/modern_card.dart';
import 'package:quivor/widgets/modern_button.dart';
import 'package:quivor/widgets/modern_input.dart';
import 'package:app_materials/app_materials.dart';
import 'package:quivor/core/extensions/build_context.dart';
import 'package:quivor/core/enum/route.dart';
import 'package:quivor/core/localization/localization_service.dart';
import 'package:quivor/views/settings/widgets/keyboard_shortcuts_settings.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _tokenController = TextEditingController();

  bool _isLoading = false;
  bool _hasToken = false;
  String? _maskedToken;
  String? _errorMessage;
  String? _successMessage;

  @override
  void initState() {
    super.initState();
    _loadTokenStatus();
  }

  Future<void> _loadTokenStatus() async {
    final hasToken = await envConfig.hasAuthToken();
    final maskedToken = await envConfig.getMaskedToken();

    setState(() {
      _hasToken = hasToken;
      _maskedToken = maskedToken;
    });
  }

  Future<void> _login() async {
    if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter username and password';
        _successMessage = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      final service = OpenSubtitlesService();
      await service.login(_usernameController.text, _passwordController.text);

      await _loadTokenStatus();

      setState(() {
        _isLoading = false;
        _successMessage = 'Successfully logged in!';
        _usernameController.clear();
        _passwordController.clear();
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    }
  }

  Future<void> _saveToken() async {
    if (_tokenController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter a token';
        _successMessage = null;
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      await envConfig.saveAuthToken(_tokenController.text);
      await _loadTokenStatus();

      setState(() {
        _isLoading = false;
        _successMessage = 'Token saved successfully!';
        _tokenController.clear();
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    }
  }

  Future<void> _testConnection() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
    });

    try {
      final service = OpenSubtitlesService();
      final userInfo = await service.testAuthentication();

      final username = userInfo['username'] ?? 'Unknown';

      setState(() {
        _isLoading = false;
        _successMessage = 'Connection successful! Logged in as: $username';
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
        _errorMessage = e.toString().replaceAll('Exception: ', '');
      });
    }
  }

  Future<void> _clearToken() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Credentials'),
        content: const Text(
            'Are you sure you want to clear your OpenSubtitles credentials?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Clear', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      try {
        await envConfig.clearAuthToken();
        await _loadTokenStatus();

        setState(() {
          _successMessage = 'Credentials cleared';
          _errorMessage = null;
        });
      } catch (e) {
        setState(() {
          _errorMessage = e.toString().replaceAll('Exception: ', '');
          _successMessage = null;
        });
      }
    }
  }

  Widget _buildLanguageOption(
    BuildContext context, {
    required Locale locale,
    required String flag,
    required String name,
  }) {
    final currentLocale = localizationService.getCurrentLocale(context);
    final isSelected = currentLocale.languageCode == locale.languageCode;

    return InkWell(
      onTap: () async {
        await localizationService.setLocale(context, locale);
        setState(() {}); // Refresh to show selected state
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? Colors.blue.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color:
                isSelected ? Colors.blue : Colors.grey.withValues(alpha: 0.3),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Text(
              flag,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: 12),
            Text(
              name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            const Spacer(),
            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Colors.blue,
              ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _tokenController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.goOffAll(AppRoute.home),
        ),
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Language Selection Card
            ModernCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Row(
                    children: [
                      Icon(Icons.language, color: Colors.blue),
                      SizedBox(width: 12),
                      Text(
                        'Dil / Language',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildLanguageOption(
                    context,
                    locale: const Locale('tr'),
                    flag: '🇹🇷',
                    name: 'Türkçe',
                  ),
                  const SizedBox(height: 8),
                  _buildLanguageOption(
                    context,
                    locale: const Locale('en'),
                    flag: '🇬🇧',
                    name: 'English',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Keyboard Shortcuts Section (Desktop only)
            if (!Platform.isAndroid && !Platform.isIOS) ...[
              const KeyboardShortcutsSettings(),
              const SizedBox(height: 24),
            ],

            // Status Card
            ModernCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        _hasToken ? Icons.check_circle : Icons.warning,
                        color: _hasToken ? Colors.green : Colors.orange,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        _hasToken ? 'Credentials Configured' : 'No Credentials',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  if (_hasToken && _maskedToken != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      'Token: $_maskedToken',
                      style: TextStyle(
                        color: AppColors.grey1,
                        fontFamily: 'monospace',
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Messages
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
                    const Icon(Icons.error, color: Colors.red),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              ),

            if (_successMessage != null)
              Container(
                padding: const EdgeInsets.all(12),
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(color: Colors.green.withValues(alpha: 0.3)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _successMessage!,
                        style: const TextStyle(color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),

            // Login Section
            ModernCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Login to OpenSubtitles',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ModernInput(
                    controller: _usernameController,
                    labelText: 'Username',
                    hintText: 'Enter your username',
                    readOnly: _isLoading,
                  ),
                  const SizedBox(height: 12),
                  ModernInput(
                    controller: _passwordController,
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    obscureText: true,
                    readOnly: _isLoading,
                  ),
                  const SizedBox(height: 16),
                  ModernButton(
                    text: 'Login',
                    onPressed: _isLoading ? null : _login,
                    isLoading: _isLoading,
                    isFullWidth: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Manual Token Section
            ModernCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Or Enter Token Manually',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Get your token from OpenSubtitles.com',
                    style: TextStyle(
                      color: AppColors.grey1,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ModernInput(
                    controller: _tokenController,
                    labelText: 'Authentication Token',
                    hintText: 'Paste your token here',
                    readOnly: _isLoading,
                  ),
                  const SizedBox(height: 16),
                  ModernButton(
                    text: 'Save Token',
                    onPressed: _isLoading ? null : _saveToken,
                    isLoading: _isLoading,
                    isFullWidth: true,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Actions
            if (_hasToken) ...[
              Row(
                children: [
                  Expanded(
                    child: ModernButton(
                      text: 'Test Connection',
                      onPressed: _isLoading ? null : _testConnection,
                      isLoading: _isLoading,
                      isPrimary: false,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _isLoading ? null : _clearToken,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: const Text('Clear Credentials'),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
