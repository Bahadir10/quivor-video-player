// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:app_materials/app_materials.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexor/nexor.dart';

import 'package:quivor/core/bloc/base_cubit.dart';
import 'package:quivor/core/bloc/cubits/recent_video.dart';
import 'package:quivor/core/bloc/custom_bloc_provider.dart';
import 'package:quivor/core/data/user_data_manager.dart';
import 'package:quivor/core/extensions/build_context.dart';
import 'package:quivor/core/models/entities/video.dart';
import 'package:quivor/core/service/interface/video.dart';
import 'package:quivor/core/videoPlayerManager/interface.dart';
import 'package:quivor/getit_settings.dart';
import 'package:quivor/utils/strings.dart';
import 'package:quivor/widgets/check_box.dart';
import 'package:quivor/widgets/side_bar.dart';
import 'package:quivor/widgets/slider.dart';
import 'package:quivor/widgets/video_player.dart';

part 'viewModel/cubit/_cubit.dart';
part 'viewModel/cubit/_state.dart';

part 'widgets/_bottom_field.dart';
part 'widgets/_end_field.dart';

final class PlayScreenParameters {
  final List<VideoEntity> paths;
  final String? mainPath;
  final int? startIndex;
  PlayScreenParameters({required this.paths, this.mainPath, this.startIndex});
}

class PlayScreen extends StatefulWidget {
  final List<VideoEntity> paths;
  final String? mainPath;
  final int? startIndex;
  PlayScreen({super.key, required final PlayScreenParameters parameters})
      : paths = parameters.paths,
        mainPath = parameters.mainPath,
        startIndex = parameters.startIndex;

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  final IVideoPlayerManager _playerManager = IVideoPlayerManager.scoped();

  @override
  void dispose() async {
    _playerManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final startIndex = widget.startIndex;
    return CustomBlocProvider(
      create: (context) =>
          _ScreenCubit(widget.paths, _playerManager, startIndex),
      child: Scaffold(
          drawer: context.width < 600
              ? Drawer(
                  child: SideBar(),
                )
              : null,
          endDrawer: BlocBuilder<_ScreenCubit, _ScreenState>(
            builder: (context, state) {
              final cubit = context.cubit<_ScreenCubit>();
              return _EndField(
                videos: state.videos,
                playingId: state.currentPlaying?.id,
                text: widget.mainPath ?? state.currentPlaying?.name ?? '',
              );
            },
          ),
          appBar: AppBar(
            leading: BlocBuilder<_ScreenCubit, _ScreenState>(
              builder: (context, state) {
                return IconButton(
                  padding: EdgeInsets.zero,
                  icon: AppIcons.menu.copyWith(color: AppColors.black2),
                  onPressed: () =>
                      context.cubit<_ScreenCubit>().toggleSideBar(context),
                );
              },
            ),
            backgroundColor: AppColors.white1,
            automaticallyImplyLeading: false,
            title: BlocBuilder<_ScreenCubit, _ScreenState>(
              builder: (context, state) {
                return Text(state.currentPlaying?.name ?? '');
              },
            ),
          ),
          body: BlocBuilder<_ScreenCubit, _ScreenState>(
            builder: (context, state) {
              final cubit = context.cubit<_ScreenCubit>();
              return Row(
                children: [
                  if (state.isSideBarOpen) SideBar(),
                  Column(
                    children: [
                      SizedBox(
                        width: state.isSideBarOpen
                            ? context.col(10)
                            : context.width,
                        height: context.height * 0.7,
                        child: AppVideoPlayer(
                          videoPlayerManager: _playerManager,
                        ),
                      ),
                      _BottomField(
                        playerManager: _playerManager,
                        state: state,
                      ),
                    ],
                  ),
                ],
              );
            },
          )),
    );
  }
}
