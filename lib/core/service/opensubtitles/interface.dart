import 'package:quivor/core/service/opensubtitles/implementation.dart';
import 'package:quivor/core/service/opensubtitles/xmlrpc_implementation.dart';
import 'package:quivor/core/service/opensubtitles/models.dart';

abstract class IOpenSubtitlesService {
  const IOpenSubtitlesService();

  Future<List<SubtitleSearchResult>> searchByFileName(String fileName,
      {String? language});
  Future<List<SubtitleSearchResult>> searchByHash(String hash,
      {String? language});
  Future<String> downloadSubtitle(String downloadUrl, String savePath);
  Future<String> calculateFileHash(String filePath);

  // Use XML-RPC API (legacy, like MPC) - No special API key needed!
  factory IOpenSubtitlesService.xmlrpc() => OpenSubtitlesXmlRpcService();

  // Use REST API (new) - Requires special API key permissions
  factory IOpenSubtitlesService.rest() => OpenSubtitlesService();

  // Default: Use REST API (modern, with your new API key)
  factory IOpenSubtitlesService.scoped() => OpenSubtitlesService();
}
