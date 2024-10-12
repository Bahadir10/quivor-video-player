part of '../home.dart';

class _MiddleArea extends StatelessWidget {
  final List<PlaylistStateResponseModel> playlists;
  final bool isMobile;
  const _MiddleArea(
      {super.key, required this.playlists, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final cubit = context.cubit<_ScreenCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Spacers.medium.vertical,
        Padding(
          padding: Paddings.medium.horizontal,
          child: Row(
            children: [
              if (isMobile)
                Row(
                  children: [
                    IconButton(
                        onPressed: () => Scaffold.of(context).openDrawer(),
                        icon: AppIcons.menu),
                    Spacers.small.horizontal,
                  ],
                ),
              Expanded(
                child: CustomTextField(
                  hintText: Strings.search.value,
                  onChanged: (value) async => cubit.search(value),
                ),
              ),
            ],
          ),
        ),
        Spacers.medium.vertical,
        Padding(
          padding: Paddings.medium.horizontal,
          child: AppText(
            Strings.playlists,
            style: AppTypography.headingMedium,
          ),
        ),
        _PlaylistField(
          playlists: playlists,
        ),
        Padding(
          padding: Paddings.medium.horizontal,
          child: AppText(
            Strings.recently,
            style: AppTypography.headingMedium,
          ),
        ),
        Padding(
          padding: Paddings.medium.horizontal,
          child: const _RecentVideosField(),
        ),
      ],
    );
  }
}
