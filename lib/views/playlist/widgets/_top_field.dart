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
    return Wrap(
      runAlignment: WrapAlignment.center,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.start,
      children: [
        IconButton(
          padding: EdgeInsets.zero,
          icon: AppIcons.menu,
          onPressed: () => cubit.toggleSideBar(context),
        ),
        Spacers.medium.horizontal,
        Column(
          children: [
            Spacers.low.vertical,
            Text(
              playlist.name,
              style: AppTypography.bodyLarge,
            ),
          ],
        ),
        Spacers.medium.horizontal,
        Column(
          children: [
            Spacers.small.vertical,
            SizedBox(
              height: 15,
              width: 200,
              child: LinearProgressIndicator(
                color: AppColors.blue1,
                backgroundColor: AppColors.white1,
                borderRadius: Cutter.small.all,
                value: percentage / 100,
              ),
            ),
          ],
        ),
        Spacers.medium.horizontal,
        Column(
          children: [
            Spacers.small.vertical,
            Text(
              '$watchedCount/${videos.length}',
              style: AppTypography.bodyMedium,
            ),
          ],
        ),
        Spacers.small.horizontal,
        Column(
          children: [
            Spacers.small.vertical,
            Text(
              '% ${percentage.toStringAsFixed(2)}',
              style: AppTypography.bodyMedium,
            ),
          ],
        ),
        Spacers.medium.horizontal,
        IconButton(
            onPressed: () async => await cubit.addVideo(),
            icon: AppIcons.addBoxRounded),
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
