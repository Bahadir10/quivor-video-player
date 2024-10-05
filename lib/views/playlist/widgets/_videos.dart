part of '../playlist.dart';

class _VideosField extends StatelessWidget {
  final List<VideoEntity> videos;
  final PlaylistStateResponseModel playlist;
  const _VideosField({super.key, required this.videos, required this.playlist});

  @override
  Widget build(BuildContext context) {
    final cubit = context.cubit<_ScreenCubit>();
    return Expanded(
      child: ListView.builder(
        itemCount: videos.length,
        itemBuilder: (context, index) {
          final VideoEntity video = videos[index];
          return ListTile(
            hoverColor: AppColors.grey2,
            shape: RoundedRectangleBorder(borderRadius: Cutter.small.all),
            contentPadding: EdgeInsets.zero,
            leading: AppCheckbox(
              value: video.isWatched,
              onChanged: (value) async => await cubit.handleWatchState(video),
            ),
            title: Text(
              video.name,
              style: AppTypography.bodyMedium,
            ),
            onTap: () async {
              context.go(AppRoute.player,
                  data: PlayScreenParameters(
                      paths: videos,
                      mainPath: playlist.name,
                      startIndex: index));
            },
          );
        },
      ),
    );
  }
}
