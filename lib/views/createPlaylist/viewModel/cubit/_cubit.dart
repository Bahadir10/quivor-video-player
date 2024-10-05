part of '../../create_playlist.dart';

final class _ScreenCubit extends Cubit<_ScreenState> {
  final BuildContext context;
  _ScreenCubit(this.context) : super(_ScreenState());
  String playlistName = '';
  List<String> _paths = [];
  TextEditingController playlistNameController = TextEditingController();
  FV createEmptyPlaylist() async {
    if (playlistName.isEmpty) {
      return;
    }
    final playlists = await getIt<IPlaylistService>().getPlaylists();
    final flag = playlists.any(
      (x) => x.name == playlistName,
    );

    if (flag) {
    } else {
      emit(state.copyWith(isLoading: true));
      final x = await getIt<IPlaylistService>().createPlaylist(playlistName);
      context.go(AppRoute.playlist,
          data: PlaylistScreenParameters(
            playlist: PlaylistStateResponseModel(
                id: x.id,
                name: x.name,
                length: 0,
                watchedCount: 0,
                progressPercentage: 0),
          ));
    }
  }

  void updatePlaylistName(String name) {
    playlistName = name;
  }

  FV openPath() async {
    List<String> names = [];
    final result = await getIt<IFileManager>().getVideoPaths();

    if (result.isNotNull) {
      if (result!.videoPaths.isEmpty) {
        return;
      }
      //File filex = File(result.mainDirectory);
      playlistNameController.text = p.basename(result.mainDirectory);
      for (final x in result.videoPaths) {
        File file = File(x);
        names.add(p.basename(file.path));
        _paths.add(x);
      }
      emit(state.copyWith(playlistItems: names));
    }
  }

  void makeChoise() {
    emit(state.copyWith(choise: true));
  }

  FV createPlaylistFromPath() async {
    final x = await getIt<IPlaylistService>()
        .createPlaylist(playlistNameController.text);

    List<VideoEntity> entities = [];
    for (final item in state.playlistItems!) {
      final y = await getIt<IVideoService>().createVideo(
          name: p.basename(item),
          path: _paths[state.playlistItems!.indexOf(item)],
          playlistId: x.id);
      entities.add(y);
    }
    context.go(AppRoute.playlist,
        data: PlaylistScreenParameters(
          playlist: PlaylistStateResponseModel(
              id: x.id,
              name: x.name,
              length: entities.length,
              watchedCount: 0,
              progressPercentage: 0),
        ));
  }
}
