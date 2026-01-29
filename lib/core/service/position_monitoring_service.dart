import 'dart:async';
import 'package:quivor/core/videoPlayerManager/interface.dart';

class PositionEvent {
  final Duration position;
  final Duration duration;
  final int remainingSeconds;

  PositionEvent({
    required this.position,
    required this.duration,
    required this.remainingSeconds,
  });

  bool get hasValidDuration => duration.inSeconds > 0;
}

class PositionMonitoringService {
  final IVideoPlayerManager player;
  final Duration monitoringInterval;

  StreamSubscription? _subscription;
  final _controller = StreamController<PositionEvent>.broadcast();

  PositionMonitoringService({
    required this.player,
    this.monitoringInterval = const Duration(seconds: 5),
  });

  Stream<PositionEvent> get positionStream => _controller.stream;

  void start() {
    stop(); // Cancel any existing subscription

    _subscription = Stream.periodic(monitoringInterval).listen((_) {
      try {
        final position = player.position;
        final duration = player.duration;

        final remaining = duration.inSeconds - position.inSeconds;

        final event = PositionEvent(
          position: position,
          duration: duration,
          remainingSeconds: remaining,
        );

        _controller.add(event);
      } catch (e) {
        _controller.addError(e);
      }
    });
  }

  void stop() {
    _subscription?.cancel();
    _subscription = null;
  }

  void dispose() {
    stop();
    _controller.close();
  }
}
