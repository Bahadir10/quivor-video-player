part of '../../play.dart';

final class _ScreenCubit extends BaseCubit<PlayScreenState> {
  final IVideoPlayerManager player;
  final int? startIndex;
  final int? playlistId;
  _ScreenCubit(
      List<VideoEntity> vids, this.player, this.startIndex, this.playlistId)
      : super(PlayScreenState(videos: List.from(vids))) {
    logger.info(
        'PlayScreen initialized with ${vids.length} videos, playlistId: $playlistId');
  }

  late VideoEntity _currentEntity;
  int _index = 0;

  late final PositionMonitoringService _positionMonitor;
  StreamSubscription? _positionSubscription;

  // Helper to get current videos list
  List<VideoEntity> get vids => state.videos;

  @override
  FV init() async {
    _positionMonitor = PositionMonitoringService(player: player);

    if (startIndex.isNotNull) {
      _currentEntity = vids[startIndex!];
    } else {
      _currentEntity = vids.firstWhereOrNull(
            (e) => !e.isWatched,
          ) ??
          vids.first;
    }
    final userPrefs = await UserDataManager().userPrefrences;

    // Load playlist-specific settings if available
    AutoPlayMode autoPlayMode = userPrefs.autoPlayMode;
    int earlyTransitionSeconds = userPrefs.earlyTransitionSeconds;
    int? introSkipSeconds;

    if (playlistId != null) {
      final playlists = await getIt<IPlaylistService>().getPlaylists();
      final playlist = playlists.firstWhereOrNull((p) => p.id == playlistId);

      if (playlist != null) {
        // Use playlist-specific settings if available
        if (playlist.autoPlayMode != null) {
          autoPlayMode = AutoPlayMode.values.firstWhere(
            (mode) => mode.name == playlist.autoPlayMode,
            orElse: () => userPrefs.autoPlayMode,
          );
        }
        if (playlist.earlyTransitionSeconds != null) {
          earlyTransitionSeconds = playlist.earlyTransitionSeconds!;
        }
        introSkipSeconds = playlist.introSkipSeconds;
        logger.info(
            'Loaded playlist settings: mode=$autoPlayMode, seconds=$earlyTransitionSeconds, introSkip=$introSkipSeconds');
      }
    }

    emit(state.copyWith(
      canPlayNext: vids.last.id != _currentEntity.id,
      canPlayPrevious: vids.first.id == _currentEntity.id,
      currentPlaying: _currentEntity,
      volume: userPrefs.volume,
      isPlaying: true,
      autoPlayMode: autoPlayMode,
      earlyTransitionSeconds: earlyTransitionSeconds,
      seekDurationSeconds: userPrefs.seekDurationSeconds,
    ));

    final jumpIndex = vids.indexWhere(
      (e) => e.id == _currentEntity.id,
    );
    final jump = jumpIndex >= vids.length ? vids.length : jumpIndex;
    _index = jump;
    await player.open(vids);

    await player.jump(jump);

    // Set seek duration from user preferences
    await player.setSeekDuration(userPrefs.seekDurationSeconds);

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

    // Save position every 15 seconds without blocking UI
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
      (event) {
        _currentEntity = event;

        // Fire and forget - don't await to avoid blocking
        getIt<IVideoService>().updateVideo(_currentEntity).catchError((e) {
          logger.error('Failed to update video position', e);
        });
      },
    );

