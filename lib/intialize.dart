import 'dart:io';
import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'package:nexor/nexor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:drift/native.dart';
import 'package:quivor/core/service/drift/database.dart';
import 'package:quivor/core/service/drift/migration.dart';
import 'package:quivor/getit_settings.dart';

late final AppDatabase database;

final class AppInitialize {
  FV run() async {
    WidgetsFlutterBinding.ensureInitialized();
    MediaKit.ensureInitialized();

    // Initialize Drift database
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = p.join(dir.path, 'quivor.db');
    database = AppDatabase(NativeDatabase.createInBackground(File(dbPath)));

    // Run migration if needed
    // final migration = IsarToDriftMigration(database);
    // if (await migration.needsMigration()) {
    //   await migration.migrate();
    // }

    GetitSettings().init();
  }
}
