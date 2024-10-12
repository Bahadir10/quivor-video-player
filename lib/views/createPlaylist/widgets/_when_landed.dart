part of '../create_playlist.dart';

class _WhenLandedView extends StatelessWidget {
  const _WhenLandedView({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.cubit<_ScreenCubit>();
    final itemFromFolder = _selectionItem(Strings.fromFolder(),
        AppIcons.folderOpen, Strings.selectFolder(), true, context);
    final emptyList = _selectionItem(Strings.empty(), AppIcons.playlistAdd,
        Strings.createNew(), false, context);
    return ScreenTypeLayout.builder(
      desktop: (context) {
        return Column(
          children: [
            const Spacer(),
            Row(
              children: [
                const Spacer(flex: 1),
                Expanded(
                  flex: 2,
                  child: itemFromFolder,
                ),
                Spacers.high.horizontal,
                Expanded(
                  flex: 2,
                  child: emptyList,
                ),
                const Spacer(flex: 1)
              ],
            ),
            const Spacer(),
          ],
        );
      },
      mobile: (context) {
        return Center(
          child: Padding(
            padding: Paddings.medium.all,
            child: Container(
              height: 240,
              decoration: BoxDecoration(
                  color: AppColors.black3, borderRadius: Cutter.medium.all),
              child: Padding(
                padding: Paddings.medium.all,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _mobileSelectionItem(
                      Strings.fromFolder(),
                      AppIcons.folderOpen,
                      Strings.selectFolder(),
                      onPressed: () async => await cubit.openPath(),
                    ),
                    Container(
                      height: 220,
                      width: 1,
                      decoration: BoxDecoration(
                          color: AppColors.grey3,
                          borderRadius: Cutter.medium.all),
                    ),
                    _mobileSelectionItem(
                      Strings.empty(),
                      AppIcons.playlistAdd,
                      Strings.createNew(),
                      onPressed: () => cubit.makeChoise(),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _mobileSelectionItem(String text, Icon icon, String buttonText,
      {void Function()? onPressed}) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        Spacers.small.vertical,
        Text(
          text,
          style: AppTypography.headingSmall,
        ),
        Spacers.medium.vertical,
        CustomFilledButton(
          onPressed: onPressed,
          text: buttonText,
        ),
      ],
    );
  }

  Widget _selectionItem(String text, Icon icon, String buttonText,
      bool openFolder, BuildContext context) {
    return Container(
        height: 240,
        decoration: BoxDecoration(
            color: AppColors.black3, borderRadius: Cutter.medium.all),
        child: Padding(
          padding: Paddings.high.horizontal,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              Spacers.small.vertical,
              Text(
                text,
                style: AppTypography.headingSmall,
              ),
              Spacers.medium.vertical,
              CustomFilledButton(
                onPressed: () async {
                  if (openFolder) {
                    await context.cubit<_ScreenCubit>().openPath();
                  } else {
                    context.cubit<_ScreenCubit>().makeChoise();
                  }
                },
                text: buttonText,
              ),
            ],
          ),
        ));
  }
}
