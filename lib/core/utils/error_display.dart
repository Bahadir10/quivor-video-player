import 'package:flutter/material.dart';
import 'package:quivor/core/service/error/error_handler.dart';

/// Utility class for displaying errors to users
/// Note: This shows user-friendly messages on screen
/// Detailed error logs are still saved via errorHandler.handleError()
class ErrorDisplay {
  /// Show error message as a SnackBar
  /// In debug mode: Shows detailed error
  /// In release mode: Shows user-friendly message
  static void showError(BuildContext context, dynamic error) {
    final message = errorHandler.getUserFriendlyMessage(error);

    if (!context.mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red.shade700,
        duration: const Duration(seconds: 4),
        action: SnackBarAction(
          label: 'Tamam',
          textColor: Colors.white,
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ),
    );
  }

  /// Show error message as a Dialog
  static Future<void> showErrorDialog(
    BuildContext context,
    dynamic error, {
    String? title,
  }) async {
    final message = errorHandler.getUserFriendlyMessage(error);

    if (!context.mounted) return;

    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title ?? 'Hata'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Tamam'),
          ),
        ],
      ),
    );
  }
}
