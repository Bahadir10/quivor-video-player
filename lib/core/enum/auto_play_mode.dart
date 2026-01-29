import 'package:quivor/core/localization/localization_service.dart';
import 'package:quivor/core/localization/locale_keys.dart';

enum AutoPlayMode {
  manual, // Video bitince durur, manuel geçiş
  onComplete, // Video bitince otomatik sonraki bölüme geç
  early, // Son X saniyede buton göster ve otomatik geç
  autoTransition, // Son X saniyede otomatik geçiş (buton yok)
}

extension AutoPlayModeExtension on AutoPlayMode {
  String get displayName {
    switch (this) {
      case AutoPlayMode.manual:
        return LocaleKeys.autoplay_manual.tr();
      case AutoPlayMode.onComplete:
        return LocaleKeys.autoplay_on_complete.tr();
      case AutoPlayMode.early:
        return LocaleKeys.autoplay_early.tr();
      case AutoPlayMode.autoTransition:
        return LocaleKeys.autoplay_auto_transition.tr();
    }
  }

  String get description {
    switch (this) {
      case AutoPlayMode.manual:
        return LocaleKeys.autoplay_manual_desc.tr();
      case AutoPlayMode.onComplete:
        return LocaleKeys.autoplay_on_complete_desc.tr();
      case AutoPlayMode.early:
        return LocaleKeys.autoplay_early_desc.tr();
      case AutoPlayMode.autoTransition:
        return LocaleKeys.autoplay_auto_transition_desc.tr();
    }
  }
}
