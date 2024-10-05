import 'package:flutter/material.dart';

// extension IconMaterialExtension on Icon {
//   Icon copyWith({
//     double? size,
//     Color? color,
//   }) =>
//       Icon(
//         icon,
//         size: size ?? this.size,
//         color: color ?? this.color,
//       );
// }

@immutable
final class AppIcons {
  const AppIcons._();
  static const _color = Colors.white;
  static const Icon home = Icon(Icons.home);
  static const Icon search = Icon(Icons.search);
  static const Icon checked = Icon(
    Icons.check,
    color: _color,
  );
  static const Icon favorite = Icon(Icons.bookmark);
  static const Icon play = Icon(
    Icons.play_arrow,
    color: _color,
  );
  static const Icon pause = Icon(Icons.pause);
  static const Icon shuffle = Icon(Icons.shuffle);
  static const Icon repeat = Icon(Icons.repeat);
  static const Icon previous = Icon(Icons.skip_previous);
  static const Icon next = Icon(Icons.skip_next);
  static const Icon repeat_one = Icon(Icons.repeat_one);
  //static const Icon repeat_all = Icon(Icons.repeat_all);
  static const Icon settings = Icon(Icons.settings);
  static const Icon close = Icon(Icons.close);
  static const Icon volume_up = Icon(Icons.volume_up);
  static const Icon volume_down = Icon(Icons.volume_down);
  static const Icon volume_mute = Icon(Icons.volume_mute);
  static const Icon playlistAdd = Icon(
    Icons.playlist_add,
    color: _color,
  );
  static const Icon playlist_remove = Icon(Icons.playlist_remove);
  static const Icon playlist_play = Icon(Icons.playlist_play);
  static const Icon skipNext = Icon(
    Icons.skip_next_rounded,
    color: _color,
  );
  static const Icon backward10 = Icon(
    Icons.replay_10_rounded,
    color: _color,
  );
  static const Icon skipPrevious = Icon(
    Icons.skip_previous_rounded,
    color: _color,
  );
  static const Icon forward10 = Icon(
    Icons.forward_10,
    color: _color,
  );
  static const Icon equalizer = Icon(
    Icons.equalizer,
    color: _color,
  );
  static const Icon menu = Icon(
    Icons.menu,
    color: _color,
  );

  static const Icon addBoxRounded = Icon(
    Icons.add_box_rounded,
    color: _color,
  );
}
