// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../../create_playlist.dart';

final class _ScreenState {
  final bool isLoading;
  final bool choise;
  final List<String>? playlistItems;
  final bool isSideBarOpen;
  const _ScreenState({
    this.isLoading = false,
    this.choise = false,
    this.playlistItems,
    this.isSideBarOpen = false,
  });

  _ScreenState copyWith({
    bool? isLoading,
    bool? choise,
    List<String>? playlistItems,
    bool? isSideBarOpen,
  }) {
    return _ScreenState(
      isLoading: isLoading ?? this.isLoading,
      choise: choise ?? this.choise,
      playlistItems: playlistItems ?? this.playlistItems,
      isSideBarOpen: isSideBarOpen ?? this.isSideBarOpen,
    );
  }
}
