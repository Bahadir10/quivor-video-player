part of '../../playlist.dart';

@freezed
class PlaylistScreenState with _$PlaylistScreenState {
  factory PlaylistScreenState({
    List<VideoEntity>? videos,
    required PlaylistStateResponseModel playlist,
    @Default(false) bool isSideBarOpen,
    @Default(true) bool isLoading,
  }) = _$PlaylistScreenStateImpl;
}
