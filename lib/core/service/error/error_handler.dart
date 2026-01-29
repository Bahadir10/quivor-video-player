import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:quivor/core/service/logger/logger_service.dart';

class ErrorHandler {
  static final ErrorHandler _instance = ErrorHandler._internal();
  factory ErrorHandler() => _instance;
  ErrorHandler._internal();

  void init() {
    // Catch Flutter framework errors
    FlutterError.onError = (FlutterErrorDetails details) {
      logger.error(
        'Flutter Error',
        details.exception,
        details.stack,
      );

      // In debug mode, show the error
      if (kDebugMode) {
        FlutterError.presentError(details);
      }
    };

    // Catch async errors
    PlatformDispatcher.instance.onError = (error, stack) {
      logger.error('Async Error', error, stack);
      return true;
    };
  }

  // Handle specific errors with custom messages
  void handleError(
    String context,
    dynamic error, [
    StackTrace? stackTrace,
  ]) {
    logger.error('Error in $context', error, stackTrace);
  }

  // Get user-friendly error message for UI display
  // Note: Logs remain detailed, this is only for user-facing messages
  String getUserFriendlyMessage(dynamic error) {
    // In debug mode, show detailed error on screen
    if (kDebugMode) {
      return 'DEBUG: ${error.toString()}';
    }

    // In release mode, show user-friendly messages on screen
    if (error is TimeoutException) {
      return 'İşlem zaman aşımına uğradı. Lütfen tekrar deneyin.';
    } else if (error is FormatException) {
      return 'Veri formatı hatalı.';
    } else if (error.toString().contains('SocketException')) {
      return 'İnternet bağlantısı yok.';
    } else if (error.toString().contains('HttpException')) {
      return 'Sunucu hatası. Lütfen daha sonra tekrar deneyin.';
    } else if (error.toString().contains('SqliteException') ||
        error.toString().contains('DriftRemoteException')) {
      return 'Veritabanı hatası oluştu. Lütfen uygulamayı yeniden başlatın.';
    } else {
      return 'Bir şeyler ters gitti. Lütfen tekrar deneyin.';
    }
  }
}

// Global error handler instance
final errorHandler = ErrorHandler();
