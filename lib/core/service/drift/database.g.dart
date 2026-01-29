// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $VideosTable extends Videos with TableInfo<$VideosTable, Video> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VideosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _pathMeta = const VerificationMeta('path');
  @override
  late final GeneratedColumn<String> path = GeneratedColumn<String>(
      'path', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _isWatchedMeta =
      const VerificationMeta('isWatched');
  @override
  late final GeneratedColumn<bool> isWatched = GeneratedColumn<bool>(
      'is_watched', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_watched" IN (0, 1))'),
      defaultValue: const Constant(false));
  static const VerificationMeta _categoryIdMeta =
      const VerificationMeta('categoryId');
  @override
  late final GeneratedColumn<int> categoryId = GeneratedColumn<int>(
      'category_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _playlistIdMeta =
      const VerificationMeta('playlistId');
  @override
  late final GeneratedColumn<int> playlistId = GeneratedColumn<int>(
      'playlist_id', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _lastPositionSecondMeta =
      const VerificationMeta('lastPositionSecond');
  @override
  late final GeneratedColumn<int> lastPositionSecond = GeneratedColumn<int>(
      'last_position_second', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultValue: const Constant(0));
  static const VerificationMeta _downloadedSubtitlesMeta =
      const VerificationMeta('downloadedSubtitles');
  @override
  late final GeneratedColumn<String> downloadedSubtitles =
      GeneratedColumn<String>('downloaded_subtitles', aliasedName, false,
          type: DriftSqlType.string,
          requiredDuringInsert: false,
          defaultValue: const Constant('[]'));
  static const VerificationMeta _lastSelectedSubtitleMeta =
      const VerificationMeta('lastSelectedSubtitle');
  @override
  late final GeneratedColumn<String> lastSelectedSubtitle =
      GeneratedColumn<String>('last_selected_subtitle', aliasedName, true,
          type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _subtitleOffsetMeta =
      const VerificationMeta('subtitleOffset');
  @override
  late final GeneratedColumn<double> subtitleOffset = GeneratedColumn<double>(
      'subtitle_offset', aliasedName, false,
      type: DriftSqlType.double,
      requiredDuringInsert: false,
      defaultValue: const Constant(0.0));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        name,
        path,
        isWatched,
        categoryId,
        playlistId,
        lastPositionSecond,
        downloadedSubtitles,
        lastSelectedSubtitle,
        subtitleOffset
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'videos';
  @override
  VerificationContext validateIntegrity(Insertable<Video> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('path')) {
      context.handle(
          _pathMeta, path.isAcceptableOrUnknown(data['path']!, _pathMeta));
    } else if (isInserting) {
      context.missing(_pathMeta);
    }
    if (data.containsKey('is_watched')) {
      context.handle(_isWatchedMeta,
          isWatched.isAcceptableOrUnknown(data['is_watched']!, _isWatchedMeta));
    }
    if (data.containsKey('category_id')) {
      context.handle(
          _categoryIdMeta,
          categoryId.isAcceptableOrUnknown(
              data['category_id']!, _categoryIdMeta));
    }
    if (data.containsKey('playlist_id')) {
      context.handle(
          _playlistIdMeta,
          playlistId.isAcceptableOrUnknown(
              data['playlist_id']!, _playlistIdMeta));
    }
    if (data.containsKey('last_position_second')) {
      context.handle(
          _lastPositionSecondMeta,
          lastPositionSecond.isAcceptableOrUnknown(
              data['last_position_second']!, _lastPositionSecondMeta));
    }
    if (data.containsKey('downloaded_subtitles')) {
      context.handle(
          _downloadedSubtitlesMeta,
          downloadedSubtitles.isAcceptableOrUnknown(
              data['downloaded_subtitles']!, _downloadedSubtitlesMeta));
    }
    if (data.containsKey('last_selected_subtitle')) {
      context.handle(
          _lastSelectedSubtitleMeta,
          lastSelectedSubtitle.isAcceptableOrUnknown(
              data['last_selected_subtitle']!, _lastSelectedSubtitleMeta));
    }
    if (data.containsKey('subtitle_offset')) {
      context.handle(
          _subtitleOffsetMeta,
          subtitleOffset.isAcceptableOrUnknown(
              data['subtitle_offset']!, _subtitleOffsetMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Video map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Video(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      path: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}path'])!,
      isWatched: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_watched'])!,
      categoryId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}category_id']),
      playlistId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}playlist_id']),
      lastPositionSecond: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}last_position_second'])!,
      downloadedSubtitles: attachedDatabase.typeMapping.read(
          DriftSqlType.string, data['${effectivePrefix}downloaded_subtitles'])!,
      lastSelectedSubtitle: attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}last_selected_subtitle']),
      subtitleOffset: attachedDatabase.typeMapping.read(
          DriftSqlType.double, data['${effectivePrefix}subtitle_offset'])!,
    );
  }

  @override
  $VideosTable createAlias(String alias) {
    return $VideosTable(attachedDatabase, alias);
  }
}

