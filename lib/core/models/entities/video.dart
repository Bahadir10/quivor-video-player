// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';

part 'video.g.dart';

@collection
final class VideoEntity {
  final Id id;
  final String name;
  final String path;
  final bool isWatched;
  final int? categoryId;

  final int? playlistId;

  final int lastPositionSecond;
  const VideoEntity({
    this.id = Isar.autoIncrement,
    required this.name,
    required this.path,
    this.isWatched = false,
    this.categoryId,
    this.playlistId,
    this.lastPositionSecond = 0,
  }); // : this.id = id ?? Isar.autoIncrement;

  VideoEntity copyWith({
    int? id,
    String? name,
    String? path,
    bool? isWatched,
    int? categoryId,
    int? playlistId,
    int? lastPositionSecond,
  }) {
    return VideoEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      path: path ?? this.path,
      isWatched: isWatched ?? this.isWatched,
      categoryId: categoryId ?? this.categoryId,
      playlistId: playlistId ?? this.playlistId,
      lastPositionSecond: lastPositionSecond ?? this.lastPositionSecond,
    );
  }

  @override
  String toString() {
    return 'VideoEntity(name: $name, path: $path, isWatched: $isWatched, categoryId: $categoryId, playlistId: $playlistId, lastPositionSecond: $lastPositionSecond)';
  }
}
