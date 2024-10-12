import 'package:app_materials/app_materials.dart';
import 'package:flutter/widgets.dart';
import 'package:nexor/nexor.dart';
import 'package:quivor/core/enum/route.dart';
import 'package:quivor/core/extensions/build_context.dart';
import 'package:quivor/core/fileManager/interface.dart';
import 'package:quivor/core/models/entities/video.dart';
import 'package:quivor/core/service/interface/video.dart';
import 'package:quivor/getit_settings.dart';
import 'package:quivor/utils/strings.dart';
import 'package:quivor/views/play/play.dart';
import 'package:path/path.dart' as p;

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: context.col(2),
        color: AppColors.black3,
        child: Column(
          children: [
            Spacers.medium.vertical,
            CustomIconTextButton(
              icon: AppIcons.home,
              text: 'Home',
              onPressed: () => navigate(context, AppRoute.home),
            ),
            CustomIconTextButton(
              onPressed: () => navigate(context, AppRoute.createPlaylist),
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
                  children: [
                    Spacers.medium.vertical,
                    AppIcons.addBoxRounded.copyWith(size: 64),
                    Spacers.medium.vertical,
                    IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomTextButton(
                              text: Strings.openFile(),
                              onPressed: () async {
                                final x =
                                    await getIt<IFileManager>().getVideoFile();

                                if (x != null) {
                                  VideoEntity? vid =
                                      await getIt<IVideoService>()
                                          .getVideoByPathOrNull(x);
                                  if (vid.isNotNull) {
                                  } else {
                                    vid = await getIt<IVideoService>()
                                        .createVideo(
                                            name: p.basename(x), path: x);
                                  }
                                  context.go(AppRoute.player,
                                      data:
                                          PlayScreenParameters(paths: [vid!]));
                                }
                              }),
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
