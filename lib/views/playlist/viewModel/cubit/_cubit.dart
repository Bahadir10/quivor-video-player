part of '../../playlist.dart';

final class _ScreenCubit extends BaseCubit<PlaylistScreenState> {
  final PlaylistStateResponseModel playlist;
  _ScreenCubit({required this.playlist})
      : super(PlaylistScreenState(
          playlist: playlist,
        ));
  late final List<VideoEntity> videos;

  @override
  FV init() async {
    videos = await getIt<IVideoService>().playlistVideos(playlist.id);
    emit(state.copyWith(isLoading: false, videos: videos));
  }

  FV handleWatchState(VideoEntity entity) async {
    emit(state.copyWith(isLoading: true));
    final index = videos.indexOf(entity);
    final x = entity.copyWith(isWatched: !entity.isWatched);
    final watch = x.isWatched
        ? state.playlist.watchedCount + 1
        : state.playlist.watchedCount - 1;
    final p = playlist.copyWith(
      watchedCount: watch,
      progressPercentage: Helper.getPercentage(
        max: state.videos!.length.toDouble(),
        progress: watch.toDouble(),
      ),
    );
    await getIt<IVideoService>().updateVideo(x);
    videos.removeAt(index);
    videos.insert(index, x);
    emit(state.copyWith(videos: videos, playlist: p, isLoading: false));
  }

  FV search(String input) async {
    emit(state.copyWith(isLoading: true));
    if (input.isEmpty) {
      emit(state.copyWith(videos: videos, isLoading: false));
      return;
    }

    emit(state.copyWith(
        isLoading: false,
        videos: videos
            .where(
              (e) => e.name.toLowerCase().contains(input.toLowerCase()),
            )
            .toList()));
  }

  void toggleSideBar(BuildContext context) {
    if (context.width > 800) {
      emit(state.copyWith(isSideBarOpen: !state.isSideBarOpen));
    } else {
      Scaffold.of(context).openDrawer();
    }
  }

  FV addVideo() async {
    final x = await getIt<IFileManager>().getVideoFile();

    if (x != null) {
      VideoEntity? vid = videos.firstWhereOrNull(
        (element) => element.path == x,
      );
      if (vid.isNotNull) {
      } else {
        vid = await getIt<IVideoService>()
            .createVideo(name: p.basename(x), path: x, playlistId: playlist.id);
        videos.add(vid);
        emit(state.copyWith(videos: videos));
      }
    }
  }

  FV removeVideo(VideoEntity entity) async {
    emit(state.copyWith(isLoading: true));
    videos.remove(entity);
    await getIt<IVideoService>().removeVideo(entity.id);
    emit(state.copyWith(videos: videos, isLoading: false));
  }

  FV startOver() async {
    emit(state.copyWith(isLoading: true));

    // Mark all videos as unwatched
    for (int i = 0; i < videos.length; i++) {
      final updatedVideo = videos[i].copyWith(isWatched: false);
      await getIt<IVideoService>().updateVideo(updatedVideo);
      videos[i] = updatedVideo;
    }

    // Update playlist progress
    final updatedPlaylist = playlist.copyWith(
      watchedCount: 0,
      progressPercentage: 0.0,
    );

    emit(state.copyWith(
      videos: videos,
      playlist: updatedPlaylist,
      isLoading: false,
    ));
  }
}
