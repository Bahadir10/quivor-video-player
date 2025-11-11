part of '../play.dart';

class _SubtitleSearchDialog extends StatefulWidget {
  final String videoPath;
  final String videoName;
  final IVideoPlayerManager playerManager;

  const _SubtitleSearchDialog({
    required this.videoPath,
    required this.videoName,
    required this.playerManager,
  });

  @override
  State<_SubtitleSearchDialog> createState() => _SubtitleSearchDialogState();
}

class _SubtitleSearchDialogState extends State<_SubtitleSearchDialog> {
  final IOpenSubtitlesService _subtitleService = IOpenSubtitlesService.scoped();
  List<SubtitleSearchResult> _results = [];
  bool _isLoading = false;
  String _selectedLanguage = 'en';
  bool _searchByHash = true;

  final List<Map<String, String>> _languages = [
    {'code': 'en', 'name': 'English'},
    {'code': 'es', 'name': 'Spanish'},
    {'code': 'fr', 'name': 'French'},
    {'code': 'de', 'name': 'German'},
    {'code': 'it', 'name': 'Italian'},
    {'code': 'pt', 'name': 'Portuguese'},
    {'code': 'ru', 'name': 'Russian'},
    {'code': 'ja', 'name': 'Japanese'},
    {'code': 'ko', 'name': 'Korean'},
    {'code': 'zh', 'name': 'Chinese'},
    {'code': 'ar', 'name': 'Arabic'},
    {'code': 'tr', 'name': 'Turkish'},
  ];

  @override
  void initState() {
    super.initState();
    _searchSubtitles();
  }

  Future<void> _searchSubtitles() async {
    setState(() {
      _isLoading = true;
      _results = [];
    });

    try {
      List<SubtitleSearchResult> results;

      if (_searchByHash) {
        final hash = await _subtitleService.calculateFileHash(widget.videoPath);
        results = await _subtitleService.searchByHash(
          hash,
          language: _selectedLanguage,
        );
      } else {
        results = await _subtitleService.searchByFileName(
          widget.videoName,
          language: _selectedLanguage,
        );
      }

      setState(() {
        _results = results;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: SingleChildScrollView(
              child: Text(
                'Error searching subtitles:\n\n$e\n\nPlease check:\n'
                '1. Your API key is valid\n'
                '2. You have internet connection\n'
                '3. API rate limits not exceeded',
                style: const TextStyle(fontSize: 12),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  Future<void> _downloadAndLoadSubtitle(SubtitleSearchResult subtitle) async {
    try {
      logger.debug('Starting download for subtitle: ${subtitle.fileName}');
      logger.debug('File ID: ${subtitle.downloadUrl}');

      final tempDir = await getTemporaryDirectory();
      final savePath = path.join(tempDir.path, subtitle.fileName);

      // Show loading
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Downloading ${subtitle.fileName}...'),
            duration: const Duration(seconds: 2),
          ),
        );
      }

      // Download subtitle using file_id
      await _subtitleService.downloadSubtitle(subtitle.downloadUrl, savePath);

      logger.info('Subtitle downloaded to: $savePath');

      // Load into player
      await widget.playerManager.loadExternalSubtitle(savePath);

      logger.info('Subtitle loaded into player');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Subtitle loaded successfully! ✓'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.of(context).pop();
      }
    } catch (e) {
      logger.error('Error in _downloadAndLoadSubtitle: $e');
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            backgroundColor: AppColors.black2,
            title: const Row(
              children: [
                Icon(Icons.error_outline, color: Colors.red),
                SizedBox(width: 8),
                Text('Download Failed'),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Error: $e'),
                  const SizedBox(height: 16),
                  const Text(
                    'Possible reasons:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text('• Download limit exceeded (200/day)'),
                  const Text('• Invalid API key'),
                  const Text('• Network connection issue'),
                  const SizedBox(height: 16),
                  const Text(
                    'Try using "Load Local File" instead.',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.black2,
      child: Container(
        width: context.width * 0.7,
        height: context.height * 0.8,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              children: [
                const Icon(Icons.subtitles, size: 28),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Search Subtitles',
                    style: AppTypography.headingMedium,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Search options
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.black1,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Video: ${widget.videoName}',
                    style: AppTypography.bodyMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: CustomDropdown<String>(
                          width: double.infinity,
                          enableSearch: false,
                          hintText: 'Language',
                          initialSelection: _selectedLanguage,
                          onSelected: (value) {
                            if (value != null) {
                              setState(() => _selectedLanguage = value);
                              _searchSubtitles();
                            }
                          },
                          dropdownMenuEntries: _languages
                              .map((lang) => DropdownMenuEntry(
                                    value: lang['code']!,
                                    label: lang['name']!,
                                  ))
                              .toList(),
                        ),
                      ),
                      const SizedBox(width: 12),
                      ElevatedButton.icon(
                        onPressed: _searchSubtitles,
                        icon: const Icon(Icons.refresh),
                        label: const Text('Refresh'),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Checkbox(
                        value: _searchByHash,
                        onChanged: (value) {
                          setState(() => _searchByHash = value ?? true);
                          _searchSubtitles();
                        },
                      ),
                      const Text('Search by file hash (more accurate)'),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Results
            Expanded(
              child: _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : _results.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.search_off,
                                  size: 64, color: AppColors.grey1),
                              const SizedBox(height: 16),
                              Text(
                                'No subtitles found',
                                style: AppTypography.bodyLarge,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Try changing the language or search method',
                                style: AppTypography.bodySmall
                                    .copyWith(color: AppColors.grey1),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: _results.length,
                          itemBuilder: (context, index) {
                            final subtitle = _results[index];
                            return Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              decoration: BoxDecoration(
                                color: AppColors.black1,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: AppColors.grey1.withOpacity(0.2),
                                ),
                              ),
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(8),
                                  onTap: () =>
                                      _downloadAndLoadSubtitle(subtitle),
                                  child: Padding(
                                    padding: const EdgeInsets.all(12),
                                    child: Row(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color: AppColors.white1
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Text(
                                            subtitle.language.toUpperCase(),
                                            style: AppTypography.bodySmall
                                                .copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 12),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                subtitle.fileName,
                                                style: AppTypography.bodyMedium
                                                    .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                              const SizedBox(height: 4),
                                              Row(
                                                children: [
                                                  Icon(Icons.download,
                                                      size: 14,
                                                      color: AppColors.grey1),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    '${subtitle.downloadCount}',
                                                    style: AppTypography
                                                        .bodySmall
                                                        .copyWith(
                                                      color: AppColors.grey1,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 12),
                                                  Icon(Icons.star,
                                                      size: 14,
                                                      color: AppColors.grey1),
                                                  const SizedBox(width: 4),
                                                  Text(
                                                    subtitle.score
                                                        .toStringAsFixed(1),
                                                    style: AppTypography
                                                        .bodySmall
                                                        .copyWith(
                                                      color: AppColors.grey1,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Icon(Icons.download_rounded),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