    player.state.first.then((event) async {
      // Check if video is being played for the first time (never watched before)
      // AND has a saved position less than 2 seconds (to avoid skipping when user manually seeks to start)
      if (!_currentEntity.isWatched &&
          _currentEntity.lastPositionSecond <= 2 &&
          introSkipSeconds != null &&
          introSkipSeconds > 0) {
        // First time playing this video - skip intro
        logger.info(
            'First time playing video (not watched), skipping intro: $introSkipSeconds seconds');
        await player.seek(introSkipSeconds);
      } else if (_currentEntity.lastPositionSecond > 0) {
        // Resume from last position
        await player.seek(_currentEntity.lastPositionSecond);
      }

      // Load last selected subtitle if exists
      if (_currentEntity.lastSelectedSubtitle != null) {
        final subtitlePath = _currentEntity.lastSelectedSubtitle!;
        if (File(subtitlePath).existsSync()) {
          logger.info('Loading last selected subtitle: $subtitlePath');
          await player.loadExternalSubtitle(subtitlePath);

          // Apply saved subtitle offset
          if (_currentEntity.subtitleOffset != 0.0) {
            logger.info(
                'Applying subtitle offset: ${_currentEntity.subtitleOffset}s');
            await player.setSubtitleOffset(_currentEntity.subtitleOffset);
          }
        } else {
          logger.warning('Last selected subtitle not found: $subtitlePath');
        }
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

  FV markAsWatchedAndPlayNext() async {
    try {
      logger.info('Marking current video as watched and playing next');

      // Mark current video as watched
      await toggleWatch(_currentEntity);

      // Play next video
      await playNext();
    } catch (e, stackTrace) {
      errorHandler.handleError(
          'PlayScreen markAsWatchedAndPlayNext', e, stackTrace);
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

    // Load last selected subtitle for the new video
    if (_currentEntity.lastSelectedSubtitle != null) {
      final subtitlePath = _currentEntity.lastSelectedSubtitle!;
      if (File(subtitlePath).existsSync()) {
        logger.info(
            'Loading last selected subtitle for new video: $subtitlePath');
        await player.loadExternalSubtitle(subtitlePath);

        // Apply saved subtitle offset
        if (_currentEntity.subtitleOffset != 0.0) {
          logger.info(
              'Applying subtitle offset: ${_currentEntity.subtitleOffset}s');
          await player.setSubtitleOffset(_currentEntity.subtitleOffset);
        }
      } else {
        logger.warning('Last selected subtitle not found: $subtitlePath');
      }
    }

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

      if (index < 0) {
        logger.error('Video not found in list: ${video.name}');
        return;
      }

      final updatedVideo = video.copyWith(isWatched: true);

      // Create new list with updated video
      final updatedVids = List<VideoEntity>.from(vids);
      updatedVids[index] = updatedVideo;

      // Update state with new list
      emit(state.copyWith(videos: updatedVids));

      // Update in database
      await getIt<IVideoService>().updateVideo(updatedVideo);

      // Update current entity if it's the same video
      if (_currentEntity.id == video.id) {
        _currentEntity = updatedVideo;
      }
    } catch (e, stackTrace) {
      errorHandler.handleError('PlayScreen toggleWatch', e, stackTrace);
      rethrow;
    }
  }

  FV playIndex(int index) async {
    // Validate index
    if (index < 0 || index >= vids.length) {
      logger.error('Invalid index: $index, videos length: ${vids.length}');
      return;
    }

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

  void toggleFullscreen() {
    // Toggle fullscreen using player manager
    player.toggleFullscreen();
  }

  FV setAudioTrack(String trackId) async {
    await player.setAudioTrack(trackId);
  }

  FV setSubtitleTrack(String trackId) async {
    // Check if it's a downloaded subtitle (file path)
    if (trackId.contains(path.separator) && File(trackId).existsSync()) {
      await player.loadExternalSubtitle(trackId);

      // Save as last selected subtitle
      final updatedVideo = _currentEntity.copyWith(
        lastSelectedSubtitle: trackId,
      );
      _currentEntity = updatedVideo;
      await getIt<IVideoService>().updateVideo(updatedVideo);
    } else {
      await player.setSubtitleTrack(trackId);

      // Save 'no' or track id as last selected
      final updatedVideo = _currentEntity.copyWith(
        lastSelectedSubtitle: trackId == 'no' ? null : trackId,
      );
      _currentEntity = updatedVideo;
      await getIt<IVideoService>().updateVideo(updatedVideo);
    }
  }

  FV loadLocalSubtitle(VideoEntity video) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['srt', 'vtt', 'ass', 'ssa', 'sub'],
      );

      if (result != null && result.files.first.path != null) {
        final subtitlePath = result.files.first.path!;
        logger.info('Loading local subtitle: $subtitlePath');

        // Load into player
        await player.loadExternalSubtitle(subtitlePath);

        // Add to downloaded subtitles list if not already there
        final updatedSubtitles = List<String>.from(video.downloadedSubtitles);
        if (!updatedSubtitles.contains(subtitlePath)) {
          updatedSubtitles.add(subtitlePath);
        }

        // Update video with new subtitle and set as last selected
        final updatedVideo = video.copyWith(
          downloadedSubtitles: updatedSubtitles,
          lastSelectedSubtitle: subtitlePath,
        );

        _currentEntity = updatedVideo;
        await getIt<IVideoService>().updateVideo(updatedVideo);

        logger.info('Local subtitle loaded and saved successfully');
      }
    } catch (e, stackTrace) {
      errorHandler.handleError('PlayScreen loadLocalSubtitle', e, stackTrace);
      rethrow;
    }
  }

  void _startPositionMonitoring() {
    _positionSubscription?.cancel();
    _positionMonitor.stop();

    logger.info(
        'Starting position monitoring for mode: ${state.autoPlayMode.name}');
    _positionMonitor.start();

    _positionSubscription = _positionMonitor.positionStream.listen(
      (event) {
        // Skip if we don't have valid duration yet
        if (!event.hasValidDuration) {
          return;
        }

        // Only log every 5 seconds to avoid spam
        if (event.remainingSeconds % 5 == 0) {
          logger.debug(
              'Position: ${event.position.inSeconds}s / ${event.duration.inSeconds}s, remaining: ${event.remainingSeconds}s, mode: ${state.autoPlayMode.name}');
        }

        // Manual mode - pause video when it ends to prevent auto-advance
        if (state.autoPlayMode == AutoPlayMode.manual) {
          if (event.remainingSeconds <= 2 && player.isPlaying) {
            logger.info(
                'Video ending in manual mode - pausing to prevent auto-advance');
            player.pause();
            // Mark video as watched when it ends in manual mode
            if (event.remainingSeconds <= 1) {
              toggleWatch(_currentEntity);
            }
          }
          return;
        }

        // Early transition mode - show button at specified seconds
        if (state.autoPlayMode == AutoPlayMode.early) {
          if (event.remainingSeconds <= state.earlyTransitionSeconds &&
              event.remainingSeconds > 0 &&
              state.canPlayNext &&
              !state.showNextEpisode) {
            logger.info(
                'Showing next episode button (early mode), remaining: ${event.remainingSeconds}s');
            emit(state.copyWith(showNextEpisode: true));
          } else if (event.remainingSeconds > state.earlyTransitionSeconds &&
              state.showNextEpisode) {
            emit(state.copyWith(showNextEpisode: false));
          }
        }

        // Auto transition mode - automatically transition at specified seconds
        if (state.autoPlayMode == AutoPlayMode.autoTransition) {
          if (event.remainingSeconds <= state.earlyTransitionSeconds &&
              event.remainingSeconds > 0 &&
              state.canPlayNext &&
              !state.hasAutoTransitioned) {
            logger.info(
                'Auto transitioning to next video, remaining: ${event.remainingSeconds}s');
            emit(state.copyWith(hasAutoTransitioned: true));

            // Schedule async work without blocking
            _handleAutoTransition();
          }
        }

        // On complete mode - auto play when video ends
        if (state.autoPlayMode == AutoPlayMode.onComplete) {
          if (event.remainingSeconds <= 1 &&
              state.canPlayNext &&
              !state.hasAutoTransitioned) {
            logger.info('Video completed, playing next');
            emit(state.copyWith(hasAutoTransitioned: true));
            // Schedule async work without blocking
            _handleAutoTransition();
          }
        }
      },
      onError: (e, stackTrace) {
        logger.error('Error in position monitoring', e, stackTrace);
      },
    );
  }

  @override
  Future<void> close() async {
    _positionSubscription?.cancel();
    _positionMonitor.dispose();
    return super.close();
  }

  void hideNextEpisode() {
    emit(state.copyWith(showNextEpisode: false));
  }

  Future<void> _handleAutoTransition() async {
    try {
      await toggleWatch(_currentEntity);
      await playNext();
    } catch (e, stackTrace) {
      logger.error('Error in auto transition', e, stackTrace);
    }
  }

  void setAutoPlayMode(AutoPlayMode mode) async {
    logger.info('Auto play mode changed to: ${mode.displayName}');
    emit(state.copyWith(autoPlayMode: mode));

    // Save to playlist if we're in a playlist
    if (playlistId != null) {
      final playlists = await getIt<IPlaylistService>().getPlaylists();
      final playlist = playlists.firstWhereOrNull((p) => p.id == playlistId);

      if (playlist != null) {
        final updatedPlaylist = playlist.copyWith(
          autoPlayMode: mode.name,
        );
        await getIt<IPlaylistService>().updatePlaylist(updatedPlaylist);
        logger.info('Saved autoPlayMode to playlist: ${mode.name}');
      }
    } else {
      // Save to global settings if not in a playlist
      await UserDataManager().setAutoPlayMode(mode.name);
    }

    // Restart monitoring based on new mode
    _startPositionMonitoring();
  }

  void setEarlyTransitionSeconds(int seconds) async {
    emit(state.copyWith(earlyTransitionSeconds: seconds));

    // Save to playlist if we're in a playlist
    if (playlistId != null) {
      final playlists = await getIt<IPlaylistService>().getPlaylists();
      final playlist = playlists.firstWhereOrNull((p) => p.id == playlistId);

      if (playlist != null) {
        final updatedPlaylist = playlist.copyWith(
          earlyTransitionSeconds: seconds,
        );
        await getIt<IPlaylistService>().updatePlaylist(updatedPlaylist);
        logger.info('Saved earlyTransitionSeconds to playlist: $seconds');
      }
    } else {
      // Save to global settings if not in a playlist
      await UserDataManager().setEarlyTransitionSeconds(seconds);
    }
  }

  List<Map<String, String>> get audioTracks => player.audioTracks;

  List<Map<String, String>> get subtitleTracks {
    final tracks = player.subtitleTracks;

    // Add downloaded subtitles to the list
    if (_currentEntity.downloadedSubtitles.isNotEmpty) {
      for (final subtitlePath in _currentEntity.downloadedSubtitles) {
        final fileName = path.basename(subtitlePath);
        tracks.add({
          'id': subtitlePath,
          'title': fileName,
          'language': 'Downloaded',
        });
      }
    }

    return tracks;
  }

  FV adjustSubtitleOffset(double offsetChange) async {
    try {
      final newOffset = _currentEntity.subtitleOffset + offsetChange;
      logger.info(
          'Adjusting subtitle offset: ${_currentEntity.subtitleOffset}s -> ${newOffset}s');

      await player.setSubtitleOffset(newOffset);

      // Save to database
      final updatedVideo = _currentEntity.copyWith(
        subtitleOffset: newOffset,
      );
      _currentEntity = updatedVideo;
      await getIt<IVideoService>().updateVideo(updatedVideo);

      logger.info('Subtitle offset saved: ${newOffset}s');
    } catch (e, stackTrace) {
      errorHandler.handleError(
          'PlayScreen adjustSubtitleOffset', e, stackTrace);
      rethrow;
    }
  }

  FV resetSubtitleOffset() async {
    try {
      logger.info('Resetting subtitle offset to 0');

      await player.setSubtitleOffset(0.0);

      // Save to database
      final updatedVideo = _currentEntity.copyWith(
        subtitleOffset: 0.0,
      );
      _currentEntity = updatedVideo;
      await getIt<IVideoService>().updateVideo(updatedVideo);

      logger.info('Subtitle offset reset');
    } catch (e, stackTrace) {
      errorHandler.handleError('PlayScreen resetSubtitleOffset', e, stackTrace);
      rethrow;
    }
  }

  double get currentSubtitleOffset => _currentEntity.subtitleOffset;

  FV setSeekDuration(int seconds) async {
    try {
      logger.info('Setting seek duration: ${seconds}s');
      await player.setSeekDuration(seconds);
      await UserDataManager().setSeekDurationSeconds(seconds);
      emit(state.copyWith(seekDurationSeconds: seconds));
    } catch (e, stackTrace) {
      errorHandler.handleError('PlayScreen setSeekDuration', e, stackTrace);
      rethrow;
    }
  }

  // Video Notes Methods
  void toggleNotes() {
    emit(state.copyWith(showNotes: !state.showNotes));
  }

  Future<List<VideoNoteEntity>> getNotesForCurrentVideo() async {
    try {
      return await getIt<IVideoNoteService>()
          .getNotesForVideo(_currentEntity.id);
    } catch (e, stackTrace) {
      errorHandler.handleError(
          'PlayScreen getNotesForCurrentVideo', e, stackTrace);
      return [];
    }
  }

  FV addNote(String noteText) async {
    try {
      final timestamp = player.position.inSeconds;
      logger.info('Adding note at $timestamp seconds: $noteText');

      await getIt<IVideoNoteService>().createNote(
        videoId: _currentEntity.id,
        timestampSeconds: timestamp,
        noteText: noteText,
      );

      logger.info('Note added successfully');
    } catch (e, stackTrace) {
      errorHandler.handleError('PlayScreen addNote', e, stackTrace);
      rethrow;
    }
  }

  FV deleteNote(int noteId) async {
    try {
      await getIt<IVideoNoteService>().deleteNote(noteId);
      logger.info('Note $noteId deleted');
    } catch (e, stackTrace) {
      errorHandler.handleError('PlayScreen deleteNote', e, stackTrace);
      rethrow;
    }
  }

  FV seekToNote(int timestampSeconds) async {
    try {
      await player.seek(timestampSeconds);
      logger.info('Seeked to note timestamp: $timestampSeconds');
    } catch (e, stackTrace) {
      errorHandler.handleError('PlayScreen seekToNote', e, stackTrace);
      rethrow;
    }
  }
}
