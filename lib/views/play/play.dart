// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:app_materials/app_materials.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexor/nexor.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:quivor/core/bloc/base_cubit.dart';
import 'package:quivor/core/bloc/cubits/recent_video.dart';
import 'package:quivor/core/bloc/custom_bloc_provider.dart';
import 'package:quivor/core/data/user_data_manager.dart';
import 'package:quivor/core/extensions/build_context.dart';
import 'package:quivor/core/models/entities/video.dart';
import 'package:quivor/core/service/interface/video.dart';
import 'package:quivor/core/videoPlayerManager/interface.dart';
import 'package:quivor/core/service/opensubtitles/interface.dart';
import 'package:quivor/core/service/opensubtitles/models.dart';
import 'package:quivor/core/enum/auto_play_mode.dart';
import 'package:quivor/core/service/logger/logger_service.dart';
import 'package:quivor/core/service/error/error_handler.dart';
import 'package:quivor/getit_settings.dart';
import 'package:quivor/utils/strings.dart';
import 'package:quivor/widgets/dropdown.dart';
import 'package:quivor/widgets/side_bar.dart';
import 'package:quivor/widgets/slider.dart';
import 'package:quivor/widgets/video_player.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

part 'viewModel/cubit/_cubit.dart';
part 'viewModel/cubit/_state.dart';
part 'play.freezed.dart';

part 'widgets/_bottom_field.dart';
part 'widgets/_end_field.dart';
part 'widgets/_subtitle_search_dialog.dart';
part 'widgets/_next_episode_button.dart';
part 'widgets/_auto_play_settings.dart';

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
              ? const Drawer(
                  child: SideBar(),
                )
              : null,
          endDrawer: BlocBuilder<_ScreenCubit, PlayScreenState>(
            builder: (context, state) {
              return _EndField(
                videos: state.videos,
                playingId: state.currentPlaying?.id,
                text: widget.mainPath ?? state.currentPlaying?.name ?? '',
              );
            },
          ),
          appBar: AppBar(
            leading: BlocBuilder<_ScreenCubit, PlayScreenState>(
              builder: (context, state) {
                return IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(Icons.menu, color: AppColors.black2),
                  onPressed: () =>
                      context.cubit<_ScreenCubit>().toggleSideBar(context),
                );
              },
            ),
            backgroundColor: AppColors.white1,
            automaticallyImplyLeading: false,
            elevation: 0,
            title: BlocBuilder<_ScreenCubit, PlayScreenState>(
              builder: (context, state) {
                return Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: AppColors.black1.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Icon(
                        Icons.play_circle_filled,
                        color: AppColors.black1,
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        state.currentPlaying?.name ?? '',
                        style: const TextStyle(
                          color: AppColors.black1,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          body: BlocBuilder<_ScreenCubit, PlayScreenState>(
            builder: (context, state) {
              return Container(
                color: AppColors.black1,
                child: Row(
                  children: [
                    if (state.isSideBarOpen) const SideBar(),
                    Expanded(
                      child: Column(
                        children: [
                          Expanded(
                            child: Container(
                              color: Colors.black,
                              child: Stack(
                                children: [
                                  Center(
                                    child: AspectRatio(
                                      aspectRatio: 16 / 9,
                                      child: AppVideoPlayer(
                                        videoPlayerManager: _playerManager,
                                      ),
                                    ),
                                  ),
                                  // Next episode button (only in early mode)
                                  if (state.showNextEpisode &&
                                      state.autoPlayMode == AutoPlayMode.early)
                                    _NextEpisodeButton(
                                      onNext: () async => await context
                                          .cubit<_ScreenCubit>()
                                          .playNext(),
                                      onCancel: () => context
                                          .cubit<_ScreenCubit>()
                                          .hideNextEpisode(),
                                      secondsRemaining: 10,
                                      autoPlayEnabled: true,
                                    ),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.black2,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 8,
                                  offset: const Offset(0, -2),
                                ),
                              ],
                            ),
                            child: _BottomField(
                              playerManager: _playerManager,
                              state: state,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          )),
    );
  }
}
