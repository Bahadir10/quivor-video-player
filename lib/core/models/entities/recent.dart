// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';
import 'package:quivor/core/models/entities/interface/isar_entity.dart';
part 'recent.g.dart';

@collection
final class Recent extends IISarEntity {
  final Id id;
  final int videoId;
  Recent({
    this.id = Isar.autoIncrement,
    required this.videoId,
  });
}
