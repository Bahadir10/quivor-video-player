part of '../play.dart';

class _BottomField extends StatelessWidget {
  final IVideoPlayerManager playerManager;
  final _ScreenState state;
  const _BottomField(
      {super.key, required this.playerManager, required this.state});

  @override
  Widget build(BuildContext context) {
    final cubit = context.cubit<_ScreenCubit>();
    return Expanded(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (!Platform.isIOS && !Platform.isAndroid)
            CustomDropdown<double>(
                width: 80,
                enableSearch: false,
                hintText: Strings.playSpeed(),
                initialSelection: 1,
                onSelected: (value) async => await cubit.setPlayRate(value),
                dropdownMenuEntries: [
                  DropdownMenuEntry(
                      value: playerManager.playSpeedVerySlow,
                      label: '${playerManager.playSpeedVerySlow}'),
                  DropdownMenuEntry(
                      value: playerManager.playSpeedSlow,
                      label: '${playerManager.playSpeedSlow}'),
                  DropdownMenuEntry(
                      value: playerManager.playSpeedMedium,
                      label: '${playerManager.playSpeedMedium}'),
                  DropdownMenuEntry(
                      value: playerManager.playSpeedFast,
                      label: '${playerManager.playSpeedFast}'),
                  DropdownMenuEntry(
                      value: playerManager.playSpeedVeryFast,
                      label: '${playerManager.playSpeedVeryFast}'),
                ]),
          Spacers.small.horizontal,
          IconButton(
              onPressed: () async {
                if (state.canPlayPrevious) {
                  await cubit.playPrevious();
                }
              },
              icon: AppIcons.skipPrevious.copyWith(
                  color: !state.canPlayPrevious ? AppColors.grey1 : null)),
          Spacers.small.horizontal,
          IconButton(
            icon: AppIcons.backward10,
            onPressed: () async => await playerManager.seekBackward(),
          ),
          Spacers.small.horizontal,
          IconButton(
            icon: AppIcons.forward10,
            onPressed: () async => await playerManager.seekForward(),
          ),
          Spacers.small.horizontal,
          IconButton(
              onPressed: () async {
                if (state.canPlayNext) {
                  await cubit.playNext();
                }
              },
              icon: AppIcons.skipNext.copyWith(
                  color: !state.canPlayNext ? AppColors.grey1 : null)),
          Spacers.small.horizontal,
          IconButton(
            icon: AppIcons.shuffle,
            onPressed: () async => playerManager.setShuffle(true),
          ),
          if (context.width > 600)
            CustomSlider(
              value: state.volume,
              onChanged: (value) async => await cubit.setVolume(value),
            )
        ],
      ),
    );
  }
}