class Video extends DataClass implements Insertable<Video> {
  final int id;
  final String name;
  final String path;
  final bool isWatched;
  final int? categoryId;
  final int? playlistId;
  final int lastPositionSecond;
  final String downloadedSubtitles;
  final String? lastSelectedSubtitle;
  final double subtitleOffset;
  const Video(
      {required this.id,
      required this.name,
      required this.path,
      required this.isWatched,
      this.categoryId,
      this.playlistId,
      required this.lastPositionSecond,
      required this.downloadedSubtitles,
      this.lastSelectedSubtitle,
      required this.subtitleOffset});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['path'] = Variable<String>(path);
    map['is_watched'] = Variable<bool>(isWatched);
    if (!nullToAbsent || categoryId != null) {
      map['category_id'] = Variable<int>(categoryId);
    }
    if (!nullToAbsent || playlistId != null) {
      map['playlist_id'] = Variable<int>(playlistId);
    }
    map['last_position_second'] = Variable<int>(lastPositionSecond);
    map['downloaded_subtitles'] = Variable<String>(downloadedSubtitles);
    if (!nullToAbsent || lastSelectedSubtitle != null) {
      map['last_selected_subtitle'] = Variable<String>(lastSelectedSubtitle);
    }
    map['subtitle_offset'] = Variable<double>(subtitleOffset);
    return map;
  }

  VideosCompanion toCompanion(bool nullToAbsent) {
    return VideosCompanion(
      id: Value(id),
      name: Value(name),
      path: Value(path),
      isWatched: Value(isWatched),
      categoryId: categoryId == null && nullToAbsent
          ? const Value.absent()
          : Value(categoryId),
      playlistId: playlistId == null && nullToAbsent
          ? const Value.absent()
          : Value(playlistId),
      lastPositionSecond: Value(lastPositionSecond),
      downloadedSubtitles: Value(downloadedSubtitles),
      lastSelectedSubtitle: lastSelectedSubtitle == null && nullToAbsent
          ? const Value.absent()
          : Value(lastSelectedSubtitle),
      subtitleOffset: Value(subtitleOffset),
    );
  }

  factory Video.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Video(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      path: serializer.fromJson<String>(json['path']),
      isWatched: serializer.fromJson<bool>(json['isWatched']),
      categoryId: serializer.fromJson<int?>(json['categoryId']),
      playlistId: serializer.fromJson<int?>(json['playlistId']),
      lastPositionSecond: serializer.fromJson<int>(json['lastPositionSecond']),
      downloadedSubtitles:
          serializer.fromJson<String>(json['downloadedSubtitles']),
      lastSelectedSubtitle:
          serializer.fromJson<String?>(json['lastSelectedSubtitle']),
      subtitleOffset: serializer.fromJson<double>(json['subtitleOffset']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'path': serializer.toJson<String>(path),
      'isWatched': serializer.toJson<bool>(isWatched),
      'categoryId': serializer.toJson<int?>(categoryId),
      'playlistId': serializer.toJson<int?>(playlistId),
      'lastPositionSecond': serializer.toJson<int>(lastPositionSecond),
      'downloadedSubtitles': serializer.toJson<String>(downloadedSubtitles),
      'lastSelectedSubtitle': serializer.toJson<String?>(lastSelectedSubtitle),
      'subtitleOffset': serializer.toJson<double>(subtitleOffset),
    };
  }

  Video copyWith(
          {int? id,
          String? name,
          String? path,
          bool? isWatched,
          Value<int?> categoryId = const Value.absent(),
          Value<int?> playlistId = const Value.absent(),
          int? lastPositionSecond,
          String? downloadedSubtitles,
          Value<String?> lastSelectedSubtitle = const Value.absent(),
          double? subtitleOffset}) =>
      Video(
        id: id ?? this.id,
        name: name ?? this.name,
        path: path ?? this.path,
        isWatched: isWatched ?? this.isWatched,
        categoryId: categoryId.present ? categoryId.value : this.categoryId,
        playlistId: playlistId.present ? playlistId.value : this.playlistId,
        lastPositionSecond: lastPositionSecond ?? this.lastPositionSecond,
        downloadedSubtitles: downloadedSubtitles ?? this.downloadedSubtitles,
        lastSelectedSubtitle: lastSelectedSubtitle.present
            ? lastSelectedSubtitle.value
            : this.lastSelectedSubtitle,
        subtitleOffset: subtitleOffset ?? this.subtitleOffset,
      );
  @override
  String toString() {
    return (StringBuffer('Video(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('path: $path, ')
          ..write('isWatched: $isWatched, ')
          ..write('categoryId: $categoryId, ')
          ..write('playlistId: $playlistId, ')
          ..write('lastPositionSecond: $lastPositionSecond, ')
          ..write('downloadedSubtitles: $downloadedSubtitles, ')
          ..write('lastSelectedSubtitle: $lastSelectedSubtitle, ')
          ..write('subtitleOffset: $subtitleOffset')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id,
      name,
      path,
      isWatched,
      categoryId,
      playlistId,
      lastPositionSecond,
      downloadedSubtitles,
      lastSelectedSubtitle,
      subtitleOffset);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Video &&
          other.id == this.id &&
          other.name == this.name &&
          other.path == this.path &&
          other.isWatched == this.isWatched &&
          other.categoryId == this.categoryId &&
          other.playlistId == this.playlistId &&
          other.lastPositionSecond == this.lastPositionSecond &&
          other.downloadedSubtitles == this.downloadedSubtitles &&
          other.lastSelectedSubtitle == this.lastSelectedSubtitle &&
          other.subtitleOffset == this.subtitleOffset);
}

