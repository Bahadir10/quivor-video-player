// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../../home.dart';

final class _ScreenState {
  final List<VideoEntity>? recents;
  final List<PlaylistStateResponseModel>? playlists;
  final bool isLoading;
  const _ScreenState({
    this.recents,
    this.playlists,
    this.isLoading = true,
  });

  _ScreenState copyWith({
    List<VideoEntity>? recents,
    List<PlaylistStateResponseModel>? playlists,
    bool? isLoading,
  }) {
    return _ScreenState(
      recents: recents ?? this.recents,
      playlists: playlists ?? this.playlists,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
