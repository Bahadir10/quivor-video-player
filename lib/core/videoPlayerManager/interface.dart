import 'package:nexor/nexor.dart';
import 'package:quivor/core/models/entities/video.dart';
import 'package:quivor/core/videoPlayerManager/implementation.dart';

abstract class IVideoPlayerManager {
  const IVideoPlayerManager();
  FV setRate(double value);
  FV dispose();
  FV next();
  FV previous();
  FV jump(int index);
  FV open(List<VideoEntity> videos);
  FV seekForward();
  FV seekBackward();
  FV seek(int seconds);
  FV playOrPause();
  FV setVolume(double value);
  FV setShuffle(bool value);
  FV play();
  FV pause();
  FV setAudioTrack(String trackId);
  FV setSubtitleTrack(String trackId);
  FV loadExternalSubtitle(String subtitlePath);

  Duration get duration;
  Duration get position;
  dynamic get controller;
  bool get isPlaying;
  double get volume;
  List<Map<String, String>> get audioTracks;
  List<Map<String, String>> get subtitleTracks;
  String get currentAudioTrack;
  String get currentSubtitleTrack;

  Stream<bool> get isCompleted;
  Stream<Duration> get state;
  Stream<void> get tracksStream;

  final double playSpeedVerySlow = 0.25;
  final double playSpeedSlow = 0.50;
  final double playSpeedMedium = 1.0;
  final double playSpeedFast = 1.5;
  final double playSpeedVeryFast = 2.0;

  final int moveValue = 10;
  factory IVideoPlayerManager.scoped() => VideoPlayerManager();
}
