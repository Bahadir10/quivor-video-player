// ignore_for_file: public_member_api_docs, sort_constructors_first

final class Recent {
  final int id;
  final int videoId;
  const Recent({
    this.id = 0,
    required this.videoId,
  });

  Recent copyWith({
    int? id,
    int? videoId,
  }) {
    return Recent(
      id: id ?? this.id,
      videoId: videoId ?? this.videoId,
    );
  }

  @override
  String toString() {
    return 'Recent(id: $id, videoId: $videoId)';
  }
}
