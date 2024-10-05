import 'package:isar/isar.dart';
import 'package:nexor/nexor.dart';
import 'package:quivor/core/models/entities/recent.dart';
import 'package:quivor/core/models/entities/video.dart';
import 'package:quivor/core/service/interface/video.dart';
import 'package:quivor/intialize.dart';

final class IsarVideoService extends IVideoService {
  @override
  Future createRecent(VideoEntity entity) async {
    final videoId = entity.id;
    final recent = Recent(videoId: videoId);
    final check =
        await isar.recents.filter().videoIdEqualTo(videoId).findFirst();

    if (check != null) {
      await isar.writeTxn(() async {
        await isar.recents.delete(check.id);
      });
    }
    await isar.writeTxn(() async {
      await isar.recents.put(recent);
    });
  }

  @override
  Future<VideoEntity> createVideo(
      {required String name, required String path, int? playlistId}) async {
    var video = VideoEntity(name: name, path: path, playlistId: playlistId);

    video = await isar.writeTxn<VideoEntity>(() async {
      final id = await isar.videoEntitys.put(video);
      return VideoEntity(
          name: name, path: path, playlistId: playlistId, id: id);
    });
    return video;
  }

  @override
  Future<List<VideoEntity>> recentVideos() async {
    final recents = await isar.recents.where().findAll();
    final ids = recents.map((x) => x.videoId).toList();
    final videos = await isar.videoEntitys.getAll(ids);
    final result = videos.where((x) => x != null).cast<VideoEntity>().toList();
    result.sort((a, b) => b.id.compareTo(a.id));
    return result;
  }

  @override
  Future<List<VideoEntity>> playlistVideos(int playlistId) async {
    return await isar.videoEntitys
        .filter()
        .playlistIdEqualTo(playlistId)
        .findAll();
  }

  @override
  Future<List<VideoEntity>> videos() async {
    final x = await isar.videoEntitys.where().findAll();

    return x;
  }

  @override
  FV updateVideo(VideoEntity entity) async {
    await isar.writeTxn(() async {
      await isar.videoEntitys.put(entity);
    });
  }

  @override
  Future<List<VideoEntity>> searchVideo(String input) async {
    return await isar.videoEntitys
        .filter()
        .nameContains(input, caseSensitive: false)
        .findAll();
  }

  @override
  Future<VideoEntity?> getVideoByPathOrNull(String path) async {
    return await isar.videoEntitys.filter().pathEqualTo(path).findFirst();
  }
}
