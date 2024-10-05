import 'package:nexor/src/core/ientity.dart';

extension IEntityExtension<T extends IEntity> on List<T> {
  T findById(int id) => firstWhere((e) => e.id == id);
  void removeById(int id) => removeWhere((element) => element.id == id);

  void update(T entity) {
    final e = indexWhere((element) => element.id == entity.id);
    removeAt(e);
    insert(e, entity);
  }
}
