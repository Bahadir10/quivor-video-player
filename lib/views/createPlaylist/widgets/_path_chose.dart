part of '../create_playlist.dart';

class _PathChose extends StatelessWidget {
  final List<String> paths;
  const _PathChose({super.key, required this.paths});

  @override
  Widget build(BuildContext context) {
    final cubit = context.cubit<_ScreenCubit>();
    return Padding(
      padding: Paddings.medium.all,
      child: Column(
        children: [
          CustomTextField(
            controller: cubit.playlistNameController,
          ),
          Spacers.small.vertical,
          Expanded(
            child: ListView(
              shrinkWrap: true,
              children: [
                for (final item in paths)
                  Padding(
                    padding: Paddings.small.vertical,
                    child: Text(item, style: AppTypography.bodyMedium),
                  )
              ],
            ),
          ),
          CustomFilledButton(
            onPressed: () async => await cubit.createPlaylistFromPath(),
            text: Strings.create(),
          )
        ],
      ),
    );
  }
}
