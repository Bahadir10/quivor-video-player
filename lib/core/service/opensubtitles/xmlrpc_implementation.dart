import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:quivor/core/service/opensubtitles/interface.dart';
import 'package:quivor/core/service/opensubtitles/models.dart';
import 'package:archive/archive.dart';
import 'package:quivor/core/service/logger/logger_service.dart';

/// OpenSubtitles XML-RPC API Implementation (Legacy - like MPC)
/// This uses the old API which doesn't require special API key permissions
class OpenSubtitlesXmlRpcService extends IOpenSubtitlesService {
  static const String _baseUrl = 'https://api.opensubtitles.org/xml-rpc';
  static const String _userAgent = 'TemporaryUserAgent';
  String? _token;

  Future<void> _login() async {
    if (_token != null) return;

    try {
      final xmlRequest = '''<?xml version="1.0"?>
<methodCall>
  <methodName>LogIn</methodName>
  <params>
    <param><value><string></string></value></param>
    <param><value><string></string></value></param>
    <param><value><string>en</string></value></param>
    <param><value><string>$_userAgent</string></value></param>
  </params>
</methodCall>''';

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'text/xml'},
        body: xmlRequest,
      );

      if (response.statusCode == 200) {
        // Parse XML response to get token
        final tokenMatch =
            RegExp(r'<name>token</name>\s*<value><string>([^<]+)</string>')
                .firstMatch(response.body);

        if (tokenMatch != null) {
          _token = tokenMatch.group(1);
          logger.info('XML-RPC Login successful, token: $_token');
        } else {
          throw Exception('Failed to extract token from response');
        }
      } else {
        throw Exception('Login failed: ${response.statusCode}');
      }
    } catch (e) {
      logger.error('XML-RPC Login error: $e');
      rethrow;
    }
  }

  @override
  Future<List<SubtitleSearchResult>> searchByFileName(String fileName,
      {String? language}) async {
    await _login();

    try {
      final lang = language ?? 'all';
      final query = path.basenameWithoutExtension(fileName);

      final xmlRequest = '''<?xml version="1.0"?>
<methodCall>
  <methodName>SearchSubtitles</methodName>
  <params>
    <param><value><string>$_token</string></value></param>
    <param>
      <value>
        <array>
          <data>
            <value>
              <struct>
                <member>
                  <name>sublanguageid</name>
                  <value><string>$lang</string></value>
                </member>
                <member>
                  <name>query</name>
                  <value><string>$query</string></value>
                </member>
              </struct>
            </value>
          </data>
        </array>
      </value>
    </param>
    <param>
      <value>
        <struct>
          <member>
            <name>limit</name>
            <value><int>100</int></value>
          </member>
        </struct>
      </value>
    </param>
  </params>
</methodCall>''';

      logger.debug('XML-RPC Search request for: $query');

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'text/xml'},
        body: xmlRequest,
      );

      logger.debug('XML-RPC Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        return _parseXmlResponse(response.body);
      } else {
        throw Exception('Search failed: ${response.statusCode}');
      }
    } catch (e) {
      logger.error('XML-RPC Search error: $e');
      return [];
    }
  }

  @override
  Future<List<SubtitleSearchResult>> searchByHash(String hash,
      {String? language}) async {
    await _login();

    try {
      final lang = language ?? 'all';

      final xmlRequest = '''<?xml version="1.0"?>
<methodCall>
  <methodName>SearchSubtitles</methodName>
  <params>
    <param><value><string>$_token</string></value></param>
    <param>
      <value>
        <array>
          <data>
            <value>
              <struct>
                <member>
                  <name>sublanguageid</name>
                  <value><string>$lang</string></value>
                </member>
                <member>
                  <name>moviehash</name>
                  <value><string>$hash</string></value>
                </member>
              </struct>
            </value>
          </data>
        </array>
      </value>
    </param>
    <param>
      <value>
        <struct>
          <member>
            <name>limit</name>
            <value><int>100</int></value>
          </member>
        </struct>
      </value>
    </param>
  </params>
</methodCall>''';

      logger.debug('XML-RPC Search by hash: $hash');

      final response = await http.post(
        Uri.parse(_baseUrl),
        headers: {'Content-Type': 'text/xml'},
        body: xmlRequest,
      );

      logger.debug('XML-RPC Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        return _parseXmlResponse(response.body);
      } else {
        throw Exception('Search failed: ${response.statusCode}');
      }
    } catch (e) {
      logger.error('XML-RPC Search by hash error: $e');
      return [];
    }
  }

  List<SubtitleSearchResult> _parseXmlResponse(String xml) {
    final results = <SubtitleSearchResult>[];

    try {
      // Simple regex parsing (you might want to use a proper XML parser)
      final dataMatches =
          RegExp(r'<struct>(.*?)</struct>', dotAll: true).allMatches(xml);

      for (final match in dataMatches) {
        final structXml = match.group(1) ?? '';

        // Extract fields
        final idMatch = RegExp(
                r'<name>IDSubtitleFile</name>\s*<value><string>([^<]+)</string>')
            .firstMatch(structXml);
        final fileNameMatch = RegExp(
                r'<name>SubFileName</name>\s*<value><string>([^<]+)</string>')
            .firstMatch(structXml);
        final langMatch = RegExp(
                r'<name>SubLanguageID</name>\s*<value><string>([^<]+)</string>')
            .firstMatch(structXml);
        final downloadLinkMatch = RegExp(
                r'<name>SubDownloadLink</name>\s*<value><string>([^<]+)</string>')
            .firstMatch(structXml);
        final movieNameMatch =
            RegExp(r'<name>MovieName</name>\s*<value><string>([^<]+)</string>')
                .firstMatch(structXml);
        final downloadCountMatch = RegExp(
                r'<name>SubDownloadsCnt</name>\s*<value><string>([^<]+)</string>')
            .firstMatch(structXml);

        if (idMatch != null && fileNameMatch != null) {
          results.add(SubtitleSearchResult(
            id: idMatch.group(1)!,
            language: langMatch?.group(1) ?? 'en',
            movieName: movieNameMatch?.group(1) ?? 'Unknown',
            fileName: fileNameMatch.group(1)!,
            downloadUrl: downloadLinkMatch?.group(1) ?? '',
            score: 0.0,
            downloadCount:
                int.tryParse(downloadCountMatch?.group(1) ?? '0') ?? 0,
          ));
        }
      }

      logger.info('Parsed ${results.length} results from XML');
    } catch (e) {
      logger.error('Error parsing XML response: $e');
    }

    return results;
  }

  @override
  Future<String> downloadSubtitle(String downloadUrl, String savePath) async {
    try {
      logger.debug('Downloading from: $downloadUrl');

      final response = await http.get(Uri.parse(downloadUrl));

      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;

        // XML-RPC API returns gzipped files
        if (downloadUrl.endsWith('.gz') ||
            bytes[0] == 0x1f && bytes[1] == 0x8b) {
          final archive = GZipDecoder().decodeBytes(bytes);
          await File(savePath).writeAsBytes(archive);
        } else {
          await File(savePath).writeAsBytes(bytes);
        }

        logger.info('Subtitle saved to: $savePath');
        return savePath;
      } else {
        throw Exception('Download failed: ${response.statusCode}');
      }
    } catch (e) {
      logger.error('Download error: $e');
      rethrow;
    }
  }

  @override
  Future<String> calculateFileHash(String filePath) async {
    try {
      final file = File(filePath);
      final fileSize = await file.length();

      if (fileSize < 65536) {
        throw Exception('File too small to calculate hash');
      }

      final raf = await file.open();
      final first64KB = await raf.read(65536);
      await raf.setPosition(fileSize - 65536);
      final last64KB = await raf.read(65536);
      await raf.close();

      int hash = fileSize;

      for (int i = 0; i < 65536; i += 8) {
        hash += _bytesToInt64(first64KB, i);
        hash = hash & 0xFFFFFFFFFFFFFFFF;
      }

      for (int i = 0; i < 65536; i += 8) {
        hash += _bytesToInt64(last64KB, i);
        hash = hash & 0xFFFFFFFFFFFFFFFF;
      }

      return hash.toRadixString(16).padLeft(16, '0');
    } catch (e) {
      logger.error('Error calculating file hash: $e');
      rethrow;
    }
  }

  int _bytesToInt64(List<int> bytes, int offset) {
    int value = 0;
    for (int i = 0; i < 8 && offset + i < bytes.length; i++) {
      value += (bytes[offset + i] & 0xFF) << (i * 8);
    }
    return value;
  }
}
