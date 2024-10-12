part of '../../playlist.dart';

final class _ScreenCubit extends BaseCubit<_ScreenState> {
  final PlaylistStateResponseModel playlist;
  _ScreenCubit({required this.playlist})
      : super(_ScreenState(
          playlist: playlist,
        ));
  late final List<VideoEntity> videos;

  @override
  FV init() async {
    videos = await getIt<IVideoService>().playlistVideos(playlist.id);
    emit(state.copyWith(isLoading: false, videos: videos));
  }

  FV handleWatchState(VideoEntity entity) async {
    final index = videos.indexOf(entity);
    final x = entity.copyWith(isWatched: !entity.isWatched);
    await getIt<IVideoService>().updateVideo(x);
    videos.removeAt(index);
    videos.insert(index, x);
    emit(state.copyWith(videos: videos));
  }

  FV search(String input) async {
    if (input.isEmpty) {
      emit(state.copyWith(videos: videos));
      return;
    }

    emit(state.copyWith(
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
    videos.remove(entity);
    await getIt<IVideoService>().removeVideo(entity.id);
    emit(state.copyWith(videos: videos));
  }
}
