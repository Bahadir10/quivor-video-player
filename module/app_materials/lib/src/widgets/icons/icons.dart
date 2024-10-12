import 'package:flutter/material.dart';

// extension IconMaterialExtension on Icon {
//   Icon copyWith({
//     double? size,
//     Color? color,
//   }) =>
//       AppIcon(
//         icon,
//         size: size ?? this.size,
//         color: color ?? this.color,
//       );
// }

@immutable
final class AppIcons {
  const AppIcons._();

  static const Icon home = AppIcon(
    Icons.home,
  );
  static const Icon search = AppIcon(
    Icons.search,
  );
  static const Icon checked = AppIcon(
    Icons.check,
  );
  static const Icon favorite = AppIcon(
    Icons.bookmark,
  );
  static const Icon play = AppIcon(
    Icons.play_arrow,
  );
  static const Icon pause = AppIcon(
    Icons.pause,
  );
  static const Icon shuffle = AppIcon(
    Icons.shuffle,
  );
  static const Icon repeat = AppIcon(
    Icons.repeat,
  );
  static const Icon previous = AppIcon(
    Icons.skip_previous,
  );
  static const Icon next = AppIcon(
    Icons.skip_next,
  );

  static const Icon settings = AppIcon(
    Icons.settings,
  );
  static const Icon close = AppIcon(
    Icons.close,
  );

  static const Icon playlistAdd = AppIcon(
    Icons.playlist_add,
  );

  static const Icon skipNext = AppIcon(
    Icons.skip_next_rounded,
  );
  static const Icon backward10 = AppIcon(
    Icons.replay_10_rounded,
  );
  static const Icon skipPrevious = AppIcon(
    Icons.skip_previous_rounded,
  );
  static const Icon forward10 = AppIcon(
    Icons.forward_10,
  );
  static const Icon equalizer = AppIcon(
    Icons.equalizer,
  );
  static const Icon menu = AppIcon(
    Icons.menu,
  );

  static const Icon addBoxRounded = AppIcon(
    Icons.add_box_rounded,
  );

  static const Icon delete = AppIcon(
    Icons.delete,
  );
  static const Icon clear = AppIcon(
    Icons.clear,
  );
  static const Icon arrowDown = AppIcon(Icons.keyboard_arrow_down_sharp);

  static const Icon folderOpen = AppIcon(Icons.folder_open_rounded);
}

final class AppIcon extends Icon {
  const AppIcon(super.icon, {super.key, super.color = Colors.white});
}
