import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:nexor/nexor.dart';
import 'package:quivor/core/models/entities/video.dart';
import 'package:quivor/core/videoPlayerManager/interface.dart';
import 'package:quivor/core/service/logger/logger_service.dart';
import 'package:quivor/core/service/error/error_handler.dart';

class VideoPlayerManager extends IVideoPlayerManager {
  late final Player _player = Player();

  late final VideoController _controller = VideoController(
    _player,
  );

  int _seekDuration = 10; // Default 10 seconds

  @override
  FV dispose() async {
    await _player.dispose();
  }

  @override
  FV jump(int index) async {
    await _player.jump(index);
  }

  @override
  FV next() async {
    await _player.next();
  }

  @override
  Duration get position => _player.state.position;

  @override
  FV previous() async {
    await _player.previous();
  }

  @override
  FV setRate(double value) async {
    await _player.setRate(value);
  }

  @override
  FV open(List<VideoEntity> videos) async {
    try {
      logger.info('Opening playlist with ${videos.length} videos');
      final playable = Playlist(
        videos.map((x) => Media(x.path)).toList(),
        // Disable auto-play next video - we handle this manually
        index: 0,
      );
      await _player.open(playable);

      // Set playlist mode to none to completely disable auto-advance
      await _player.setPlaylistMode(PlaylistMode.none);

      _player.setSubtitleTrack(SubtitleTrack.no());
      logger.info(
          'Playlist opened successfully with none mode (no auto-advance)');
    } catch (e, stackTrace) {
      errorHandler.handleError('VideoPlayerManager open', e, stackTrace);
      rethrow;
    }
  }

  @override
  FV seek(int seconds) async {
    await _player.seek(Duration(seconds: seconds));
  }

  @override
  FV seekBackward() async {
    final x = _player.state.position.inSeconds - _seekDuration;
    await _player
        .seek(Duration(seconds: x.clamp(0, _player.state.duration.inSeconds)));
  }

  @override
  FV seekForward() async {
    final x = _player.state.position.inSeconds + _seekDuration;
    await _player
        .seek(Duration(seconds: x.clamp(0, _player.state.duration.inSeconds)));
  }

  @override
  VideoController get controller => _controller;

  @override
  FV playOrPause() async {
    await _player.playOrPause();
  }

  @override
  bool get isPlaying => _player.state.playing;

  @override
  double get volume => _player.state.volume;

  @override
  FV setVolume(double value) async {
    await _player.setVolume(value);
  }

  @override
  FV setShuffle(bool value) async {
    await _player.setShuffle(value);
  }

  @override
  FV pause() async {
    await _player.pause();
  }

  @override
  FV play() async {
    await _player.play();
  }

  @override
  Stream<bool> get isCompleted => _player.stream.completed;

  @override
  Stream<Duration> get state => _player.stream.duration;

  @override
  Stream<void> get tracksStream => _player.stream.tracks;

  @override
  List<Map<String, String>> get audioTracks {
    final res = _player.state.tracks.audio.map((track) {
      return {
        'id': track.id,
        'title': track.title ?? '',
        'language': track.language ?? '',
      };
    }).toList();
    return res;
  }

  @override
  List<Map<String, String>> get subtitleTracks {
    final tracks = <Map<String, String>>[];
    tracks.addAll(_player.state.tracks.subtitle.map((track) {
      return {
        'id': track.id,
        'title': track.title ?? '',
        'language': track.language ?? '',
      };
    }).toList());
    return tracks;
  }

  @override
  String get currentAudioTrack => _player.state.track.audio.id;

  @override
  String get currentSubtitleTrack => _player.state.track.subtitle.id;

  @override
  FV setAudioTrack(String trackId) async {
    final track = _player.state.tracks.audio.firstWhere(
      (t) => t.id == trackId,
      orElse: () => _player.state.tracks.audio.first,
    );
    await _player.setAudioTrack(track);
  }

  @override
  FV setSubtitleTrack(String trackId) async {
    if (trackId == 'no') {
      await _player.setSubtitleTrack(SubtitleTrack.no());
    } else {
      final track = _player.state.tracks.subtitle.firstWhere(
        (t) => t.id == trackId,
        orElse: () => SubtitleTrack.no(),
      );
      await _player.setSubtitleTrack(track);
    }
  }

  @override
  FV loadExternalSubtitle(String subtitlePath) async {
    try {
      logger.info('Loading external subtitle: $subtitlePath');
      await _player.setSubtitleTrack(
        SubtitleTrack.uri(subtitlePath),
      );
      logger.info('External subtitle loaded successfully');
    } catch (e, stackTrace) {
      errorHandler.handleError(
          'VideoPlayerManager loadExternalSubtitle', e, stackTrace);
      rethrow;
    }
  }

  @override
  FV setSubtitleOffset(double offsetSeconds) async {
    try {
      logger.info('Setting subtitle offset: ${offsetSeconds}s');
      // media_kit doesn't have built-in subtitle delay support
      // This is a placeholder - subtitle offset will be stored in database
      // and can be used for custom subtitle rendering in the future
      logger.warning(
          'Subtitle offset feature requires custom subtitle rendering implementation');
    } catch (e, stackTrace) {
      errorHandler.handleError(
          'VideoPlayerManager setSubtitleOffset', e, stackTrace);
      rethrow;
    }
  }

  @override
  FV toggleFullscreen() async {
    // Fullscreen is typically handled by the UI layer
    // This is a placeholder for platform-specific implementations
    logger.info('Fullscreen toggle requested - handle in UI layer');
  }

  @override
  FV setSeekDuration(int seconds) async {
    _seekDuration = seconds;
    logger.info('Seek duration set to: ${seconds}s');
  }

  @override
  Duration get duration => _player.state.duration;
}
