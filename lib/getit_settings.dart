import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:nexor/nexor.dart';
import 'package:quivor/core/bloc/cubits/recent_video.dart';

import 'package:quivor/core/fileManager/implementation.dart';
import 'package:quivor/core/fileManager/interface.dart';

import 'package:quivor/core/service/interface/playlist.dart';
import 'package:quivor/core/service/interface/video.dart';
import 'package:quivor/core/service/interface/video_note.dart';
import 'package:quivor/core/service/drift/playlist.dart';
import 'package:quivor/core/service/drift/video.dart';
import 'package:quivor/core/service/drift/video_note.dart';
import 'package:quivor/intialize.dart';
import 'package:quivor/views/createPlaylist/create_playlist.dart';
import 'package:quivor/views/home/home.dart';
import 'package:quivor/views/play/play.dart';
import 'package:quivor/views/playlist/playlist.dart';
import 'package:quivor/views/settings/settings.dart';

final getIt = GetIt.instance;

final class GetitSettings {
  Future<void> init() async {
    getIt

      // SERVICE
      ..registerSingleton<IPlaylistService>(DriftPlaylistService(database))
      ..registerSingleton<IVideoService>(DriftVideoService(database))
      ..registerSingleton<IVideoNoteService>(DriftVideoNoteService(database))
      ..registerSingleton<IFileManager>(FileManager())
      // CUBITS
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
          'settings' => SettingsScreen(),
          String() => Scaffold(),
        };
      }));
  }
}
