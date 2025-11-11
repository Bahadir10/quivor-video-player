import 'package:quivor/core/service/logger/logger_service.dart';

class SubtitleSearchResult {
  final String id;
  final String language;
  final String movieName;
  final String fileName;
  final String downloadUrl;
  final double score;
  final int downloadCount;
  final String? release;

  SubtitleSearchResult({
    required this.id,
    required this.language,
    required this.movieName,
    required this.fileName,
    required this.downloadUrl,
    required this.score,
    required this.downloadCount,
    this.release,
  });

  factory SubtitleSearchResult.fromJson(Map<String, dynamic> json) {
    try {
      logger.debug(
          'Parsing subtitle JSON: ${json.toString().substring(0, 200)}...');

      final attributes = json['attributes'] as Map<String, dynamic>? ?? {};
      final files = attributes['files'] as List? ?? [];

      logger.debug('Files count: ${files.length}');

      final fileData = files.isNotEmpty ? files[0] as Map<String, dynamic> : {};

      // Get file_id for download - THIS IS CRITICAL!
      // According to API docs: attributes.files[0].file_id
      final fileId = fileData['file_id']?.toString() ?? '0';

      logger.debug('Extracted file_id: $fileId');

      if (fileId == '0') {
        logger.warning('file_id is 0, this will fail on download!');
        logger.debug('fileData: $fileData');
      }

      // Get language
      final language = attributes['language'] as String? ?? 'en';

      // Get movie name from feature_details or release
      String movieName = 'Unknown';
      if (attributes['feature_details'] != null) {
        final featureDetails =
            attributes['feature_details'] as Map<String, dynamic>;
        movieName = featureDetails['movie_name'] as String? ??
            featureDetails['title'] as String? ??
            'Unknown';
      }

      // Get file name
      final fileName = fileData['file_name'] as String? ??
          attributes['release'] as String? ??
          'subtitle.srt';

      // Get ratings (can be double or int)
      double score = 0.0;
      if (attributes['ratings'] != null) {
        score = (attributes['ratings'] as num).toDouble();
      }

      // Get download count
      final downloadCount = attributes['download_count'] as int? ?? 0;

      return SubtitleSearchResult(
        id: fileId,
        language: language,
        movieName: movieName,
        fileName: fileName,
        downloadUrl: fileId, // Use file_id for download
        score: score,
        downloadCount: downloadCount,
        release: attributes['release'] as String?,
      );
    } catch (e) {
      logger.error('Error parsing subtitle result: $e');
      logger.debug('Full JSON: $json');
      rethrow;
    }
  }
}
