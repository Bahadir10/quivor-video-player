import 'package:app_materials/app_materials.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nexor/nexor.dart';

import 'package:quivor/core/bloc/base_cubit.dart';
import 'package:quivor/core/bloc/cubits/recent_video.dart';
import 'package:quivor/core/bloc/custom_bloc_provider.dart';
import 'package:quivor/core/enum/route.dart';
import 'package:quivor/core/extensions/build_context.dart';
import 'package:quivor/core/fileManager/interface.dart';
import 'package:quivor/core/models/entities/playlist.dart';
import 'package:quivor/core/models/entities/video.dart';
import 'package:quivor/core/service/interface/playlist.dart';
import 'package:quivor/core/service/interface/video.dart';
import 'package:quivor/core/service/responseModel/playlist_state.dart';
import 'package:quivor/getit_settings.dart';
import 'package:quivor/utils/strings.dart';
import 'package:quivor/views/play/play.dart';
import 'package:quivor/views/playlist/playlist.dart';
import 'package:quivor/widgets/app_text.dart';
import 'package:quivor/widgets/progress_indicator.dart';
import 'package:quivor/widgets/side_bar.dart';

import 'package:responsive_builder/responsive_builder.dart';
import 'package:path/path.dart' as p;

part 'widgets/_playlist.dart';
part 'widgets/_recent_videos.dart';
part 'widgets/_middle_area.dart';
part 'widgets/_end_field.dart';

part 'viewModel/cubit/_cubit.dart';
part 'viewModel/cubit/_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        CustomBlocProvider(
          create: (context) => _ScreenCubit(context),
        ),
        BlocProvider(
          create: (context) => getIt<RecentVideosCubit>(),
        )
      ],
      child: Scaffold(
        drawer: ScreenTypeLayout.builder(
          mobile: (context) {
            return const Drawer(
              child: SideBar(),
            );
          },
        ),
        endDrawer: ScreenTypeLayout.builder(
          mobile: (context) {
            return const Drawer(
              backgroundColor: AppColors.black2,
              child: _EndField(),
            );
          },
        ),
        body: BlocBuilder<_ScreenCubit, _ScreenState>(
          builder: (context, state) {
            final cubit = context.cubit<_ScreenCubit>();
            if (state.isLoading) {
              return _whenLoading();
            }
            return ScreenTypeLayout.builder(
              desktop: (context) {
                return Row(
                  children: [
                    const SideBar(),
                    SizedBox(
                        height: double.maxFinite,
                        width: context.col(6),
                        child: _MiddleArea(
                          playlists: state.playlists!,
                        )),
                    Padding(
                      padding: Paddings.medium.all,
                      child: Container(
                        height: double.maxFinite,
                        width: context.col(4) - 32,
                        decoration: BoxDecoration(
                            color: AppColors.black3,
                            borderRadius: Cutter.medium.all),
                        child: const _EndField(),
                      ),
                    ),
                  ],
                );
              },
              mobile: (p0) => _MiddleArea(
                playlists: state.playlists!,
                isMobile: true,
              ),
            );
          },
        ),
      ),
    );
  }

  Center _whenLoading() {
    return const Center(
        child: CircularProgressIndicator(
      color: Colors.white,
    ));
  }
}
