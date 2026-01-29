import 'package:drift/drift.dart';
import 'package:nexor/nexor.dart';
import 'package:quivor/core/models/entities/video_note.dart';
import 'package:quivor/core/service/interface/video_note.dart';
import 'package:quivor/core/service/error/error_handler.dart';
import 'package:quivor/core/service/logger/logger_service.dart';

import 'database.dart';

/// Drift implementation of IVideoNoteService
class DriftVideoNoteService extends IVideoNoteService {
  final AppDatabase _db;

  DriftVideoNoteService(this._db);

  @override
  Future<VideoNoteEntity> createNote({
    required int videoId,
    required int timestampSeconds,
    required String noteText,
  }) async {
    try {
      logger.info(
          'Creating note for video $videoId at $timestampSeconds seconds');

      final id = await _db.into(_db.videoNotes).insert(
            VideoNotesCompanion.insert(
              videoId: videoId,
              timestampSeconds: timestampSeconds,
              noteText: noteText,
            ),
          );

      return VideoNoteEntity(
        id: id,
        videoId: videoId,
        timestampSeconds: timestampSeconds,
        noteText: noteText,
        createdAt: DateTime.now(),
      );
    } catch (e, stackTrace) {
      errorHandler.handleError(
          'DriftVideoNoteService createNote', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<VideoNoteEntity>> getNotesForVideo(int videoId) async {
    try {
      final results = await (_db.select(_db.videoNotes)
            ..where((tbl) => tbl.videoId.equals(videoId))
            ..orderBy([(tbl) => OrderingTerm.asc(tbl.timestampSeconds)]))
          .get();

      return results.map(_toVideoNoteEntity).toList();
    } catch (e, stackTrace) {
      errorHandler.handleError(
          'DriftVideoNoteService getNotesForVideo', e, stackTrace);
      return [];
    }
  }

  @override
  FV updateNote(VideoNoteEntity note) async {
    try {
      await _db.update(_db.videoNotes).replace(
            VideoNotesCompanion(
              id: Value(note.id),
              videoId: Value(note.videoId),
              timestampSeconds: Value(note.timestampSeconds),
              noteText: Value(note.noteText),
              createdAt: Value(note.createdAt),
            ),
          );
      logger.info('Note ${note.id} updated');
    } catch (e, stackTrace) {
      errorHandler.handleError(
          'DriftVideoNoteService updateNote', e, stackTrace);
    }
  }

  @override
  FV deleteNote(int noteId) async {
    try {
      await (_db.delete(_db.videoNotes)..where((tbl) => tbl.id.equals(noteId)))
          .go();
      logger.info('Note $noteId deleted');
    } catch (e, stackTrace) {
      errorHandler.handleError(
          'DriftVideoNoteService deleteNote', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<VideoNoteEntity?> getNoteById(int noteId) async {
    try {
      final result = await (_db.select(_db.videoNotes)
            ..where((tbl) => tbl.id.equals(noteId)))
          .getSingleOrNull();

      return result != null ? _toVideoNoteEntity(result) : null;
    } catch (e, stackTrace) {
      errorHandler.handleError(
          'DriftVideoNoteService getNoteById', e, stackTrace);
      return null;
    }
  }

  /// Helper method to convert Drift VideoNote to VideoNoteEntity
  VideoNoteEntity _toVideoNoteEntity(VideoNote note) {
    return VideoNoteEntity(
      id: note.id,
      videoId: note.videoId,
      timestampSeconds: note.timestampSeconds,
      noteText: note.noteText,
      createdAt: note.createdAt,
    );
  }
}
