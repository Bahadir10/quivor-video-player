part of '../../play.dart';

@freezed
class PlayScreenState with _$PlayScreenState {
  factory PlayScreenState({
    required List<VideoEntity> videos,
    @Default(true) bool isLoading,
    @Default(false) bool canPlayNext,
    @Default(false) bool canPlayPrevious,
    VideoEntity? currentPlaying,
    @Default(80) double volume,
    @Default(false) bool isPlaying,
    @Default(false) bool isSideBarOpen,
    @Default(false) bool showNextEpisode,
    @Default(AutoPlayMode.early) AutoPlayMode autoPlayMode,
    @Default(15) int earlyTransitionSeconds,
    @Default(false) bool hasAutoTransitioned,
  }) = _$PlayScreenStateImpl;
}