class VideosCompanion extends UpdateCompanion<Video> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> path;
  final Value<bool> isWatched;
  final Value<int?> categoryId;
  final Value<int?> playlistId;
  final Value<int> lastPositionSecond;
  final Value<String> downloadedSubtitles;
  final Value<String?> lastSelectedSubtitle;
  final Value<double> subtitleOffset;
  const VideosCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.path = const Value.absent(),
    this.isWatched = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.playlistId = const Value.absent(),
    this.lastPositionSecond = const Value.absent(),
    this.downloadedSubtitles = const Value.absent(),
    this.lastSelectedSubtitle = const Value.absent(),
    this.subtitleOffset = const Value.absent(),
  });
  VideosCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required String path,
    this.isWatched = const Value.absent(),
    this.categoryId = const Value.absent(),
    this.playlistId = const Value.absent(),
    this.lastPositionSecond = const Value.absent(),
    this.downloadedSubtitles = const Value.absent(),
    this.lastSelectedSubtitle = const Value.absent(),
    this.subtitleOffset = const Value.absent(),
  })  : name = Value(name),
        path = Value(path);
  static Insertable<Video> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? path,
    Expression<bool>? isWatched,
    Expression<int>? categoryId,
    Expression<int>? playlistId,
    Expression<int>? lastPositionSecond,
    Expression<String>? downloadedSubtitles,
    Expression<String>? lastSelectedSubtitle,
    Expression<double>? subtitleOffset,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (path != null) 'path': path,
      if (isWatched != null) 'is_watched': isWatched,
      if (categoryId != null) 'category_id': categoryId,
      if (playlistId != null) 'playlist_id': playlistId,
      if (lastPositionSecond != null)
        'last_position_second': lastPositionSecond,
      if (downloadedSubtitles != null)
        'downloaded_subtitles': downloadedSubtitles,
      if (lastSelectedSubtitle != null)
        'last_selected_subtitle': lastSelectedSubtitle,
      if (subtitleOffset != null) 'subtitle_offset': subtitleOffset,
    });
  }

  VideosCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String>? path,
      Value<bool>? isWatched,
      Value<int?>? categoryId,
      Value<int?>? playlistId,
      Value<int>? lastPositionSecond,
      Value<String>? downloadedSubtitles,
      Value<String?>? lastSelectedSubtitle,
      Value<double>? subtitleOffset}) {
    return VideosCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      path: path ?? this.path,
      isWatched: isWatched ?? this.isWatched,
      categoryId: categoryId ?? this.categoryId,
      playlistId: playlistId ?? this.playlistId,
      lastPositionSecond: lastPositionSecond ?? this.lastPositionSecond,
      downloadedSubtitles: downloadedSubtitles ?? this.downloadedSubtitles,
      lastSelectedSubtitle: lastSelectedSubtitle ?? this.lastSelectedSubtitle,
      subtitleOffset: subtitleOffset ?? this.subtitleOffset,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (path.present) {
      map['path'] = Variable<String>(path.value);
    }
    if (isWatched.present) {
      map['is_watched'] = Variable<bool>(isWatched.value);
    }
    if (categoryId.present) {
      map['category_id'] = Variable<int>(categoryId.value);
    }
    if (playlistId.present) {
      map['playlist_id'] = Variable<int>(playlistId.value);
    }
    if (lastPositionSecond.present) {
      map['last_position_second'] = Variable<int>(lastPositionSecond.value);
    }
    if (downloadedSubtitles.present) {
      map['downloaded_subtitles'] = Variable<String>(downloadedSubtitles.value);
    }
    if (lastSelectedSubtitle.present) {
      map['last_selected_subtitle'] =
          Variable<String>(lastSelectedSubtitle.value);
    }
    if (subtitleOffset.present) {
      map['subtitle_offset'] = Variable<double>(subtitleOffset.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VideosCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('path: $path, ')
          ..write('isWatched: $isWatched, ')
          ..write('categoryId: $categoryId, ')
          ..write('playlistId: $playlistId, ')
          ..write('lastPositionSecond: $lastPositionSecond, ')
          ..write('downloadedSubtitles: $downloadedSubtitles, ')
          ..write('lastSelectedSubtitle: $lastSelectedSubtitle, ')
          ..write('subtitleOffset: $subtitleOffset')
          ..write(')'))
        .toString();
  }
}

