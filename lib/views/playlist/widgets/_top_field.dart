part of '../playlist.dart';

class _TopField extends StatelessWidget {
  final double percentage;
  final int watchedCount;
  final List<VideoEntity> videos;
  final PlaylistStateResponseModel playlist;
  const _TopField(
      {super.key,
      required this.percentage,
      required this.watchedCount,
      required this.videos,
      required this.playlist});

  @override
  Widget build(BuildContext context) {
    final cubit = context.cubit<_ScreenCubit>();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              padding: EdgeInsets.zero,
              icon: AppIcons.menu,
              onPressed: () => cubit.toggleSideBar(context),
            ),
            Spacers.medium.horizontal,
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 15,
                  width: 200,
                  child: LinearProgressIndicator(
                    color: AppColors.blue1,
                    //color: Color(0xFF1E3E62),
                    //backgroundColor: Color(0xFF6A9AB0),
                    backgroundColor: AppColors.white1,
                    borderRadius: Cutter.small.all,
                    value: percentage / 100,
                  ),
                ),
                Spacers.medium.horizontal,
                Text(
                  '$watchedCount/${videos.length}',
                  style: AppTypography.bodyMedium,
                ),
                Spacers.small.horizontal,
                Text(
                  '% ${percentage.toStringAsFixed(2)}',
                  style: AppTypography.bodyMedium,
                )
              ],
            ),
          ],
        ),
        CustomTextButton(
          text: Strings.continueT(),
          onPressed: () {
            if (videos.isEmpty) {
              return;
            }
            context.go(AppRoute.player,
                data: PlayScreenParameters(
                    paths: videos, mainPath: playlist.name));
          },
        )
      ],
    );
  }
}
