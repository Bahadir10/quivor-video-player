// ignore_for_file: public_member_api_docs, sort_constructors_first

final class Playlist {
  final int id;
  final String name;
  const Playlist({
    this.id = 0,
    required this.name,
  });

  Playlist copyWith({
    int? id,
    String? name,
  }) {
    return Playlist(
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  String toString() {
    return 'Playlist(id: $id, name: $name)';
  }
}
