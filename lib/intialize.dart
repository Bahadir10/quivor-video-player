import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:media_kit/media_kit.dart';
import 'package:nexor/nexor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:quivor/core/models/entities/category.dart';
import 'package:quivor/core/models/entities/playlist.dart';
import 'package:quivor/core/models/entities/recent.dart';
import 'package:quivor/core/models/entities/video.dart';
import 'package:quivor/getit_settings.dart';

late final Isar isar;

final class AppInitialize {
  FV run() async {
    WidgetsFlutterBinding.ensureInitialized();
    MediaKit.ensureInitialized();
    final dir = await getApplicationDocumentsDirectory();
    isar = await Isar.open(
        [PlaylistSchema, CategorySchema, VideoEntitySchema, RecentSchema],
        directory: dir.path, name: 'quivor');

    GetitSettings().init();
  }
}
