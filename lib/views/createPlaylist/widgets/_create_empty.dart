part of '../create_playlist.dart';

class _CreateEmptyView extends StatelessWidget {
  const _CreateEmptyView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.cubit<_ScreenCubit>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: Paddings.medium.horizontal,
          child: CustomTextField(
            onChanged: cubit.updatePlaylistName,
          ),
        ),
        context.spacer.vertical(AppStandarts.high),
        CustomFilledButton(
          onPressed: () async => cubit.createEmptyPlaylist(),
          text: Strings.create(),
        )
      ],
    );
  }
}
