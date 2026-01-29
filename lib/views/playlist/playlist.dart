// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:app_materials/app_materials.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:nexor/nexor.dart';
import 'package:quivor/core/bloc/base_cubit.dart';
import 'package:quivor/core/enum/route.dart';
import 'package:quivor/core/enum/auto_play_mode.dart';
import 'package:quivor/core/extensions/build_context.dart';
import 'package:quivor/core/fileManager/interface.dart';
import 'package:quivor/core/models/entities/playlist.dart' as entities;
import 'package:quivor/core/models/entities/video.dart';
import 'package:quivor/core/service/interface/video.dart';
import 'package:quivor/core/service/interface/playlist.dart';
import 'package:quivor/core/service/responseModel/playlist_state.dart';
import 'package:quivor/core/data/user_data_manager.dart';
import 'package:quivor/core/localization/localization_service.dart';
import 'package:quivor/core/localization/locale_keys.dart';
import 'package:quivor/getit_settings.dart';
import 'package:quivor/utils/helper.dart' show Helper;
import 'package:quivor/views/play/play.dart';
import 'package:quivor/widgets/side_bar.dart';
import 'package:path/path.dart' as p;

part 'viewModel/cubit/_cubit.dart';
part 'viewModel/cubit/_state.dart';
part 'playlist.freezed.dart';

part 'widgets/_videos.dart';
part 'widgets/_top_field.dart';

final class PlaylistScreenParameters {
  final PlaylistStateResponseModel playlist;
  PlaylistScreenParameters({
    required this.playlist,
  });
}

class PlaylistScreen extends StatelessWidget {
  final PlaylistStateResponseModel playlist;

  PlaylistScreen({super.key, required PlaylistScreenParameters params})
      : playlist = params.playlist;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: context.width < 600
            ? const Drawer(
                child: SideBar(),
              )
            : null,
        body: BlocProvider(
          create: (context) => _ScreenCubit(
            playlist: playlist,
          )..init(),
          child: BlocBuilder<_ScreenCubit, PlaylistScreenState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 3,
                  ),
                );
              }

              final videos = state.videos!;
              final cubit = context.cubit<_ScreenCubit>();
              return Row(
                children: [
                  if (state.isSideBarOpen) const SideBar(),
                  Flexible(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Top field with stats
                          _TopField(
                            percentage: state.playlist.progressPercentage,
                            playlist: state.playlist,
                            videos: videos,
                            watchedCount: state.playlist.watchedCount,
                          ),

                          const SizedBox(height: 24),

                          // Search bar
                          Container(
                            decoration: BoxDecoration(
                              color: AppColors.black1.withValues(alpha: 0.5),
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: AppColors.white1.withValues(alpha: 0.1),
                              ),
                            ),
                            child: TextField(
                              onChanged: (value) async => cubit.search(value),
                              style: const TextStyle(color: AppColors.white1),
                              decoration: InputDecoration(
                                hintText: 'Video ara...',
                                hintStyle: TextStyle(
                                  color: AppColors.grey1.withValues(alpha: 0.6),
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: AppColors.grey1.withValues(alpha: 0.6),
                                ),
                                border: InputBorder.none,
                                contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 14,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // Videos list
                          _VideosField(
                            playlist: state.playlist,
                            videos: state.videos ?? [],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
