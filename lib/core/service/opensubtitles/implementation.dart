import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as path;
import 'package:quivor/core/service/opensubtitles/interface.dart';
import 'package:quivor/core/service/opensubtitles/models.dart';
import 'package:archive/archive.dart';
import 'package:quivor/core/service/logger/logger_service.dart';
import 'package:quivor/core/service/error/error_handler.dart';
import 'package:quivor/core/service/env/env_config_service.dart';

class OpenSubtitlesService extends IOpenSubtitlesService {
  Future<Map<String, String>> get _headers async {
    final authToken = await envConfig.getAuthToken();

    final headers = {
      'Api-Key': envConfig.apiKey,
      'Content-Type': 'application/json',
      'User-Agent': envConfig.userAgent,
      'Accept': 'application/json',
    };

    if (authToken != null && authToken.isNotEmpty) {
      headers['Authorization'] = 'Bearer $authToken';
    }

    return headers;
  }

  @override
  Future<List<SubtitleSearchResult>> searchByFileName(String fileName,
      {String? language}) async {
    try {
      final queryParams = {
        'languages': language,
        'query': path.basenameWithoutExtension(fileName),
      };

      final uri = Uri.parse('${envConfig.baseUrl}/subtitles').replace(
        queryParameters: queryParams,
      );

      logger.debug('Searching subtitles: $uri');
      final headers = await _headers;
      final response = await http.get(uri, headers: headers);
      logger.debug('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = (data['data'] as List)
            .map((item) => SubtitleSearchResult.fromJson(item))
            .toList();
        logger.info('Found ${results.length} subtitles for: $fileName');
        return results;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        final error = Exception(
            'Authentication failed. Please check your API key. Status: ${response.statusCode}');
        errorHandler.handleError('OpenSubtitles searchByFileName', error);
        throw error;
      } else {
        final error =
            Exception('Failed to search subtitles: ${response.statusCode}');
        errorHandler.handleError('OpenSubtitles searchByFileName', error);
        throw error;
      }
    } catch (e, stackTrace) {
      errorHandler.handleError('OpenSubtitles searchByFileName', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<List<SubtitleSearchResult>> searchByHash(String hash,
      {String? language}) async {
    try {
      final queryParams = {
        'moviehash': hash,
        //if (language != null) 'languages': 'Turkish',
      };

      final uri = Uri.parse('${envConfig.baseUrl}/subtitles').replace(
        queryParameters: queryParams,
      );

      logger.debug('Searching by hash: $uri');
      final headers = await _headers;
      final response = await http.get(uri, headers: headers);
      logger.debug('Response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = (data['data'] as List)
            .map((item) => SubtitleSearchResult.fromJson(item))
            .toList();
        logger.info('Found ${results.length} subtitles by hash: $hash');
        return results;
      } else if (response.statusCode == 401 || response.statusCode == 403) {
        final error = Exception(
            'Authentication failed. Please check your API key. Status: ${response.statusCode}');
        errorHandler.handleError('OpenSubtitles searchByHash', error);
        throw error;
      } else {
        final error =
            Exception('Failed to search subtitles: ${response.statusCode}');
        errorHandler.handleError('OpenSubtitles searchByHash', error);
        throw error;
      }
    } catch (e, stackTrace) {
      errorHandler.handleError('OpenSubtitles searchByHash', e, stackTrace);
      rethrow;
    }
  }

  @override
  Future<String> downloadSubtitle(String fileId, String savePath) async {
    try {
      logger.debug('Downloading subtitle with file_id: $fileId');

      final headers = await _headers;

      // Request download link - correct endpoint
      final downloadResponse = await http.post(
        Uri.parse('${envConfig.baseUrl}/download'),
        headers: headers,
        body: json.encode({'file_id': int.parse(fileId)}),
      );

      logger.debug('Download response status: ${downloadResponse.statusCode}');

      if (downloadResponse.statusCode == 200) {
        final downloadData = json.decode(downloadResponse.body);
        final link = downloadData['link'] as String;

        logger.debug('Download link obtained');

        // Download the file
        final fileResponse = await http.get(Uri.parse(link));

        if (fileResponse.statusCode == 200) {
          final bytes = fileResponse.bodyBytes;

          // Check if it's a gzip file and extract
          if (link.endsWith('.gz')) {
            final archive = GZipDecoder().decodeBytes(bytes);
            await File(savePath).writeAsBytes(archive);
          } else {
            await File(savePath).writeAsBytes(bytes);
          }

          logger.info('Subtitle saved to: $savePath');
          return savePath;
        } else {
          final error = Exception(
              'Failed to download subtitle file: ${fileResponse.statusCode}');
          errorHandler.handleError('OpenSubtitles downloadSubtitle', error);
          throw error;
        }
      } else if (downloadResponse.statusCode == 406) {
        final error = Exception(
            'Download limit exceeded. Please wait or upgrade to VIP.');
        errorHandler.handleError('OpenSubtitles downloadSubtitle', error);
        throw error;
      } else {
        final error = Exception(
            'Failed to get download link: ${downloadResponse.statusCode}');
        errorHandler.handleError('OpenSubtitles downloadSubtitle', error);
        throw error;
      }
    } catch (e, stackTrace) {
      errorHandler.handleError('OpenSubtitles downloadSubtitle', e, stackTrace);
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

      // Read first and last 64KB
      final raf = await file.open();
      final first64KB = await raf.read(65536);
      await raf.setPosition(fileSize - 65536);
      final last64KB = await raf.read(65536);
      await raf.close();

      // Calculate hash (OpenSubtitles hash algorithm)
      int hash = fileSize;

      // Process first 64KB
      for (int i = 0; i < 65536; i += 8) {
        hash += _bytesToInt64(first64KB, i);
        hash = hash & 0xFFFFFFFFFFFFFFFF;
      }

      // Process last 64KB
      for (int i = 0; i < 65536; i += 8) {
        hash += _bytesToInt64(last64KB, i);
        hash = hash & 0xFFFFFFFFFFFFFFFF;
      }

      return hash.toRadixString(16).padLeft(16, '0');
    } catch (e, stackTrace) {
      errorHandler.handleError(
          'OpenSubtitles calculateFileHash', e, stackTrace);
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

  /// Login to OpenSubtitles and get authentication token
  Future<String> login(String username, String password) async {
    try {
      logger.debug('Attempting to login to OpenSubtitles');

      final headers = {
        'Api-Key': envConfig.apiKey,
        'Content-Type': 'application/json',
        'User-Agent': envConfig.userAgent,
        'Accept': 'application/json',
      };

      final response = await http.post(
        Uri.parse('${envConfig.baseUrl}/login'),
        headers: headers,
        body: json.encode({
          'username': username,
          'password': password,
        }),
      );

      logger.debug('Login response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final token = data['token'] as String;

        // Save token to secure storage
        await envConfig.saveAuthToken(token);

        logger.info('Successfully logged in to OpenSubtitles');
        return token;
      } else if (response.statusCode == 401) {
        final error = Exception('Invalid username or password');
        errorHandler.handleError('OpenSubtitles login', error);
        throw error;
      } else {
        final data = json.decode(response.body);
        final message = data['message'] ?? 'Login failed';
        final error = Exception(message);
        errorHandler.handleError('OpenSubtitles login', error);
        throw error;
      }
    } catch (e, stackTrace) {
      errorHandler.handleError('OpenSubtitles login', e, stackTrace);
      rethrow;
    }
  }

  /// Test the current authentication
  Future<Map<String, dynamic>> testAuthentication() async {
    try {
      logger.debug('Testing OpenSubtitles authentication');

      final headers = await _headers;
      final response = await http.get(
        Uri.parse('${envConfig.baseUrl}/infos/user'),
        headers: headers,
      );

      logger.debug('Test auth response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        logger.info('Authentication test successful');
        return data['data'] as Map<String, dynamic>;
      } else if (response.statusCode == 401) {
        final error =
            Exception('Authentication failed. Please check your credentials.');
        errorHandler.handleError('OpenSubtitles testAuthentication', error);
        throw error;
      } else {
        final error =
            Exception('Failed to test authentication: ${response.statusCode}');
        errorHandler.handleError('OpenSubtitles testAuthentication', error);
        throw error;
      }
    } catch (e, stackTrace) {
      errorHandler.handleError(
          'OpenSubtitles testAuthentication', e, stackTrace);
      rethrow;
    }
  }
}
