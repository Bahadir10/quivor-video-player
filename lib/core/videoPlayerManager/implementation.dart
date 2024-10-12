import 'package:media_kit/media_kit.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:nexor/nexor.dart';
import 'package:quivor/core/models/entities/video.dart';
import 'package:quivor/core/videoPlayerManager/interface.dart';

class VideoPlayerManager extends IVideoPlayerManager {
  late final Player _player = Player();

  late final VideoController _controller = VideoController(
    _player,
  );

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
    final playable = Playlist(videos.map((x) => Media(x.path)).toList());
    await _player.open(playable);
    _player.stream.track.listen(
      (event) async {
        await _openSubtitle();
      },
    );
  }

  @override
  FV seek(int seconds) async {
    await _player.seek(Duration(seconds: seconds));
  }

  @override
  FV seekBackward() async {
    final x = _player.state.position.inSeconds + moveValue;
    await _player.seek(Duration(seconds: x));
  }

  @override
  FV seekForward() async {
    final x = _player.state.position.inSeconds + moveValue;
    await _player.seek(Duration(seconds: x));
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

  FV _openSubtitle() async {
    final x = _player.state.track.video.title;
    final z = x?.lastIndexOf('.');
    final y = x?.substring(0, z);
    final res = '$y.srt';
    try {
      await _player.setSubtitleTrack(SubtitleTrack.data(res));
    } catch (e) {}
  }
}
