import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:quivor/core/fileManager/interface.dart';

class FileManager extends IFileManager {
  @override
  Future<({List<String> videoPaths, String mainDirectory})?>
      getVideoPaths() async {
    List<String> playlists = [];

    List<Directory> directories1 = [];
    String? selectedDirectory = await FilePicker.platform.getDirectoryPath();
    //print(selectedDirectory);

    if (selectedDirectory != null) {
      final directory = Directory(selectedDirectory);
      directories1.add(directory);
      while (directories1.isNotEmpty) {
        final directories = [...directories1];
        directories1 = [];

        for (final dirx in directories) {
          await for (var entity in dirx.list(
            recursive: true,
            followLinks: false,
          )) {
            final dir = Directory(entity.path);

            if (dir.existsSync()) {
              directories1.add(dir);
            }

            if (entity.path.endsWith('.mp4')) {
              playlists.add(entity.path);
            }
          }
        }
      }
      final rec = (videoPaths: playlists, mainDirectory: selectedDirectory);
      return rec;
    } else {
      return null;
    }
  }

  @override
  Future<String?> getVideoFile() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.video,
      // allowMultiple: true,
    );
    if (result != null) {
      return result.files.first.path;
    } else {
      return null;
    }
  }
}
