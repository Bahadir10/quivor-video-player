import 'package:quivor/core/models/entities/playlist.dart';
import 'package:quivor/core/service/responseModel/playlist_progress.dart';
import 'package:quivor/core/service/responseModel/playlist_state.dart';

abstract class IPlaylistService {
  Future<Playlist> createPlaylist(String name);
  Future<List<Playlist>> getPlaylists();
  Future<List<Playlist>> searchPlaylists(String input);
  Future<PlaylistProgressResponseModel> getPlaylistState(int id);
  Future<List<PlaylistStateResponseModel>> getPlaylistStates();
}
