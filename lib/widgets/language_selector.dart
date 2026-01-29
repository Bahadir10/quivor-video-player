import 'package:flutter/material.dart';
import 'package:app_materials/app_materials.dart';
import 'package:quivor/core/localization/localization_service.dart';

class LanguageSelector extends StatelessWidget {
  const LanguageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final currentLocale = localizationService.getCurrentLocale(context);

    return PopupMenuButton<Locale>(
      icon: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.language,
            color: AppColors.black1,
            size: 20,
          ),
          const SizedBox(width: 4),
          Text(
            _getLanguageFlag(currentLocale),
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
      tooltip: 'Change Language',
      onSelected: (Locale locale) async {
        await localizationService.setLocale(context, locale);
      },
      itemBuilder: (BuildContext context) {
        return localizationService.getSupportedLocales().map((Locale locale) {
          final isSelected = currentLocale.languageCode == locale.languageCode;
          return PopupMenuItem<Locale>(
            value: locale,
            child: Row(
              children: [
                Text(
                  _getLanguageFlag(locale),
                  style: const TextStyle(fontSize: 20),
                ),
                const SizedBox(width: 12),
                Text(
                  _getLanguageName(locale),
                  style: TextStyle(
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? AppColors.black1 : null,
                  ),
                ),
                if (isSelected) ...[
                  const Spacer(),
                  Icon(
                    Icons.check,
                    color: AppColors.black1,
                    size: 20,
                  ),
                ],
              ],
            ),
          );
        }).toList();
      },
    );
  }

  String _getLanguageFlag(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return '🇬🇧';
      case 'tr':
        return '🇹🇷';
      default:
        return '🌐';
    }
  }

  String _getLanguageName(Locale locale) {
    switch (locale.languageCode) {
      case 'en':
        return 'English';
      case 'tr':
        return 'Türkçe';
      default:
        return locale.languageCode.toUpperCase();
    }
  }
}
