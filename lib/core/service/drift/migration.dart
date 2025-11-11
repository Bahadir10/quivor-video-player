// import 'dart:io';

// import 'package:drift/drift.dart';
// import 'package:isar/isar.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:quivor/core/models/entities/category.dart';
// import 'package:quivor/core/models/entities/playlist.dart';
// import 'package:quivor/core/models/entities/recent.dart';
// import 'package:quivor/core/models/entities/video.dart';

// import 'database.dart';

// /// Handles migration of data from Isar database to Drift database
// class IsarToDriftMigration {
//   final AppDatabase driftDb;

//   IsarToDriftMigration(this.driftDb);

//   /// Checks if migration is needed by detecting existing Isar database
//   Future<bool> needsMigration() async {
//     try {
//       final dir = await getApplicationDocumentsDirectory();
//       final isarFile = File('${dir.path}/quivor.isar');
//       final exists = await isarFile.exists();

//       if (!exists) {
//         return false;
//       }

//       // Also check if Drift database already has data
//       // If it does, migration was likely already completed
//       final videoCount = await driftDb.select(driftDb.videos).get();
//       if (videoCount.isNotEmpty) {
//         return false;
//       }

//       return true;
//     } catch (e) {
//       print('Error checking migration status: $e');
//       return false;
//     }
//   }

//   /// Migrates all data from Isar to Drift database
//   Future<void> migrate() async {
//     if (!await needsMigration()) {
//       print('Migration not needed or already completed');
//       return;
//     }

//     print('Starting migration from Isar to Drift...');
//     Isar? isar;

//     try {
//       // Open Isar database in read-only mode
//       final dir = await getApplicationDocumentsDirectory();
//       isar = await Isar.open(
//         [PlaylistSchema, CategorySchema, VideoEntitySchema, RecentSchema],
//         directory: dir.path,
//         name: 'quivor',
//         inspector: false,
//       );

//       // Migrate in a transaction for data consistency
//       await driftDb.transaction(() async {
//         // Step 1: Migrate Playlists (must be first due to foreign key relationships)
//         await _migratePlaylists(isar!);

//         // Step 2: Migrate Categories
//         await _migrateCategories(isar);

//         // Step 3: Migrate Videos (depends on playlists and categories)
//         await _migrateVideos(isar);

//         // Step 4: Migrate Recents (depends on videos)
//         await _migrateRecents(isar);
//       });

//       print('Migration completed successfully');
//       print('Migrated data:');
//       print('  - Playlists: ${await isar.playlists.count()}');
//       print('  - Categories: ${await isar.categorys.count()}');
//       print('  - Videos: ${await isar.videoEntitys.count()}');
//       print('  - Recents: ${await isar.recents.count()}');
//     } catch (e, stackTrace) {
//       print('Migration failed: $e');
//       print('Stack trace: $stackTrace');
//       rethrow;
//     } finally {
//       // Close Isar database
//       await isar?.close();
//     }
//   }

//   /// Migrates playlist entities with ID preservation
//   Future<void> _migratePlaylists(Isar isar) async {
//     try {
//       final playlists = await isar.playlists.where().findAll();
//       print('Migrating ${playlists.length} playlists...');

//       for (final playlist in playlists) {
//         await driftDb.into(driftDb.playlists).insert(
//               PlaylistsCompanion.insert(
//                 id: Value(playlist.id),
//                 name: playlist.name,
//               ),
//               mode: InsertMode.insertOrReplace,
//             );
//       }

//       print('Successfully migrated ${playlists.length} playlists');
//     } catch (e) {
//       print('Error migrating playlists: $e');
//       rethrow;
//     }
//   }

//   /// Migrates category entities with ID preservation
//   Future<void> _migrateCategories(Isar isar) async {
//     try {
//       final categories = await isar.categorys.where().findAll();
//       print('Migrating ${categories.length} categories...');

//       for (final category in categories) {
//         await driftDb.into(driftDb.categories).insert(
//               CategoriesCompanion.insert(
//                 id: Value(category.id),
//                 name: category.name,
//                 icon: category.icon,
//               ),
//               mode: InsertMode.insertOrReplace,
//             );
//       }

//       print('Successfully migrated ${categories.length} categories');
//     } catch (e) {
//       print('Error migrating categories: $e');
//       rethrow;
//     }
//   }

//   /// Migrates video entities with all fields and relationships
//   Future<void> _migrateVideos(Isar isar) async {
//     try {
//       final videos = await isar.videoEntitys.where().findAll();
//       print('Migrating ${videos.length} videos...');

//       for (final video in videos) {
//         await driftDb.into(driftDb.videos).insert(
//               VideosCompanion.insert(
//                 id: Value(video.id),
//                 name: video.name,
//                 path: video.path,
//                 isWatched: Value(video.isWatched),
//                 categoryId: Value(video.categoryId),
//                 playlistId: Value(video.playlistId),
//                 lastPositionSecond: Value(video.lastPositionSecond),
//               ),
//               mode: InsertMode.insertOrReplace,
//             );
//       }

//       print('Successfully migrated ${videos.length} videos');
//     } catch (e) {
//       print('Error migrating videos: $e');
//       rethrow;
//     }
//   }

//   /// Migrates recent entities
//   Future<void> _migrateRecents(Isar isar) async {
//     try {
//       final recents = await isar.recents.where().findAll();
//       print('Migrating ${recents.length} recents...');

//       for (final recent in recents) {
//         await driftDb.into(driftDb.recents).insert(
//               RecentsCompanion.insert(
//                 id: Value(recent.id),
//                 videoId: recent.videoId,
//               ),
//               mode: InsertMode.insertOrReplace,
//             );
//       }

//       print('Successfully migrated ${recents.length} recents');
//     } catch (e) {
//       print('Error migrating recents: $e');
//       rethrow;
//     }
//   }
// }
