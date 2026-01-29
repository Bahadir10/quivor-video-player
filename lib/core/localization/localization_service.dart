import 'package:flutter/material.dart';

/// Abstract localization service
/// This allows us to switch localization packages easily in the future
abstract class ILocalizationService {
  /// Translate a key
  String translate(String key, {Map<String, String>? namedArgs});

  /// Translate with plural
  String plural(String key, int count);

  /// Get current locale
  Locale getCurrentLocale(BuildContext context);

  /// Set locale
  Future<void> setLocale(BuildContext context, Locale locale);

  /// Get supported locales
  List<Locale> getSupportedLocales();

  /// Check if locale is supported
  bool isLocaleSupported(Locale locale);
}

/// Extension for easy access
extension LocalizationExtension on String {
  /// Translate this string key
  String tr({Map<String, String>? namedArgs}) {
    return _localizationService.translate(this, namedArgs: namedArgs);
  }

  /// Translate with plural
  String plural(int count) {
    return _localizationService.plural(this, count);
  }
}

/// Global localization service instance
late ILocalizationService _localizationService;

/// Initialize localization service
void initLocalizationService(ILocalizationService service) {
  _localizationService = service;
}

/// Get localization service
ILocalizationService get localizationService => _localizationService;
