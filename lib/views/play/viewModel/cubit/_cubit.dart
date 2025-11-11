part of '../../play.dart';

final class _ScreenCubit extends BaseCubit<PlayScreenState> {
  final List<VideoEntity> vids;
  final IVideoPlayerManager player;
  final int? startIndex;
  _ScreenCubit(this.vids, this.player, this.startIndex)
      : super(PlayScreenState(videos: vids)) {
    logger.info('PlayScreen initialized with ${vids.length} videos');
  }

  late VideoEntity _currentEntity;
  int _index = 0;

  StreamSubscription? _positionSubscription;

  @override
  FV init() async {
    if (startIndex.isNotNull) {
      _currentEntity = vids[startIndex!];
    } else {
      _currentEntity = vids.firstWhereOrNull(
            (e) => !e.isWatched,
          ) ??
          vids.first;
    }
    final userPrefs = await UserDataManager().userPrefrences;

    emit(state.copyWith(
      canPlayNext: vids.last.id != _currentEntity.id,
      canPlayPrevious: vids.first.id == _currentEntity.id,
      currentPlaying: _currentEntity,
      volume: userPrefs.volume,
      isPlaying: true,
      autoPlayMode: userPrefs.autoPlayMode,
      earlyTransitionSeconds: userPrefs.earlyTransitionSeconds,
    ));

    final jumpIndex = vids.indexWhere(
      (e) => e.id == _currentEntity.id,
    );
    final jump = jumpIndex >= vids.length ? vids.length : jumpIndex;
    _index = jump;
    await player.open(vids);

    await player.jump(jump);

    // Wait for video to be ready before seeking
    // await Future.delayed(const Duration(milliseconds: 500));

    await player.setVolume(userPrefs.volume);
    // player.isCompleted.listen(
    //   (event) async {
    //     if (event) {
    //       await toggleWatch(_currentEntity);
    //       await playNext();
    //     }
    //   },
    // );

    final x = Stream<VideoEntity>.periodic(
      const Duration(seconds: 15),
      (computationCount) {
        final dur = player.position;
        return _currentEntity.copyWith(
          lastPositionSecond: dur.inSeconds,
        );
      },
    );

    x.listen(
      (event) async {
        final i = vids.indexWhere(
          (e) => e.id == event.id,
        );
        _currentEntity = event;
        vids.removeAt(i);
        vids.insert(i, _currentEntity);
        await getIt<IVideoService>().updateVideo(_currentEntity);
      },
    );

    player.state.first.then((event) async {
      if (_currentEntity.lastPositionSecond > 0) {
        await player.seek(_currentEntity.lastPositionSecond);
      }
      _startPositionMonitoring();
    });

    await getIt<RecentVideosCubit>().update(_currentEntity);
  }

  FV playNext() async {
    try {
      _index++;
      logger.debug('Playing next video: index $_index');
      await player.jump(_index);
      await _checkChange();
    } catch (e, stackTrace) {
      errorHandler.handleError('PlayScreen playNext', e, stackTrace);
      rethrow;
    }
  }

  FV playPrevious() async {
    _index--;
    await player.jump(_index);
    await _checkChange();
  }

  FV _checkChange() async {
    _currentEntity = vids[_index];
    emit(state.copyWith(
      canPlayNext: vids.last != _currentEntity,
      canPlayPrevious: vids.first != _currentEntity,
      currentPlaying: _currentEntity,
      hasAutoTransitioned: false, // Reset flag for new video
    ));
    await getIt<RecentVideosCubit>().update(_currentEntity);
  }

  FV setPlayRate(double? value) async {
    if (value != null) await player.setRate(value);
  }

  FV toggleWatch(VideoEntity video) async {
    try {
      logger.info('Marking video as watched: ${video.name}');
      final index = vids.indexWhere(
        (e) => e.id == video.id,
      );
      final x = video.copyWith(isWatched: true);
      await getIt<IVideoService>().updateVideo(x);
      vids.removeAt(index);
      vids.insert(index, x);
      emit(state.copyWith(videos: vids));
      await getIt<IVideoService>().updateVideo(x);
    } catch (e, stackTrace) {
      errorHandler.handleError('PlayScreen toggleWatch', e, stackTrace);
      rethrow;
    }
  }

