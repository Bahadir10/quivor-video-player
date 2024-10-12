import 'package:isar/isar.dart';

import 'package:quivor/core/models/entities/playlist.dart';
import 'package:quivor/core/models/entities/video.dart';
import 'package:quivor/core/service/interface/playlist.dart';
import 'package:quivor/core/service/responseModel/playlist_progress.dart';
import 'package:quivor/core/service/responseModel/playlist_state.dart';
import 'package:quivor/intialize.dart';

final class IsarPlaylistService extends IPlaylistService {
  @override
  Future<Playlist> createPlaylist(String name) async {
    var x = Playlist(name: name);
    await isar.writeTxn(() async {
      final id = await isar.playlists.put(x);
      x = Playlist(name: name, id: id);
    });
    return x;
  }

  @override
  Future<List<Playlist>> getPlaylists() async {
    return await isar.playlists.where().findAll();
  }

  @override
  Future<List<Playlist>> searchPlaylists(String input) async {
    return await isar.playlists
        .filter()
        .nameContains(input, caseSensitive: false)
        .findAll();
  }

  @override
  Future<PlaylistProgressResponseModel> getPlaylistState(int id) async {
    final length =
        await isar.videoEntitys.filter().playlistIdEqualTo(id).count();

    final int wathcedCount = await isar.videoEntitys
        .filter()
        .playlistIdEqualTo(id)
        .and()
        .isWatchedEqualTo(true)
        .count();
    final p = wathcedCount / length * 100;
    final percentage = p.isNaN ? 0.0 : p;
    return PlaylistProgressResponseModel(
        progressPercentage: percentage,
        watchedCount: wathcedCount,
        length: length);
  }

  @override
  Future<List<PlaylistStateResponseModel>> getPlaylistStates() async {
    final playlists = await isar.playlists.where().findAll();
    final videos =
        await isar.videoEntitys.filter().playlistIdIsNotNull().findAll();
    return playlists.map<PlaylistStateResponseModel>(
      (e) {
        final pVideos = videos
            .where(
              (x) => x.playlistId == e.id,
            )
            .toList();
        final int watchedCount = pVideos
            .where(
              (x) => x.isWatched,
            )
            .toList()
            .length;
        final length = pVideos.length;
        final p = watchedCount / length * 100;
        final percentage = p.isNaN ? 0.0 : p;
        return PlaylistStateResponseModel(
            id: e.id,
            watchedCount: watchedCount,
            length: length,
            name: e.name,
            progressPercentage: percentage);
      },
    ).toList();
  }

  @override
  Future removePlaylist(int id) async {
    await isar.writeTxn(() async {
      await isar.playlists.delete(id);
      await isar.videoEntitys.filter().playlistIdEqualTo(id).deleteAll();
    });
  }
}
