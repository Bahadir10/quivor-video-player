// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';

import 'package:quivor/core/models/entities/interface/isar_entity.dart';

part 'playlist.g.dart';

@collection
final class Playlist extends IISarEntity {
  final Id id;
  final String name;
  const Playlist({
    this.id = Isar.autoIncrement,
    required this.name,
  });

  Playlist copyWith({
    String? name,
  }) {
    return Playlist(
      name: name ?? this.name,
    );
  }
}
