import 'package:app_materials/app_materials.dart';
import 'package:flutter/widgets.dart';
import 'package:nexor/nexor.dart';
import 'package:quivor/core/enum/route.dart';
import 'package:quivor/core/extensions/build_context.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
          CustomIconTextButton(
            icon: AppIcons.checked,
            text: 'Watched',
          ),
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
        ],
      ),
    );
  }

  void navigate(BuildContext context, AppRoute route) =>
      // Better to use [goOffAll] to prevent stack acummulate.
      context.goOffAll(route);
}
