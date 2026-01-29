import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

import 'tables.dart';

part 'database.g.dart';

/// Main database class for the application using Drift
@DriftDatabase(tables: [Videos, Playlists, Recents, Categories, VideoNotes])
class AppDatabase extends _$AppDatabase {
  AppDatabase(QueryExecutor e) : super(e);

  @override
  int get schemaVersion => 7;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
        },
        onUpgrade: (Migrator m, int from, int to) async {
          try {
            // Version 1 → 2: Added downloadedSubtitles
            if (from < 2) {
              try {
                await m.addColumn(videos, videos.downloadedSubtitles);
              } catch (e) {
                // Column might already exist, ignore duplicate column error
                if (!e.toString().contains('duplicate column')) {
                  rethrow;
                }
              }
            }

            // Version 2 → 3: Added lastSelectedSubtitle
            if (from < 3) {
              try {
                await m.addColumn(videos, videos.lastSelectedSubtitle);
              } catch (e) {
                // Column might already exist, ignore duplicate column error
                if (!e.toString().contains('duplicate column')) {
                  rethrow;
                }
              }
            }

            // Version 3 → 4: Added playlist autoplay settings
            if (from < 4) {
              try {
                await m.addColumn(playlists, playlists.autoPlayMode);
              } catch (e) {
                // Column might already exist, ignore duplicate column error
                if (!e.toString().contains('duplicate column')) {
                  rethrow;
                }
              }
              try {
                await m.addColumn(playlists, playlists.earlyTransitionSeconds);
              } catch (e) {
                // Column might already exist, ignore duplicate column error
                if (!e.toString().contains('duplicate column')) {
                  rethrow;
                }
              }
            }

            // Version 4 → 5: Added intro skip seconds
            if (from < 5) {
              try {
                await m.addColumn(playlists, playlists.introSkipSeconds);
              } catch (e) {
                // Column might already exist, ignore duplicate column error
                if (!e.toString().contains('duplicate column')) {
                  rethrow;
                }
              }
            }

            // Version 5 → 6: Added subtitle offset
            if (from < 6) {
              try {
                await m.addColumn(videos, videos.subtitleOffset);
              } catch (e) {
                // Column might already exist, ignore duplicate column error
                if (!e.toString().contains('duplicate column')) {
                  rethrow;
                }
              }
            }

            // Version 6 → 7: Added video notes table
            if (from < 7) {
              try {
                await m.createTable(videoNotes);
              } catch (e) {
                // Table might already exist
                if (!e.toString().contains('already exists')) {
                  rethrow;
                }
              }
            }
          } catch (e) {
            // Log migration error but don't crash the app
            print('Migration error: $e');
          }
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
