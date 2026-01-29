import 'package:drift/drift.dart';

/// Table definition for video entities
class Videos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get path => text()();
  BoolColumn get isWatched => boolean().withDefault(const Constant(false))();
  IntColumn get categoryId => integer().nullable()();
  IntColumn get playlistId => integer().nullable()();
  IntColumn get lastPositionSecond =>
      integer().withDefault(const Constant(0))();
  TextColumn get downloadedSubtitles =>
      text().withDefault(const Constant('[]'))();
  TextColumn get lastSelectedSubtitle => text().nullable()();
  RealColumn get subtitleOffset => real().withDefault(const Constant(0.0))();
}

/// Table definition for playlist entities
class Playlists extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  TextColumn get autoPlayMode => text().nullable()();
  IntColumn get earlyTransitionSeconds => integer().nullable()();
  IntColumn get introSkipSeconds => integer().nullable()();
}

/// Table definition for recent video history
class Recents extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get videoId => integer()();
}

/// Table definition for category entities
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text()();
  IntColumn get icon => integer()();
}

/// Table definition for video notes
class VideoNotes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get videoId => integer()();
  IntColumn get timestampSeconds => integer()();
  TextColumn get noteText => text()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}
