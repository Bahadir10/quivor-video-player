import "package:isar/isar.dart";

abstract class IISarEntity {
  final Id? id;
  const IISarEntity({this.id}); //: id = id ?? Isar.autoIncrement;
}
