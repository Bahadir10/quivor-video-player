import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

import 'package:media_kit/media_kit.dart'; // Provides [Player], [Media], [Playlist] etc.
import 'package:media_kit_video/media_kit_video.dart';
import 'package:nexor/nexor.dart';
import 'package:path/path.dart' as p;
import 'package:quivor/core/enum/standarts.dart';
import 'package:quivor/intialize.dart';
import 'package:quivor/views/createPlaylist/create_playlist.dart';
import 'package:quivor/views/home/home.dart';

Future<void> main() async {
  await AppInitialize().run();
  runApp(const Quivor());
}

class Quivor extends StatefulWidget {
  const Quivor({super.key});

  @override
  State<Quivor> createState() => _QuivorState();
}

class _QuivorState extends State<Quivor> {
  FilePickerResult? result;
//  VideoPlayerController? controller;
  late final Player player = Player();

  late final VideoController controller = VideoController(
    player,
  );

  List<String> playlist = [];

  @override
  Widget build(BuildContext context) {
    final t = Size(5, 5).widgetStatePropertyAll();

    var scaffold = Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // result = await FilePicker.platform.pickFiles(
          //   type: FileType.any,
          //   // allowMultiple: true,
          // );
          List<Directory> directories1 = [];
          String? selectedDirectory =
              await FilePicker.platform.getDirectoryPath();
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
                    playlist.add(entity.path);
                  }
                }
              }
            }
          }

          // await for (var entity in directory.list(
          //     recursive: true,
          //     followLinks: false,
          //   )) {
          //     final dir = Directory(entity.path);
          //     // print('x: ' + dir.existsSync().toString());
          //     if (dir.existsSync()) {
          //       print(dir.path + ' exist');
          //     }
          //     //if(entity.exists())
          //     if (entity.path.endsWith('.mp4')) {
          //       playlist.add(entity.path);
          //       //print('Adding: ${entity.path} to playlist');
          //     }
          //   }

          await player.open(Media(playlist.first));
          final first = playlist.first;
          final z = first.lastIndexOf('.');
          final y = first.substring(0, z);
          final res = y + '.srt';
          await player.setSubtitleTrack(SubtitleTrack.data(res));
          // print(result.toString());
          setState(() {});
          if (1 == 0) {
            player.open(Media(result!.files.first.path!));
            PlatformFile x = result!.files.first;
            PlatformFile(
              name: result!.names.first!,
              size: result!.files.first.size,
            );
            String path = result!.files.first.path!;
            final z = path.lastIndexOf('.');
            final y = path.substring(0, z);
            final res = y + '.srt';
            //print('res: $res');
            //final String? subtitle = result!.files.first.extension;

            // player.setSubtitleTrack(SubtitleTrack.data())
          }
        },
      ),
      body: ListView(
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.width * 9.0 / 16.0,
            // Use [Video] widget to display video output.
            child: Video(
              controller: controller,
              subtitleViewConfiguration: SubtitleViewConfiguration(),
            ),
          ),
          for (final x in playlist) _item(x)
        ],
      ),
    );
    final standarts = {
      Standarts.low.name: Standarts.low.value,
      Standarts.small.name: Standarts.small.value,
      Standarts.medium.name: Standarts.medium.value,
      Standarts.high.name: Standarts.high.value,
    };
    return MaterialApp(
      theme: ThemeData(
          extensions: [NexorSpacerThemeExtension(standarts: standarts)],
          scaffoldBackgroundColor: Color(0xFF161616)),
      home: HomeScreen(),
    );
  }

  Widget _item(String x) {
    File file = File(x);
    String basename = p.basename(file.path);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
          onTap: () async {
            await player.open(Media(x));
          },
          child: Column(children: [Text(basename), Divider()])),
    );
  }
}
