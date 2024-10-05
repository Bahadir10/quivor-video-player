import 'package:media_kit_video/media_kit_video.dart';
import 'package:nexor/nexor.dart';
import 'package:quivor/core/models/entities/recent.dart';
import 'package:quivor/core/models/entities/video.dart';

abstract class IVideoService {
  //Future addSingleItemtoPlaylist(String path);
  //Future addMultipleItemsToPlaylist(String path);
  Future<VideoEntity> createVideo(
      {required String name, required String path, int? playlistId});
  Future createRecent(VideoEntity entity);
  Future<List<VideoEntity>> recentVideos();
  Future<List<VideoEntity>> playlistVideos(int playlistId);
  Future<List<VideoEntity>> videos();
  FV updateVideo(VideoEntity entity);
  Future<List<VideoEntity>> searchVideo(String input);
  Future<VideoEntity?> getVideoByPathOrNull(String path);
}