class $PlaylistsTable extends Playlists
    with TableInfo<$PlaylistsTable, Playlist> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PlaylistsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _autoPlayModeMeta =
      const VerificationMeta('autoPlayMode');
  @override
  late final GeneratedColumn<String> autoPlayMode = GeneratedColumn<String>(
      'auto_play_mode', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _earlyTransitionSecondsMeta =
      const VerificationMeta('earlyTransitionSeconds');
  @override
  late final GeneratedColumn<int> earlyTransitionSeconds = GeneratedColumn<int>(
      'early_transition_seconds', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  static const VerificationMeta _introSkipSecondsMeta =
      const VerificationMeta('introSkipSeconds');
  @override
  late final GeneratedColumn<int> introSkipSeconds = GeneratedColumn<int>(
      'intro_skip_seconds', aliasedName, true,
      type: DriftSqlType.int, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [id, name, autoPlayMode, earlyTransitionSeconds, introSkipSeconds];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'playlists';
  @override
  VerificationContext validateIntegrity(Insertable<Playlist> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('auto_play_mode')) {
      context.handle(
          _autoPlayModeMeta,
          autoPlayMode.isAcceptableOrUnknown(
              data['auto_play_mode']!, _autoPlayModeMeta));
    }
    if (data.containsKey('early_transition_seconds')) {
      context.handle(
          _earlyTransitionSecondsMeta,
          earlyTransitionSeconds.isAcceptableOrUnknown(
              data['early_transition_seconds']!, _earlyTransitionSecondsMeta));
    }
    if (data.containsKey('intro_skip_seconds')) {
      context.handle(
          _introSkipSecondsMeta,
          introSkipSeconds.isAcceptableOrUnknown(
              data['intro_skip_seconds']!, _introSkipSecondsMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Playlist map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Playlist(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      autoPlayMode: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}auto_play_mode']),
      earlyTransitionSeconds: attachedDatabase.typeMapping.read(
          DriftSqlType.int, data['${effectivePrefix}early_transition_seconds']),
      introSkipSeconds: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}intro_skip_seconds']),
    );
  }

  @override
  $PlaylistsTable createAlias(String alias) {
    return $PlaylistsTable(attachedDatabase, alias);
  }
}

class Playlist extends DataClass implements Insertable<Playlist> {
  final int id;
  final String name;
  final String? autoPlayMode;
  final int? earlyTransitionSeconds;
  final int? introSkipSeconds;
  const Playlist(
      {required this.id,
      required this.name,
      this.autoPlayMode,
      this.earlyTransitionSeconds,
      this.introSkipSeconds});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || autoPlayMode != null) {
      map['auto_play_mode'] = Variable<String>(autoPlayMode);
    }
    if (!nullToAbsent || earlyTransitionSeconds != null) {
      map['early_transition_seconds'] = Variable<int>(earlyTransitionSeconds);
    }
    if (!nullToAbsent || introSkipSeconds != null) {
      map['intro_skip_seconds'] = Variable<int>(introSkipSeconds);
    }
    return map;
  }

  PlaylistsCompanion toCompanion(bool nullToAbsent) {
    return PlaylistsCompanion(
      id: Value(id),
      name: Value(name),
      autoPlayMode: autoPlayMode == null && nullToAbsent
          ? const Value.absent()
          : Value(autoPlayMode),
      earlyTransitionSeconds: earlyTransitionSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(earlyTransitionSeconds),
      introSkipSeconds: introSkipSeconds == null && nullToAbsent
          ? const Value.absent()
          : Value(introSkipSeconds),
    );
  }

  factory Playlist.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Playlist(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      autoPlayMode: serializer.fromJson<String?>(json['autoPlayMode']),
      earlyTransitionSeconds:
          serializer.fromJson<int?>(json['earlyTransitionSeconds']),
      introSkipSeconds: serializer.fromJson<int?>(json['introSkipSeconds']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'autoPlayMode': serializer.toJson<String?>(autoPlayMode),
      'earlyTransitionSeconds': serializer.toJson<int?>(earlyTransitionSeconds),
      'introSkipSeconds': serializer.toJson<int?>(introSkipSeconds),
    };
  }

  Playlist copyWith(
          {int? id,
          String? name,
          Value<String?> autoPlayMode = const Value.absent(),
          Value<int?> earlyTransitionSeconds = const Value.absent(),
          Value<int?> introSkipSeconds = const Value.absent()}) =>
      Playlist(
        id: id ?? this.id,
        name: name ?? this.name,
        autoPlayMode:
            autoPlayMode.present ? autoPlayMode.value : this.autoPlayMode,
        earlyTransitionSeconds: earlyTransitionSeconds.present
            ? earlyTransitionSeconds.value
            : this.earlyTransitionSeconds,
        introSkipSeconds: introSkipSeconds.present
            ? introSkipSeconds.value
            : this.introSkipSeconds,
      );
  @override
  String toString() {
    return (StringBuffer('Playlist(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('autoPlayMode: $autoPlayMode, ')
          ..write('earlyTransitionSeconds: $earlyTransitionSeconds, ')
          ..write('introSkipSeconds: $introSkipSeconds')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, name, autoPlayMode, earlyTransitionSeconds, introSkipSeconds);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Playlist &&
          other.id == this.id &&
          other.name == this.name &&
          other.autoPlayMode == this.autoPlayMode &&
          other.earlyTransitionSeconds == this.earlyTransitionSeconds &&
          other.introSkipSeconds == this.introSkipSeconds);
}

class PlaylistsCompanion extends UpdateCompanion<Playlist> {
  final Value<int> id;
  final Value<String> name;
  final Value<String?> autoPlayMode;
  final Value<int?> earlyTransitionSeconds;
  final Value<int?> introSkipSeconds;
  const PlaylistsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.autoPlayMode = const Value.absent(),
    this.earlyTransitionSeconds = const Value.absent(),
    this.introSkipSeconds = const Value.absent(),
  });
  PlaylistsCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    this.autoPlayMode = const Value.absent(),
    this.earlyTransitionSeconds = const Value.absent(),
    this.introSkipSeconds = const Value.absent(),
  }) : name = Value(name);
  static Insertable<Playlist> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<String>? autoPlayMode,
    Expression<int>? earlyTransitionSeconds,
    Expression<int>? introSkipSeconds,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (autoPlayMode != null) 'auto_play_mode': autoPlayMode,
      if (earlyTransitionSeconds != null)
        'early_transition_seconds': earlyTransitionSeconds,
      if (introSkipSeconds != null) 'intro_skip_seconds': introSkipSeconds,
    });
  }

  PlaylistsCompanion copyWith(
      {Value<int>? id,
      Value<String>? name,
      Value<String?>? autoPlayMode,
      Value<int?>? earlyTransitionSeconds,
      Value<int?>? introSkipSeconds}) {
    return PlaylistsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      autoPlayMode: autoPlayMode ?? this.autoPlayMode,
      earlyTransitionSeconds:
          earlyTransitionSeconds ?? this.earlyTransitionSeconds,
      introSkipSeconds: introSkipSeconds ?? this.introSkipSeconds,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (autoPlayMode.present) {
      map['auto_play_mode'] = Variable<String>(autoPlayMode.value);
    }
    if (earlyTransitionSeconds.present) {
      map['early_transition_seconds'] =
          Variable<int>(earlyTransitionSeconds.value);
    }
    if (introSkipSeconds.present) {
      map['intro_skip_seconds'] = Variable<int>(introSkipSeconds.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PlaylistsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('autoPlayMode: $autoPlayMode, ')
          ..write('earlyTransitionSeconds: $earlyTransitionSeconds, ')
          ..write('introSkipSeconds: $introSkipSeconds')
          ..write(')'))
        .toString();
  }
}

