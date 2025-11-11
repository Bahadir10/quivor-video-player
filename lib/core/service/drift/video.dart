import 'package:drift/drift.dart';
import 'package:nexor/nexor.dart';
import 'package:quivor/core/models/entities/video.dart';
import 'package:quivor/core/service/interface/video.dart';
import 'package:quivor/core/service/error/error_handler.dart';

import 'database.dart';

/// Drift implementation of IVideoService
class DriftVideoService extends IVideoService {
  final AppDatabase _db;

  DriftVideoService(this._db);

  @override
  Future<VideoEntity> createVideo({
    required String name,
    required String path,
    int? playlistId,
  }) async {
    final id = await _db.into(_db.videos).insert(
          VideosCompanion.insert(
            name: name,
            path: path,
            playlistId: Value(playlistId),
          ),
        );
    return VideoEntity(
      id: id,
      name: name,
      path: path,
      playlistId: playlistId,
    );
  }

  @override
  Future<List<VideoEntity>> videos() async {
    final results = await _db.select(_db.videos).get();
    return results.map(_toVideoEntity).toList();
  }

  @override
  FV updateVideo(VideoEntity entity) async {
    try {
      await _db.update(_db.videos).replace(
            VideosCompanion(
              id: Value(entity.id),
              name: Value(entity.name),
              path: Value(entity.path),
              isWatched: Value(entity.isWatched),
              categoryId: Value(entity.categoryId),
              playlistId: Value(entity.playlistId),
              lastPositionSecond: Value(entity.lastPositionSecond),
            ),
          );
    } catch (e, stackTrace) {
      errorHandler.handleError('DriftVideoService updateVideo', e, stackTrace);
    }
  }

  @override
  Future removeVideo(int id) async {
    await (_db.delete(_db.videos)..where((tbl) => tbl.id.equals(id))).go();
  }

  @override
  Future<VideoEntity?> getVideoByPathOrNull(String path) async {
    final result = await (_db.select(_db.videos)
          ..where((tbl) => tbl.path.equals(path)))
        .getSingleOrNull();
    return result != null ? _toVideoEntity(result) : null;
  }

  @override
  Future<List<VideoEntity>> playlistVideos(int playlistId) async {
    final results = await (_db.select(_db.videos)
          ..where((tbl) => tbl.playlistId.equals(playlistId)))
        .get();
    return results.map(_toVideoEntity).toList();
  }

  @override
  Future<List<VideoEntity>> searchVideo(String input) async {
    final results = await (_db.select(_db.videos)
          ..where((tbl) => tbl.name.lower().like('%${input.toLowerCase()}%')))
        .get();
    return results.map(_toVideoEntity).toList();
  }

  @override
  Future<List<VideoEntity>> recentVideos() async {
    // Join recents with videos to get recent video entities
    final query = _db.select(_db.recents).join([
      innerJoin(_db.videos, _db.videos.id.equalsExp(_db.recents.videoId)),
    ]);

    final results = await query.get();
    return results.map((row) {
      final video = row.readTable(_db.videos);
      return _toVideoEntity(video);
    }).toList();
  }

  @override
  Future createRecent(VideoEntity entity) async {
    await _db.into(_db.recents).insert(
          RecentsCompanion.insert(
            videoId: entity.id,
          ),
        );
  }

  /// Helper method to convert Drift Video to VideoEntity
  VideoEntity _toVideoEntity(Video video) {
    return VideoEntity(
      id: video.id,
      name: video.name,
      path: video.path,
      isWatched: video.isWatched,
      categoryId: video.categoryId,
      playlistId: video.playlistId,
      lastPositionSecond: video.lastPositionSecond,
    );
  }
}
