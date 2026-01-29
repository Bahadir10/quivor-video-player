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
import 'package:quivor/core/service/position_monitoring_service.dart';
import 'package:quivor/core/service/interface/playlist.dart';
import 'package:quivor/core/localization/localization_service.dart';
import 'package:quivor/core/localization/locale_keys.dart';
import 'package:quivor/core/service/keyboard_shortcuts_service.dart';
import 'package:quivor/core/models/entities/video_note.dart';
import 'package:quivor/core/service/interface/video_note.dart';
import 'package:quivor/getit_settings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:quivor/widgets/dropdown.dart';
import 'package:quivor/widgets/side_bar.dart';
import 'package:quivor/widgets/slider.dart';
import 'package:quivor/widgets/video_player.dart';
import 'package:path/path.dart' as path;
import 'package:flutter/services.dart';

part 'viewModel/cubit/_cubit.dart';
part 'viewModel/cubit/_state.dart';
part 'play.freezed.dart';

part 'widgets/_bottom_field.dart';
part 'widgets/_end_field.dart';
part 'widgets/_subtitle_search_dialog.dart';
part 'widgets/_next_episode_button.dart';
part 'widgets/_auto_play_settings.dart';
part 'widgets/_video_notes.dart';

final class PlayScreenParameters {
  final List<VideoEntity> paths;
  final String? mainPath;
  final int? startIndex;
  final int? playlistId;
  PlayScreenParameters({
    required this.paths,
    this.mainPath,
    this.startIndex,
    this.playlistId,
  });
}

class PlayScreen extends StatefulWidget {
  final List<VideoEntity> paths;
  final String? mainPath;
  final int? startIndex;
  final int? playlistId;
  PlayScreen({super.key, required final PlayScreenParameters parameters})
      : paths = parameters.paths,
        mainPath = parameters.mainPath,
        startIndex = parameters.startIndex,
        playlistId = parameters.playlistId;

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  final IVideoPlayerManager _playerManager = IVideoPlayerManager.scoped();
  final _keyboardService = KeyboardShortcutsService();
  final _focusNode = FocusNode();
  _ScreenCubit? _cubit;

  @override
  void initState() {
    super.initState();
    _keyboardService.initialize();
  }

  @override
  void dispose() {
    _playerManager.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is! KeyDownEvent) return KeyEventResult.ignored;

    final action = _keyboardService.getActionForKey(event.logicalKey);
    if (action == null) return KeyEventResult.ignored;

    switch (action) {
      case 'playPause':
        _playerManager.playOrPause();
        break;
      case 'seekBackward':
        _playerManager.seekBackward();
        break;
      case 'seekForward':
        _playerManager.seekForward();
        break;
      case 'volumeUp':
        final currentVolume = _playerManager.volume;
        _playerManager.setVolume((currentVolume + 0.1).clamp(0.0, 1.0));
        break;
      case 'volumeDown':
        final currentVolume = _playerManager.volume;
        _playerManager.setVolume((currentVolume - 0.1).clamp(0.0, 1.0));
        break;
      case 'toggleMute':
        final currentVolume = _playerManager.volume;
        if (currentVolume > 0) {
          _playerManager.setVolume(0.0);
        } else {
          _playerManager.setVolume(1.0);
        }
        break;
      case 'toggleFullscreen':
        _cubit?.toggleFullscreen();
        break;
      case 'nextVideo':
        _cubit?.playNext();
        break;
      case 'previousVideo':
        _cubit?.playPrevious();
        break;
    }

    return KeyEventResult.handled;
  }

  @override
  Widget build(BuildContext context) {
    final startIndex = widget.startIndex;
    return CustomBlocProvider(
      create: (context) {
        _cubit = _ScreenCubit(
            widget.paths, _playerManager, startIndex, widget.playlistId);
        return _cubit!;
      },
      child: GestureDetector(
        onTap: () {
          _focusNode.requestFocus();
        },
        child: Focus(
          focusNode: _focusNode,
          autofocus: true,
          onKeyEvent: _handleKeyEvent,
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
                                          state.autoPlayMode ==
                                              AutoPlayMode.early)
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
                                      color:
                                          Colors.black.withValues(alpha: 0.3),
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
                        if (state.showNotes) const _VideoNotesPanel(),
                      ],
                    ),
                  );
                },
              )),
        ),
      ),
    );
  }
}
