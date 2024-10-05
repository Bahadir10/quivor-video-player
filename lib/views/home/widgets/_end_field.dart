part of '../home.dart';

class _EndField extends StatelessWidget {
  const _EndField({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.cubit<_ScreenCubit>();
    return Padding(
        padding: Paddings.medium.horizontal,
        child: Column(
          children: [
            Spacers.high.vertical,
            Container(
              decoration: BoxDecoration(
                  borderRadius: Cutter.medium.all,
                  color: AppColors.black3,
                  boxShadow: const [
                    BoxShadow(
                        offset: Offset(2, 2),
                        blurRadius: 2,
                        spreadRadius: 5,
                        color: AppColors.black4)
                  ]),
              child: Column(
                //     crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Spacers.medium.vertical,
                  AppIcons.addBoxRounded.copyWith(size: 64),
                  Spacers.medium.vertical,
                  IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Spacer(),
                        CustomTextButton(
                          text: Strings.openFile(),
                          onPressed: () async => await cubit.openFile(),
                        ),

                        // Spacer()
                      ],
                    ),
                  ),
                  Spacers.medium.vertical,
                ],
              ),
            ),
          ],
        ));
  }
}
