part of '../home.dart';

class _PlaylistField extends StatelessWidget {
  final List<PlaylistStateResponseModel> playlists;

  const _PlaylistField({
    super.key,
    required this.playlists,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.cubit<_ScreenCubit>();
    return Expanded(
      child: ListView.builder(
        itemCount: playlists.length,
        itemBuilder: (context, index) {
          final playlist = playlists[index];
          return ListTile(
            hoverColor: AppColors.grey2,
            shape: RoundedRectangleBorder(
              borderRadius: Cutter.small.all,
            ),
            onTap: () async => await cubit.goPlaylistScreen(playlist),
            contentPadding: Paddings.medium.horizontal,
            title: Text(
              playlist.name,
              style: AppTypography.bodyMedium,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                playlist.progressPercentage == 100
                    ? Container(
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: AppColors.white1),
                        child:
                            AppIcons.checked.copyWith(color: AppColors.black1),
                      )
                    : CustomProgressIndicator(
                        percentage: playlist.progressPercentage),
                Spacers.small.horizontal,
                IconButton(
                    onPressed: () async =>
                        await cubit.removePlaylist(playlist.id),
                    icon: AppIcons.delete)
              ],
            ),
          );
        },
        shrinkWrap: true,
      ),
    );
  }
}
