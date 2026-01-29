final class VideoNoteEntity {
  final int id;
  final int videoId;
  final int timestampSeconds;
  final String noteText;
  final DateTime createdAt;

  const VideoNoteEntity({
    this.id = 0,
    required this.videoId,
    required this.timestampSeconds,
    required this.noteText,
    required this.createdAt,
  });

  VideoNoteEntity copyWith({
    int? id,
    int? videoId,
    int? timestampSeconds,
    String? noteText,
    DateTime? createdAt,
  }) {
    return VideoNoteEntity(
      id: id ?? this.id,
      videoId: videoId ?? this.videoId,
      timestampSeconds: timestampSeconds ?? this.timestampSeconds,
      noteText: noteText ?? this.noteText,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  String get formattedTimestamp {
    final hours = timestampSeconds ~/ 3600;
    final minutes = (timestampSeconds % 3600) ~/ 60;
    final seconds = timestampSeconds % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
    }
  }

  @override
  String toString() {
    return 'VideoNoteEntity(id: $id, videoId: $videoId, timestamp: $timestampSeconds, note: $noteText, createdAt: $createdAt)';
  }
}
