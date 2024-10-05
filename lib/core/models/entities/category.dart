// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:isar/isar.dart';
import 'package:quivor/core/models/entities/interface/isar_entity.dart';
part 'category.g.dart';

@collection
final class Category extends IISarEntity {
  final Id id;
  final String name;
  final int icon;
  const Category({
    this.id = Isar.autoIncrement,
    required this.name,
    required this.icon,
  });
}
