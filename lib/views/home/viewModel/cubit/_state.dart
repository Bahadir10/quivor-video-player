part of '../../home.dart';

@freezed
class HomeScreenState with _$HomeScreenState {
  factory HomeScreenState({
    List<VideoEntity>? recents,
    List<PlaylistStateResponseModel>? playlists,
    @Default(true) bool isLoading,
  }) = _$HomeScreenStateImpl;
}
