part of '../play.dart';

class _EndField extends StatelessWidget {
  final List<VideoEntity> videos;
  final String text;
  final int? playingId;
  const _EndField(
      {super.key,
      required this.videos,
      required this.text,
      required this.playingId});

  @override
  Widget build(BuildContext context) {
    final cubit = context.cubit<_ScreenCubit>();
    return Container(
      width: context.width * 0.9,
      color: AppColors.black2,
      child: ListView(
        children: [
          Spacers.medium.vertical,
          Padding(
            padding: Paddings.medium.horizontal,
            child: SizedBox(
              width: context.width * 0.9 - 32,
              child: Text(
                text,
                style: AppTypography.headingSmall,
                overflow: TextOverflow.visible,
              ),
            ),
          ),
          if (videos.length > 1)
            for (final video in videos)
              Column(
                children: [
                  Spacers.small.all,
                  Padding(
                    padding: Paddings.small.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            AppCheckbox(
                              value: video.isWatched,
                              onChanged: (value) async =>
                                  await cubit.toggleWatch(video),
                            ),
                            SizedBox(
                              width: 250,
                              child: Text(video.name,
                                  overflow: TextOverflow.visible,
                                  style: AppTypography.bodyMedium),
                            ),
                          ],
                        ),
                        IconButton(
                            onPressed: () async =>
                                await cubit.playIndex(videos.indexOf(video)),
                            icon: video.id == playingId
                                ? AppIcons.equalizer
                                : AppIcons.play)
                      ],
                    ),
                  ),
                ],
              )
        ],
      ),
    );
  }
}
