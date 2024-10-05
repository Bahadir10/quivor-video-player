import 'package:flutter/widgets.dart';
import 'package:media_kit_video/media_kit_video.dart';
import 'package:quivor/core/videoPlayerManager/interface.dart';

class AppVideoPlayer extends StatelessWidget {
  final IVideoPlayerManager videoPlayerManager;
  const AppVideoPlayer({super.key, required this.videoPlayerManager});

  @override
  Widget build(BuildContext context) {
    return Video(
      controller: videoPlayerManager.controller,
    );
  }
}
