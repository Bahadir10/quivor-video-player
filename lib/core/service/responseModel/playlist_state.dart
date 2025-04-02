// ignore_for_file: public_member_api_docs, sort_constructors_first
final class PlaylistStateResponseModel {
  final int watchedCount;
  final int length;
  final double progressPercentage;
  final int id;
  final String name;
  PlaylistStateResponseModel({
    required this.watchedCount,
    required this.length,
    required this.progressPercentage,
    required this.id,
    required this.name,
  });

  PlaylistStateResponseModel copyWith({
    int? watchedCount,
    int? length,
    double? progressPercentage,
    int? id,
    String? name,
  }) {
    return PlaylistStateResponseModel(
      watchedCount: watchedCount ?? this.watchedCount,
      length: length ?? this.length,
      progressPercentage: progressPercentage ?? this.progressPercentage,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }
}