class $RecentsTable extends Recents with TableInfo<$RecentsTable, Recent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RecentsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _videoIdMeta =
      const VerificationMeta('videoId');
  @override
  late final GeneratedColumn<int> videoId = GeneratedColumn<int>(
      'video_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, videoId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'recents';
  @override
  VerificationContext validateIntegrity(Insertable<Recent> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('video_id')) {
      context.handle(_videoIdMeta,
          videoId.isAcceptableOrUnknown(data['video_id']!, _videoIdMeta));
    } else if (isInserting) {
      context.missing(_videoIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Recent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Recent(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      videoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}video_id'])!,
    );
  }

  @override
  $RecentsTable createAlias(String alias) {
    return $RecentsTable(attachedDatabase, alias);
  }
}

class Recent extends DataClass implements Insertable<Recent> {
  final int id;
  final int videoId;
  const Recent({required this.id, required this.videoId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['video_id'] = Variable<int>(videoId);
    return map;
  }

  RecentsCompanion toCompanion(bool nullToAbsent) {
    return RecentsCompanion(
      id: Value(id),
      videoId: Value(videoId),
    );
  }

  factory Recent.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Recent(
      id: serializer.fromJson<int>(json['id']),
      videoId: serializer.fromJson<int>(json['videoId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'videoId': serializer.toJson<int>(videoId),
    };
  }

  Recent copyWith({int? id, int? videoId}) => Recent(
        id: id ?? this.id,
        videoId: videoId ?? this.videoId,
      );
  @override
  String toString() {
    return (StringBuffer('Recent(')
          ..write('id: $id, ')
          ..write('videoId: $videoId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, videoId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Recent && other.id == this.id && other.videoId == this.videoId);
}

class RecentsCompanion extends UpdateCompanion<Recent> {
  final Value<int> id;
  final Value<int> videoId;
  const RecentsCompanion({
    this.id = const Value.absent(),
    this.videoId = const Value.absent(),
  });
  RecentsCompanion.insert({
    this.id = const Value.absent(),
    required int videoId,
  }) : videoId = Value(videoId);
  static Insertable<Recent> custom({
    Expression<int>? id,
    Expression<int>? videoId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (videoId != null) 'video_id': videoId,
    });
  }

  RecentsCompanion copyWith({Value<int>? id, Value<int>? videoId}) {
    return RecentsCompanion(
      id: id ?? this.id,
      videoId: videoId ?? this.videoId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (videoId.present) {
      map['video_id'] = Variable<int>(videoId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RecentsCompanion(')
          ..write('id: $id, ')
          ..write('videoId: $videoId')
          ..write(')'))
        .toString();
  }
}

class $CategoriesTable extends Categories
    with TableInfo<$CategoriesTable, Category> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
      'name', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _iconMeta = const VerificationMeta('icon');
  @override
  late final GeneratedColumn<int> icon = GeneratedColumn<int>(
      'icon', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [id, name, icon];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categories';
  @override
  VerificationContext validateIntegrity(Insertable<Category> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('name')) {
      context.handle(
          _nameMeta, name.isAcceptableOrUnknown(data['name']!, _nameMeta));
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('icon')) {
      context.handle(
          _iconMeta, icon.isAcceptableOrUnknown(data['icon']!, _iconMeta));
    } else if (isInserting) {
      context.missing(_iconMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Category map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Category(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      name: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}name'])!,
      icon: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}icon'])!,
    );
  }

  @override
  $CategoriesTable createAlias(String alias) {
    return $CategoriesTable(attachedDatabase, alias);
  }
}

class Category extends DataClass implements Insertable<Category> {
  final int id;
  final String name;
  final int icon;
  const Category({required this.id, required this.name, required this.icon});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['name'] = Variable<String>(name);
    map['icon'] = Variable<int>(icon);
    return map;
  }

  CategoriesCompanion toCompanion(bool nullToAbsent) {
    return CategoriesCompanion(
      id: Value(id),
      name: Value(name),
      icon: Value(icon),
    );
  }

  factory Category.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Category(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      icon: serializer.fromJson<int>(json['icon']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'icon': serializer.toJson<int>(icon),
    };
  }

  Category copyWith({int? id, String? name, int? icon}) => Category(
        id: id ?? this.id,
        name: name ?? this.name,
        icon: icon ?? this.icon,
      );
  @override
  String toString() {
    return (StringBuffer('Category(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name, icon);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Category &&
          other.id == this.id &&
          other.name == this.name &&
          other.icon == this.icon);
}

class CategoriesCompanion extends UpdateCompanion<Category> {
  final Value<int> id;
  final Value<String> name;
  final Value<int> icon;
  const CategoriesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.icon = const Value.absent(),
  });
  CategoriesCompanion.insert({
    this.id = const Value.absent(),
    required String name,
    required int icon,
  })  : name = Value(name),
        icon = Value(icon);
  static Insertable<Category> custom({
    Expression<int>? id,
    Expression<String>? name,
    Expression<int>? icon,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (icon != null) 'icon': icon,
    });
  }

  CategoriesCompanion copyWith(
      {Value<int>? id, Value<String>? name, Value<int>? icon}) {
    return CategoriesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (icon.present) {
      map['icon'] = Variable<int>(icon.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('icon: $icon')
          ..write(')'))
        .toString();
  }
}

class $VideoNotesTable extends VideoNotes
    with TableInfo<$VideoNotesTable, VideoNote> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VideoNotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _videoIdMeta =
      const VerificationMeta('videoId');
  @override
  late final GeneratedColumn<int> videoId = GeneratedColumn<int>(
      'video_id', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _timestampSecondsMeta =
      const VerificationMeta('timestampSeconds');
  @override
  late final GeneratedColumn<int> timestampSeconds = GeneratedColumn<int>(
      'timestamp_seconds', aliasedName, false,
      type: DriftSqlType.int, requiredDuringInsert: true);
  static const VerificationMeta _noteTextMeta =
      const VerificationMeta('noteText');
  @override
  late final GeneratedColumn<String> noteText = GeneratedColumn<String>(
      'note_text', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, videoId, timestampSeconds, noteText, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'video_notes';
  @override
  VerificationContext validateIntegrity(Insertable<VideoNote> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('video_id')) {
      context.handle(_videoIdMeta,
          videoId.isAcceptableOrUnknown(data['video_id']!, _videoIdMeta));
    } else if (isInserting) {
      context.missing(_videoIdMeta);
    }
    if (data.containsKey('timestamp_seconds')) {
      context.handle(
          _timestampSecondsMeta,
          timestampSeconds.isAcceptableOrUnknown(
              data['timestamp_seconds']!, _timestampSecondsMeta));
    } else if (isInserting) {
      context.missing(_timestampSecondsMeta);
    }
    if (data.containsKey('note_text')) {
      context.handle(_noteTextMeta,
          noteText.isAcceptableOrUnknown(data['note_text']!, _noteTextMeta));
    } else if (isInserting) {
      context.missing(_noteTextMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  VideoNote map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return VideoNote(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      videoId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}video_id'])!,
      timestampSeconds: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}timestamp_seconds'])!,
      noteText: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}note_text'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $VideoNotesTable createAlias(String alias) {
    return $VideoNotesTable(attachedDatabase, alias);
  }
}

class VideoNote extends DataClass implements Insertable<VideoNote> {
  final int id;
  final int videoId;
  final int timestampSeconds;
  final String noteText;
  final DateTime createdAt;
  const VideoNote(
      {required this.id,
      required this.videoId,
      required this.timestampSeconds,
      required this.noteText,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['video_id'] = Variable<int>(videoId);
    map['timestamp_seconds'] = Variable<int>(timestampSeconds);
    map['note_text'] = Variable<String>(noteText);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  VideoNotesCompanion toCompanion(bool nullToAbsent) {
    return VideoNotesCompanion(
      id: Value(id),
      videoId: Value(videoId),
      timestampSeconds: Value(timestampSeconds),
      noteText: Value(noteText),
      createdAt: Value(createdAt),
    );
  }

  factory VideoNote.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return VideoNote(
      id: serializer.fromJson<int>(json['id']),
      videoId: serializer.fromJson<int>(json['videoId']),
      timestampSeconds: serializer.fromJson<int>(json['timestampSeconds']),
      noteText: serializer.fromJson<String>(json['noteText']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'videoId': serializer.toJson<int>(videoId),
      'timestampSeconds': serializer.toJson<int>(timestampSeconds),
      'noteText': serializer.toJson<String>(noteText),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  VideoNote copyWith(
          {int? id,
          int? videoId,
          int? timestampSeconds,
          String? noteText,
          DateTime? createdAt}) =>
      VideoNote(
        id: id ?? this.id,
        videoId: videoId ?? this.videoId,
        timestampSeconds: timestampSeconds ?? this.timestampSeconds,
        noteText: noteText ?? this.noteText,
        createdAt: createdAt ?? this.createdAt,
      );
  @override
  String toString() {
    return (StringBuffer('VideoNote(')
          ..write('id: $id, ')
          ..write('videoId: $videoId, ')
          ..write('timestampSeconds: $timestampSeconds, ')
          ..write('noteText: $noteText, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, videoId, timestampSeconds, noteText, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is VideoNote &&
          other.id == this.id &&
          other.videoId == this.videoId &&
          other.timestampSeconds == this.timestampSeconds &&
          other.noteText == this.noteText &&
          other.createdAt == this.createdAt);
}

class VideoNotesCompanion extends UpdateCompanion<VideoNote> {
  final Value<int> id;
  final Value<int> videoId;
  final Value<int> timestampSeconds;
  final Value<String> noteText;
  final Value<DateTime> createdAt;
  const VideoNotesCompanion({
    this.id = const Value.absent(),
    this.videoId = const Value.absent(),
    this.timestampSeconds = const Value.absent(),
    this.noteText = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  VideoNotesCompanion.insert({
    this.id = const Value.absent(),
    required int videoId,
    required int timestampSeconds,
    required String noteText,
    this.createdAt = const Value.absent(),
  })  : videoId = Value(videoId),
        timestampSeconds = Value(timestampSeconds),
        noteText = Value(noteText);
  static Insertable<VideoNote> custom({
    Expression<int>? id,
    Expression<int>? videoId,
    Expression<int>? timestampSeconds,
    Expression<String>? noteText,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (videoId != null) 'video_id': videoId,
      if (timestampSeconds != null) 'timestamp_seconds': timestampSeconds,
      if (noteText != null) 'note_text': noteText,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  VideoNotesCompanion copyWith(
      {Value<int>? id,
      Value<int>? videoId,
      Value<int>? timestampSeconds,
      Value<String>? noteText,
      Value<DateTime>? createdAt}) {
    return VideoNotesCompanion(
      id: id ?? this.id,
      videoId: videoId ?? this.videoId,
      timestampSeconds: timestampSeconds ?? this.timestampSeconds,
      noteText: noteText ?? this.noteText,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (videoId.present) {
      map['video_id'] = Variable<int>(videoId.value);
    }
    if (timestampSeconds.present) {
      map['timestamp_seconds'] = Variable<int>(timestampSeconds.value);
    }
    if (noteText.present) {
      map['note_text'] = Variable<String>(noteText.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VideoNotesCompanion(')
          ..write('id: $id, ')
          ..write('videoId: $videoId, ')
          ..write('timestampSeconds: $timestampSeconds, ')
          ..write('noteText: $noteText, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  late final $VideosTable videos = $VideosTable(this);
  late final $PlaylistsTable playlists = $PlaylistsTable(this);
  late final $RecentsTable recents = $RecentsTable(this);
  late final $CategoriesTable categories = $CategoriesTable(this);
  late final $VideoNotesTable videoNotes = $VideoNotesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [videos, playlists, recents, categories, videoNotes];
}
