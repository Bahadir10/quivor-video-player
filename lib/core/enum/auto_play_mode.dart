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
        return 'Manuel';
      case AutoPlayMode.onComplete:
        return 'Video Bitince';
      case AutoPlayMode.early:
        return 'Erken Geçiş';
      case AutoPlayMode.autoTransition:
        return 'Otomatik Geçiş';
    }
  }

  String get description {
    switch (this) {
      case AutoPlayMode.manual:
        return 'Sonraki bölüme manuel geçiş';
      case AutoPlayMode.onComplete:
        return 'Video bitince otomatik geç';
      case AutoPlayMode.early:
        return 'Son saniyede buton göster';
      case AutoPlayMode.autoTransition:
        return 'Son X saniyede otomatik geç';
    }
  }
}
