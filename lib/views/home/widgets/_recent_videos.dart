part of '../home.dart';

class _RecentVideosField extends StatelessWidget {
  const _RecentVideosField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.cubit<_ScreenCubit>();
    return BlocBuilder<RecentVideosCubit, List<VideoEntity>?>(
      builder: (context, state) {
        return SizedBox(
          height: context.height * 0.5,
          child: ListView(
            shrinkWrap: true,
            children: [
              for (final video in state!)
                InkWell(
                  borderRadius: Cutter.small.all,
                  onTap: () async => await cubit.playRecentVideo(video),
                  hoverColor: Colors.grey.shade900,
                  child: Padding(
                    padding: Paddings.small.vertical,
                    child: Text(
                      video.name,
                      style: AppTypography.bodyMedium,
                    ),
                  ),
                )
            ],
          ),
        );
      },
    );
  }
}
