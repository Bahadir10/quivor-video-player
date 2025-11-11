import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables.dart';

part 'database.g.dart';

/// Main database class for the application using Drift
@DriftDatabase(tables: [Videos, Playlists, Recents, Categories])
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          // Future schema migrations will be handled here
        },
      );

  /// Factory constructor to create database instance with default file location
  static Future<AppDatabase> create() async {
    final dir = await getApplicationDocumentsDirectory();
    final dbPath = p.join(dir.path, 'quivor.db');
    final file = File(dbPath);
    return AppDatabase(NativeDatabase.createInBackground(file));
  }
}
