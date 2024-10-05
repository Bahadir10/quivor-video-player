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
      width: context.width / 2,
      color: AppColors.black2,
      child: ListView(
        children: [
          Spacers.medium.vertical,
          Text(
            text,
            style: AppTypography.headingSmall,
          ),
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
                          Text(video.name, style: AppTypography.bodyMedium),
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
