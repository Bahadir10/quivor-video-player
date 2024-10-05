import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nexor/nexor.dart';
import 'package:quivor/core/bloc/cubits/recent_video.dart';
import 'package:quivor/core/data/user_data_manager.dart';
import 'package:quivor/core/enum/route.dart';
import 'package:quivor/core/fileManager/implementation.dart';
import 'package:quivor/core/fileManager/interface.dart';

import 'package:quivor/core/service/interface/playlist.dart';
import 'package:quivor/core/service/interface/video.dart';
import 'package:quivor/core/service/isar/playlist.dart';
import 'package:quivor/core/service/isar/video.dart';
import 'package:quivor/views/createPlaylist/create_playlist.dart';
import 'package:quivor/views/home/home.dart';
import 'package:quivor/views/play/play.dart';
import 'package:quivor/views/playlist/playlist.dart';

final getIt = GetIt.instance;

final class GetitSettings {
  Future<void> init() async {
    getIt
      // CUBITS

      // SERVICE
      ..registerSingleton<IPlaylistService>(IsarPlaylistService())
      ..registerSingleton<IVideoService>(IsarVideoService())
      ..registerSingleton<IFileManager>(FileManager())
      ..registerSingleton<RecentVideosCubit>(RecentVideosCubit()..init())

      // CONTROLLERS
      ..registerSingleton<INavigationController>(
          NavigationController((route, data) {
        return switch (route) {
          'home' => HomeScreen(),
          'createPlaylist' => CreatePlaylistScreen(),
          'player' => PlayScreen(
              parameters: data,
            ),
          'playlist' => PlaylistScreen(
              params: data,
            ),
          String() => Scaffold(),
        };
      }));
  }
}
