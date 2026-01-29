// ignore_for_file: public_member_api_docs, sort_constructors_first

final class Playlist {
  final int id;
  final String name;

  /// AutoPlay mode for this playlist (null = use global default)
  final String? autoPlayMode;

  /// Early transition seconds for this playlist (null = use global default)
  final int? earlyTransitionSeconds;

  /// Intro skip seconds - automatically skip first N seconds when video is first played (1-120 seconds)
  final int? introSkipSeconds;

  const Playlist({
    this.id = 0,
    required this.name,
    this.autoPlayMode,
    this.earlyTransitionSeconds,
    this.introSkipSeconds,
  });

  Playlist copyWith({
    int? id,
    String? name,
    String? autoPlayMode,
    int? earlyTransitionSeconds,
    int? introSkipSeconds,
  }) {
    return Playlist(
      id: id ?? this.id,
      name: name ?? this.name,
      autoPlayMode: autoPlayMode ?? this.autoPlayMode,
      earlyTransitionSeconds:
          earlyTransitionSeconds ?? this.earlyTransitionSeconds,
      introSkipSeconds: introSkipSeconds ?? this.introSkipSeconds,
    );
  }

  @override
  String toString() {
    return 'Playlist(id: $id, name: $name, autoPlayMode: $autoPlayMode, earlyTransitionSeconds: $earlyTransitionSeconds, introSkipSeconds: $introSkipSeconds)';
  }
}
