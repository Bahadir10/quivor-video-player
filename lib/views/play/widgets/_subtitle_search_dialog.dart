part of '../play.dart';

class _SubtitleSearchDialog extends StatefulWidget {
  final VideoEntity video;
  final IVideoPlayerManager playerManager;

  const _SubtitleSearchDialog({
    required this.video,
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
        final hash =
            await _subtitleService.calculateFileHash(widget.video.path);
        results = await _subtitleService.searchByHash(
          hash,
          language: _selectedLanguage,
        );
      } else {
        results = await _subtitleService.searchByFileName(
          widget.video.name,
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
            title: Text(LocaleKeys.subtitle_error.tr()),
            content: SingleChildScrollView(
              child: Text(
                '${LocaleKeys.subtitle_error.tr()}:\n\n$e',
                style: const TextStyle(fontSize: 12),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(LocaleKeys.common_ok.tr()),
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

      // Save subtitle in the same directory as the video
      final videoDir = path.dirname(widget.video.path);
      final videoBaseName = path.basenameWithoutExtension(widget.video.path);
      final subtitleExt = path.extension(subtitle.fileName);
      final savePath = path.join(videoDir, '$videoBaseName${subtitleExt}');

      // Show loading
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(LocaleKeys.subtitle_downloading
                .tr(namedArgs: {'fileName': subtitle.fileName})),
            duration: const Duration(seconds: 2),
          ),
        );
      }

      // Download subtitle using file_id
      await _subtitleService.downloadSubtitle(subtitle.downloadUrl, savePath);

      logger.info('Subtitle downloaded to: $savePath');

      // Add to video's downloaded subtitles list and set as last selected
      final updatedSubtitles =
          List<String>.from(widget.video.downloadedSubtitles);
      if (!updatedSubtitles.contains(savePath)) {
        updatedSubtitles.add(savePath);
      }

      final updatedVideo = widget.video.copyWith(
        downloadedSubtitles: updatedSubtitles,
        lastSelectedSubtitle: savePath,
      );
      await getIt<IVideoService>().updateVideo(updatedVideo);
      logger.info('Subtitle path saved to database and set as last selected');

      // Load into player
      await widget.playerManager.loadExternalSubtitle(savePath);

      logger.info('Subtitle loaded into player');

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(LocaleKeys.subtitle_downloaded.tr()),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
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
            title: Row(
              children: [
                const Icon(Icons.error_outline, color: Colors.red),
                const SizedBox(width: 8),
                Text(LocaleKeys.subtitle_download_failed.tr()),
              ],
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('${LocaleKeys.subtitle_error.tr()}: $e'),
                  const SizedBox(height: 16),
                  Text(
                    LocaleKeys.subtitle_possible_reasons.tr(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('• ${LocaleKeys.subtitle_limit_exceeded.tr()}'),
                  Text('• ${LocaleKeys.subtitle_invalid_api_key.tr()}'),
                  Text('• ${LocaleKeys.subtitle_network_issue.tr()}'),
                  const SizedBox(height: 16),
                  Text(
                    LocaleKeys.subtitle_try_local.tr(),
                    style: const TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(LocaleKeys.common_ok.tr()),
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
                    LocaleKeys.subtitle_search.tr(),
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
                    'Video: ${widget.video.name}',
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
                        label: Text(LocaleKeys.common_refresh.tr()),
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
                      Text(LocaleKeys.subtitle_search_by_hash.tr()),
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
                                LocaleKeys.subtitle_no_results.tr(),
                                style: AppTypography.bodyLarge,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                LocaleKeys.subtitle_try_different.tr(),
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
                                  color: AppColors.grey1.withValues(alpha: 0.2),
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
                                                .withValues(alpha: 0.1),
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
