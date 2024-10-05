// ignore_for_file: public_member_api_docs, sort_constructors_first
part of '../../play.dart';

final class _ScreenState {
  final List<VideoEntity> videos;
  final bool isLoading;
  final bool canPlayNext;
  final bool canPlayPrevious;
  final VideoEntity? currentPlaying;
  final double volume;
  final bool isPlaying;
  final bool isSideBarOpen;
  const _ScreenState({
    this.canPlayNext = false,
    this.canPlayPrevious = false,
    required this.videos,
    this.isLoading = true,
    this.currentPlaying,
    this.volume = 80,
    this.isPlaying = false,
    this.isSideBarOpen = false,
  });

  _ScreenState copyWith({
    List<VideoEntity>? videos,
    bool? isLoading,
    bool? canPlayNext,
    bool? canPlayPrevious,
    VideoEntity? currentPlaying,
    double? volume,
    bool? isPlaying,
    bool? isSideBarOpen,
  }) {
    return _ScreenState(
      currentPlaying: currentPlaying ?? this.currentPlaying,
      videos: videos ?? this.videos,
      isLoading: isLoading ?? this.isLoading,
      canPlayNext: canPlayNext ?? this.canPlayNext,
      canPlayPrevious: canPlayPrevious ?? this.canPlayPrevious,
      volume: volume ?? this.volume,
      isPlaying: isPlaying ?? this.isPlaying,
      isSideBarOpen: isSideBarOpen ?? this.isSideBarOpen,
    );
  }
}
