import 'package:drift/drift.dart';
import 'package:quivor/core/models/entities/playlist.dart' as entities;
import 'package:quivor/core/service/interface/playlist.dart';
import 'package:quivor/core/service/responseModel/playlist_progress.dart';
import 'package:quivor/core/service/responseModel/playlist_state.dart';

import 'database.dart';

/// Drift implementation of IPlaylistService
class DriftPlaylistService extends IPlaylistService {
  final AppDatabase _db;

  DriftPlaylistService(this._db);

  @override
  Future<entities.Playlist> createPlaylist(String name) async {
    final id = await _db.into(_db.playlists).insert(
          PlaylistsCompanion.insert(
            name: name,
          ),
        );
    return entities.Playlist(
      id: id,
      name: name,
    );
  }

  @override
  Future<List<entities.Playlist>> getPlaylists() async {
    final results = await _db.select(_db.playlists).get();
    return results.map(_toPlaylist).toList();
  }

  @override
  Future<List<entities.Playlist>> searchPlaylists(String input) async {
    final results = await (_db.select(_db.playlists)
          ..where((tbl) => tbl.name.lower().like('%${input.toLowerCase()}%')))
        .get();
    return results.map(_toPlaylist).toList();
  }

  @override
  Future removePlaylist(int id) async {
    await (_db.delete(_db.playlists)..where((tbl) => tbl.id.equals(id))).go();
  }

  @override
  Future<PlaylistProgressResponseModel> getPlaylistState(int id) async {
    // Get all videos for this playlist
    final videos = await (_db.select(_db.videos)
          ..where((tbl) => tbl.playlistId.equals(id)))
        .get();

    final totalCount = videos.length;
    final watchedCount = videos.where((v) => v.isWatched).length;
    final progressPercentage =
        totalCount > 0 ? (watchedCount / totalCount) * 100 : 0.0;

    return PlaylistProgressResponseModel(
      watchedCount: watchedCount,
      length: totalCount,
      progressPercentage: progressPercentage,
    );
  }

  @override
  Future<List<PlaylistStateResponseModel>> getPlaylistStates() async {
    final playlists = await _db.select(_db.playlists).get();
    final states = <PlaylistStateResponseModel>[];

    for (final playlist in playlists) {
      // Get all videos for this playlist
      final videos = await (_db.select(_db.videos)
            ..where((tbl) => tbl.playlistId.equals(playlist.id)))
          .get();

      final totalCount = videos.length;
      final watchedCount = videos.where((v) => v.isWatched).length;
      final progressPercentage =
          totalCount > 0 ? (watchedCount / totalCount) * 100 : 0.0;

      states.add(
        PlaylistStateResponseModel(
          id: playlist.id,
          name: playlist.name,
          watchedCount: watchedCount,
          length: totalCount,
          progressPercentage: progressPercentage,
        ),
      );
    }

    return states;
  }

  /// Helper method to convert Drift Playlist to Playlist entity
  entities.Playlist _toPlaylist(Playlist playlist) {
    return entities.Playlist(
      id: playlist.id,
      name: playlist.name,
    );
  }
}
