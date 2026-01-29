import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:quivor/core/localization/localization_service.dart';

/// Implementation of ILocalizationService using easy_localization package
class EasyLocalizationService implements ILocalizationService {
  @override
  String translate(String key, {Map<String, String>? namedArgs}) {
    return easy.tr(key, namedArgs: namedArgs);
  }

  @override
  String plural(String key, int count) {
    return easy.plural(key, count);
  }

  @override
  Locale getCurrentLocale(BuildContext context) {
    return context.locale;
  }

  @override
  Future<void> setLocale(BuildContext context, Locale locale) async {
    await context.setLocale(locale);
  }

  @override
  List<Locale> getSupportedLocales() {
    return const [
      Locale('en'),
      Locale('tr'),
    ];
  }

  @override
  bool isLocaleSupported(Locale locale) {
    return getSupportedLocales()
        .any((l) => l.languageCode == locale.languageCode);
  }
}
