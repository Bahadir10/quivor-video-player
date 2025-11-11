import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:quivor/core/service/logger/logger_service.dart';
import 'package:quivor/core/service/error/error_handler.dart';

class EnvConfigService {
  static final EnvConfigService _instance = EnvConfigService._internal();
  factory EnvConfigService() => _instance;
  EnvConfigService._internal();

  final _secureStorage = const FlutterSecureStorage();
  static const String _authTokenKey = 'opensubtitles_auth_token';

  // Environment variables
  String get apiKey => dotenv.env['OPENSUBTITLES_API_KEY'] ?? '';
  String get userAgent => dotenv.env['OPENSUBTITLES_USER_AGENT'] ?? 'quivor';
  String get baseUrl =>
      dotenv.env['OPENSUBTITLES_BASE_URL'] ??
      'https://api.opensubtitles.com/api/v1';

  /// Initialize the environment configuration
  Future<void> initialize() async {
    try {
      await dotenv.load(fileName: '.env');
      logger.info('Environment configuration loaded successfully');
    } catch (e, stackTrace) {
      logger.warning('Failed to load .env file, using defaults');
      errorHandler.handleError('EnvConfigService initialize', e, stackTrace);
    }
  }

  /// Save authentication token securely
  Future<void> saveAuthToken(String token) async {
    try {
      await _secureStorage.write(key: _authTokenKey, value: token);
      logger.info('Authentication token saved successfully');
    } catch (e, stackTrace) {
      errorHandler.handleError('EnvConfigService saveAuthToken', e, stackTrace);
      rethrow;
    }
  }

  /// Get stored authentication token
  Future<String?> getAuthToken() async {
    try {
      final token = await _secureStorage.read(key: _authTokenKey);
      return token;
    } catch (e, stackTrace) {
      errorHandler.handleError('EnvConfigService getAuthToken', e, stackTrace);
      return null;
    }
  }

  /// Check if authentication token is configured
  Future<bool> hasAuthToken() async {
    final token = await getAuthToken();
    return token != null && token.isNotEmpty;
  }

  /// Clear stored authentication token
  Future<void> clearAuthToken() async {
    try {
      await _secureStorage.delete(key: _authTokenKey);
      logger.info('Authentication token cleared');
    } catch (e, stackTrace) {
      errorHandler.handleError(
          'EnvConfigService clearAuthToken', e, stackTrace);
      rethrow;
    }
  }

  /// Get masked token for display (shows first 10 and last 4 characters)
  Future<String?> getMaskedToken() async {
    final token = await getAuthToken();
    if (token == null || token.isEmpty) return null;

    if (token.length <= 14) {
      return '${token.substring(0, 4)}...';
    }

    return '${token.substring(0, 10)}...${token.substring(token.length - 4)}';
  }
}

final envConfig = EnvConfigService();
