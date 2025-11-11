// ignore_for_file: public_member_api_docs, sort_constructors_first

final class Category {
  final int id;
  final String name;
  final int icon;
  const Category({
    this.id = 0,
    required this.name,
    required this.icon,
  });

  Category copyWith({
    int? id,
    String? name,
    int? icon,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      icon: icon ?? this.icon,
    );
  }

  @override
  String toString() {
    return 'Category(id: $id, name: $name, icon: $icon)';
  }
}
