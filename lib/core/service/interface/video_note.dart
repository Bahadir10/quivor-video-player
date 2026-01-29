import 'package:nexor/nexor.dart';
import 'package:quivor/core/models/entities/video_note.dart';

abstract class IVideoNoteService {
  const IVideoNoteService();

  Future<VideoNoteEntity> createNote({
    required int videoId,
    required int timestampSeconds,
    required String noteText,
  });

  Future<List<VideoNoteEntity>> getNotesForVideo(int videoId);

  FV updateNote(VideoNoteEntity note);

  FV deleteNote(int noteId);

  Future<VideoNoteEntity?> getNoteById(int noteId);
}