  FV playIndex(int index) async {
    _index = index;
    await player.jump(index);
    _currentEntity = vids[_index];
    emit(state.copyWith(
      canPlayNext: vids.last != _currentEntity,
      canPlayPrevious: vids.first != _currentEntity,
      currentPlaying: _currentEntity,
    ));
  }

  FV setVolume(double volume) async {
    await player.setVolume(volume);
    await UserDataManager().setVolume(volume);
    emit(state.copyWith(volume: volume));
  }

  FV playOrPause() async {
    if (player.isPlaying) {
      await player.pause();
    } else {
      await player.play();
    }
    emit(state.copyWith(isPlaying: !player.isPlaying));
  }

  void toggleSideBar(BuildContext context) {
    if (context.width > 800) {
      emit(state.copyWith(isSideBarOpen: !state.isSideBarOpen));
    } else {
      Scaffold.of(context).openDrawer();
    }
  }

  FV setAudioTrack(String trackId) async {
    await player.setAudioTrack(trackId);
  }

  FV setSubtitleTrack(String trackId) async {
    await player.setSubtitleTrack(trackId);
  }

  void _startPositionMonitoring() {
    _positionSubscription?.cancel();

    _positionSubscription = Stream.periodic(
      const Duration(seconds: 5),
    ).listen((_) async {
      try {
        final position = player.position;
        final duration = player.duration;

        // Skip if we don't have valid duration yet
        if (duration.inSeconds == 0) {
          return;
        }

        final remaining = duration.inSeconds - position.inSeconds;

        // Only log every 5 seconds to avoid spam
        if (remaining % 5 == 0) {
          logger.debug(
              'Position: ${position.inSeconds}s / ${duration.inSeconds}s, remaining: ${remaining}s, mode: ${state.autoPlayMode.name}');
        }

        // Early transition mode - show button at specified seconds
        if (state.autoPlayMode == AutoPlayMode.early) {
          if (remaining <= state.earlyTransitionSeconds &&
              remaining > 0 &&
              state.canPlayNext &&
              !state.showNextEpisode) {
            logger.info(
                'Showing next episode button (early mode), remaining: ${remaining}s');
            emit(state.copyWith(showNextEpisode: true));
          } else if (remaining > state.earlyTransitionSeconds &&
              state.showNextEpisode) {
            emit(state.copyWith(showNextEpisode: false));
          }
        }

        // Auto transition mode - automatically transition at specified seconds
        if (state.autoPlayMode == AutoPlayMode.autoTransition) {
          if (remaining <= state.earlyTransitionSeconds &&
              remaining > 0 &&
              state.canPlayNext &&
              !state.hasAutoTransitioned) {
            logger.info(
                'Auto transitioning to next video, remaining: ${remaining}s');
            emit(state.copyWith(hasAutoTransitioned: true));
            await toggleWatch(_currentEntity);
            await playNext();
          }
        }

        // On complete mode - auto play when video ends
        if (state.autoPlayMode == AutoPlayMode.onComplete) {
          if (remaining <= 1 && state.canPlayNext) {
            logger.info('Video completed, playing next');
            await playNext();
          }
        }
      } catch (e, stackTrace) {
        logger.error('Error in position monitoring', e, stackTrace);
      }
    });
  }

  @override
  Future<void> close() {
    _positionSubscription?.cancel();
    return super.close();
  }

  void hideNextEpisode() {
    emit(state.copyWith(showNextEpisode: false));
  }

  void setAutoPlayMode(AutoPlayMode mode) async {
    logger.info('Auto play mode changed to: ${mode.displayName}');
    emit(state.copyWith(autoPlayMode: mode));
    await UserDataManager().setAutoPlayMode(mode.name);
  }

  void setEarlyTransitionSeconds(int seconds) async {
    emit(state.copyWith(earlyTransitionSeconds: seconds));
    await UserDataManager().setEarlyTransitionSeconds(seconds);
  }

  List<Map<String, String>> get audioTracks => player.audioTracks;
  List<Map<String, String>> get subtitleTracks => player.subtitleTracks;
}
