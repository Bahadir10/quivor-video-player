import 'package:app_materials/app_materials.dart';
import 'package:flutter/widgets.dart';
import 'package:nexor/nexor.dart';
import 'package:quivor/core/enum/route.dart';
import 'package:quivor/core/extensions/build_context.dart';
import 'package:quivor/utils/strings.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        //height: double.maxFinite,
        width: context.col(2),
        color: AppColors.black3,
        child: Column(
          children: [
            Spacers.medium.vertical,
            CustomIconTextButton(
              icon: AppIcons.home,
              text: 'Home',
              onPressed: () => context.go(AppRoute.home),
            ),
            // CustomIconTextButton(
            //   icon: AppIcons.checked,
            //   text: 'Watched',
            // ),
            // CustomIconTextButton(
            //   icon: AppIcons.favorite,
            //   text: 'Favorites',
            // ),
            // CustomIconTextButton(
            //   icon: AppIcons.play,
            //   text: 'Open a video',
            // ),
            CustomIconTextButton(
              onPressed: () => context.go(AppRoute.createPlaylist),
              icon: AppIcons.playlistAdd,
              text: 'Create playlist',
            ),
            Spacers.small.vertical,
            Padding(
              padding: Paddings.small.horizontal,
              child: Container(
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
                              onPressed:
                                  () {} // async => await cubit.openFile(),
                              ),

                          // Spacer()
                        ],
                      ),
                    ),
                    Spacers.medium.vertical,
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigate(BuildContext context, AppRoute route) =>
      // Better to use [goOffAll] to prevent stack acummulate.
      context.goOffAll(route);
}
