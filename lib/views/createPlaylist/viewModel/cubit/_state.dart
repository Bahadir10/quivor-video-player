part of '../../create_playlist.dart';

@freezed
class CreatePlaylistScreenState with _$CreatePlaylistScreenState {
  factory CreatePlaylistScreenState({
    @Default(false) bool isLoading,
    @Default(false) bool choise,
    List<String>? playlistItems,
    @Default(false) bool isSideBarOpen,
  }) = _$CreatePlaylistScreenStateImpl;
}
