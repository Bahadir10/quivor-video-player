part of '../../play.dart';

final class _ScreenCubit extends BaseCubit<_ScreenState> {
  final List<VideoEntity> vids;
  final IVideoPlayerManager player;
  final int? startIndex;
  _ScreenCubit(this.vids, this.player, this.startIndex)
      : super(_ScreenState(videos: vids));

  late VideoEntity _currentEntity;
  int _index = 0;

  @override
  FV init() async {
    if (startIndex.isNotNull) {
      _currentEntity = vids[startIndex!];
    } else {
      _currentEntity = vids.lastWhereOrNull(
            (e) => e.isWatched,
          ) ??
          vids.first;
    }
    final volume = (await UserDataManager().userPrefrences).volume;
    emit(state.copyWith(
      canPlayNext: vids.last.id != _currentEntity.id,
      canPlayPrevious: vids.first.id == _currentEntity.id,
      currentPlaying: _currentEntity,
      volume: volume,
      isPlaying: true,
    ));

    final jumpIndex = vids.indexWhere(
      (e) => e.id == _currentEntity.id,
    );
    final jump = jumpIndex >= vids.length ? vids.length : jumpIndex;
    await player.open(vids);

    await player.jump(jump);
    await player.seek(_currentEntity.lastPositionSecond);

    await player.setVolume(volume);
    await getIt<RecentVideosCubit>().update(vids.first);

    // player.stream.completed.listen(
    //   (event) async {
    //     if (event) {
    //       await toggleWatch(_currentEntity);
    //       await playNext();
    //     }
    //   },
    // );

    final x = Stream<VideoEntity>.periodic(
      const Duration(seconds: 30),
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
        vids.remove(i);
        vids.insert(i, _currentEntity);
        _currentEntity = event;
        await getIt<IVideoService>().updateVideo(_currentEntity);
      },
    );

    await getIt<RecentVideosCubit>().update(_currentEntity);
  }

  FV playNext() async {
    _index++;
    await player.next();
    await _checkChange();
  }

  FV playPrevious() async {
    _index--;
    await player.previous();
    await _checkChange();
  }

  FV _checkChange() async {
    _currentEntity = vids[_index];
    emit(state.copyWith(
      canPlayNext: vids.last != _currentEntity,
      canPlayPrevious: vids.first != _currentEntity,
      currentPlaying: _currentEntity,
    ));
    await getIt<RecentVideosCubit>().update(_currentEntity);
  }

  FV setPlayRate(double? value) async {
    if (value != null) await player.setRate(value);
  }

  FV toggleWatch(VideoEntity video) async {
    final index = vids.indexWhere(
      (e) => e.id == video.id,
    );
    final x = video.copyWith(isWatched: true);
    await getIt<IVideoService>().updateVideo(x);
    vids.removeAt(index);
    vids.insert(index, x);
    emit(state.copyWith(videos: vids));
    await getIt<IVideoService>().updateVideo(x);
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
}
