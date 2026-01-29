// ignore_for_file: public_member_api_docs, sort_constructors_first

final class VideoEntity {
  final int id;
  final String name;
  final String path;
  final bool isWatched;
  final int? categoryId;

  final int? playlistId;

  final int lastPositionSecond;

  /// List of downloaded subtitle file paths for this video
  final List<String> downloadedSubtitles;

  /// Last selected subtitle path (null if no subtitle or disabled)
  final String? lastSelectedSubtitle;

  /// Subtitle synchronization offset in seconds (can be negative)
  final double subtitleOffset;

  const VideoEntity({
    this.id = 0,
    required this.name,
    required this.path,
    this.isWatched = false,
    this.categoryId,
    this.playlistId,
    this.lastPositionSecond = 0,
    this.downloadedSubtitles = const [],
    this.lastSelectedSubtitle,
    this.subtitleOffset = 0.0,
  }); // : this.id = id ?? Isar.autoIncrement;

  VideoEntity copyWith({
    int? id,
    String? name,
    String? path,
    bool? isWatched,
    int? categoryId,
    int? playlistId,
    int? lastPositionSecond,
    List<String>? downloadedSubtitles,
    String? lastSelectedSubtitle,
    double? subtitleOffset,
  }) {
    return VideoEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      path: path ?? this.path,
      isWatched: isWatched ?? this.isWatched,
      categoryId: categoryId ?? this.categoryId,
      playlistId: playlistId ?? this.playlistId,
      lastPositionSecond: lastPositionSecond ?? this.lastPositionSecond,
      downloadedSubtitles: downloadedSubtitles ?? this.downloadedSubtitles,
      lastSelectedSubtitle: lastSelectedSubtitle ?? this.lastSelectedSubtitle,
      subtitleOffset: subtitleOffset ?? this.subtitleOffset,
    );
  }

  @override
  String toString() {
    return 'VideoEntity(name: $name, path: $path, isWatched: $isWatched, categoryId: $categoryId, playlistId: $playlistId, lastPositionSecond: $lastPositionSecond, downloadedSubtitles: $downloadedSubtitles, lastSelectedSubtitle: $lastSelectedSubtitle, subtitleOffset: $subtitleOffset)';
  }
}
