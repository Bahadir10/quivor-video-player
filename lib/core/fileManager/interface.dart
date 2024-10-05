abstract class IFileManager {
  Future<({List<String> videoPaths, String mainDirectory})?> getVideoPaths();
  Future<String?> getVideoFile();
}
