part of '../../home.dart';

final class _ScreenCubit extends BaseCubit<HomeScreenState> {
  final BuildContext context;
  _ScreenCubit(this.context) : super(HomeScreenState());

  List<PlaylistStateResponseModel> playlists = [];

  @override
  FV init() async {
    final playlists = await getIt<IPlaylistService>().getPlaylistStates();
    this.playlists = playlists;

    safeEmit(state.copyWith(
      playlists: playlists,
      isLoading: false,
    ));
  }

  FV search(String input) async {
    if (input.isEmpty) {
      safeEmit(state.copyWith(playlists: playlists, isLoading: false));
      return;
    }
    safeEmit(state.copyWith(isLoading: true));
    final searchedPlaylists = playlists
        .where((x) => x.name.toLowerCase().contains(input.toLowerCase()))
        .toList();
    safeEmit(state.copyWith(playlists: searchedPlaylists, isLoading: false));
  }

  FV openFile() async {
    final x = await getIt<IFileManager>().getVideoFile();

    if (x != null) {
      VideoEntity? vid = await getIt<IVideoService>().getVideoByPathOrNull(x);
      if (vid.isNotNull) {
      } else {
        vid = await getIt<IVideoService>()
            .createVideo(name: p.basename(x), path: x);
      }
      context.go(AppRoute.player, data: PlayScreenParameters(paths: [vid!]));
    }
  }

  FV goPlaylistScreen(PlaylistStateResponseModel playlist) async {
    context.go(AppRoute.playlist,
        data: PlaylistScreenParameters(
          playlist: playlist,
        ));
  }

  FV playRecentVideo(VideoEntity entity) async {
    context.go(AppRoute.player, data: PlayScreenParameters(paths: [entity]));
  }

  FV removePlaylist(int id) async {
    await getIt<IPlaylistService>().removePlaylist(id);
    playlists.removeWhere((e) => e.id == id);
    safeEmit(state.copyWith(playlists: playlists));
  }

  FV playPlaylist(PlaylistStateResponseModel playlist) async {
    // Get all videos for this playlist
    final videos = await getIt<IVideoService>().playlistVideos(playlist.id);

    if (videos.isEmpty) return;

    // Find first unwatched video or start from beginning
    final startIndex = videos.indexWhere((v) => !v.isWatched);

    context.go(
      AppRoute.player,
      data: PlayScreenParameters(
        paths: videos,
        mainPath: playlist.name,
        startIndex: startIndex >= 0 ? startIndex : 0,
        playlistId: playlist.id,
      ),
    );
  }
}
