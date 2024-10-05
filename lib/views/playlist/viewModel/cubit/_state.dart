// ignore_for_file: public_member_api_docs, sort_constructors_first

part of '../../playlist.dart';

final class _ScreenState {
  final List<VideoEntity>? videos;
  final PlaylistStateResponseModel playlist;
  final bool isSideBarOpen;
  final bool isLoading;
  _ScreenState({
    this.videos,
    required this.playlist,
    this.isSideBarOpen = false,
    this.isLoading = true,
  });

  _ScreenState copyWith({
    List<VideoEntity>? videos,
    PlaylistStateResponseModel? playlist,
    bool? isSideBarOpen,
    bool? isLoading,
  }) {
    return _ScreenState(
      videos: videos ?? this.videos,
      playlist: playlist ?? this.playlist,
      isSideBarOpen: isSideBarOpen ?? this.isSideBarOpen,
      isLoading: isLoading ?? this.isLoading,
    );
  }
}
