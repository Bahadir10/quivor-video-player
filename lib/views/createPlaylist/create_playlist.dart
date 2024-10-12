import 'dart:io';

import 'package:app_materials/app_materials.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nexor/nexor.dart';
import 'package:quivor/core/enum/route.dart';
import 'package:quivor/core/extensions/build_context.dart';
import 'package:quivor/core/fileManager/interface.dart';
import 'package:quivor/core/models/entities/video.dart';
import 'package:quivor/core/service/interface/playlist.dart';
import 'package:quivor/core/service/interface/video.dart';
import 'package:quivor/core/service/responseModel/playlist_state.dart';
import 'package:quivor/getit_settings.dart';
import 'package:quivor/utils/material_standarts.dart';
import 'package:quivor/utils/strings.dart';
import 'package:quivor/views/playlist/playlist.dart';
import 'package:quivor/widgets/side_bar.dart';

import 'package:responsive_builder/responsive_builder.dart';
import 'package:path/path.dart' as p;
part 'viewModel/cubit/_cubit.dart';
part 'viewModel/cubit/_state.dart';

part 'widgets/_create_empty.dart';
part 'widgets/_path_chose.dart';
part 'widgets/_when_landed.dart';

class CreatePlaylistScreen extends StatelessWidget {
  const CreatePlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _ScreenCubit(context),
      child: Scaffold(
        drawer: context.width < 600
            ? const Drawer(
                child: SideBar(),
              )
            : null,
        appBar: AppBar(
          leading: BlocBuilder<_ScreenCubit, _ScreenState>(
            builder: (context, state) {
              return IconButton(
                  onPressed: () =>
                      context.cubit<_ScreenCubit>().toggleSideBar(context),
                  icon: AppIcons.menu.copyWith(color: AppColors.black1));
            },
          ),
        ),
        body: BlocBuilder<_ScreenCubit, _ScreenState>(
          builder: (context, state) {
            final paths = state.playlistItems;
            Widget x = _WhenLandedView();
            if (state.choise == true) {
              x = _CreateEmptyView();
            }

            if (paths.isNotNull) {
              x = _PathChose(paths: paths!);
            }

            return Row(children: [
              if (state.isSideBarOpen) SideBar(),
              Expanded(child: x)
            ]);
          },
        ),
      ),
    );
  }
}
