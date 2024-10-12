// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:app_materials/app_materials.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nexor/nexor.dart';
import 'package:quivor/core/bloc/base_cubit.dart';
import 'package:quivor/core/enum/route.dart';
import 'package:quivor/core/extensions/build_context.dart';
import 'package:quivor/core/fileManager/interface.dart';

import 'package:quivor/core/models/entities/video.dart';
import 'package:quivor/core/service/interface/video.dart';
import 'package:quivor/core/service/responseModel/playlist_state.dart';
import 'package:quivor/getit_settings.dart';
import 'package:quivor/utils/strings.dart';
import 'package:quivor/views/play/play.dart';
import 'package:quivor/widgets/check_box.dart';
import 'package:quivor/widgets/side_bar.dart';
import 'package:path/path.dart' as p;

part 'viewModel/cubit/_cubit.dart';
part 'viewModel/cubit/_state.dart';

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
    return Scaffold(
      drawer: context.width < 600
          ? const Drawer(
              child: SideBar(),
            )
          : null,
      body: BlocProvider(
        create: (context) => _ScreenCubit(
          playlist: playlist,
        )..init(),
        child: BlocBuilder<_ScreenCubit, _ScreenState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(
                  child: CircularProgressIndicator(
                color: Colors.white,
              ));
            }

            final videos = state.videos!;
            // final int wathcedCount = videos.where((x) => x.isWatched).length;
            // final p = wathcedCount / videos.length * 100;
            // final percentage = p.isNaN ? 0.0 : p;
            final cubit = context.cubit<_ScreenCubit>();
            return Row(
              children: [
                if (state.isSideBarOpen) const SideBar(),
                if (state.isSideBarOpen) Spacers.small.horizontal,
                Flexible(
                  child: Padding(
                    padding: Paddings.medium.horizontal,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Spacers.medium.vertical,
                        _TopField(
                          percentage: playlist.progressPercentage,
                          playlist: playlist,
                          videos: videos,
                          watchedCount: playlist.watchedCount,
                        ),
                        Spacers.small.vertical,
                        CustomTextField(
                          hintText: Strings.search(),
                          onChanged: (value) async => cubit.search(value),
                        ),
                        _VideosField(
                          playlist: playlist,
                          videos: videos,
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
    );
  }
}
