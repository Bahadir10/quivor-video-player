part of '../play.dart';

class _BottomField extends StatefulWidget {
  final IVideoPlayerManager playerManager;
  final PlayScreenState state;
  const _BottomField(
      {super.key, required this.playerManager, required this.state});

  @override
  State<_BottomField> createState() => _BottomFieldState();
}

class _BottomFieldState extends State<_BottomField> {
  StreamSubscription? _tracksSubscription;

  @override
  void initState() {
    super.initState();
    _tracksSubscription = widget.playerManager.tracksStream.listen((_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _tracksSubscription?.cancel();
    super.dispose();
  }

  String _getLanguageName(String code) {
    final languageMap = {
      'eng': 'English',
      'jpn': 'Japanese',
      'spa': 'Spanish',
      'fre': 'French',
      'ger': 'German',
      'ita': 'Italian',
      'por': 'Portuguese',
      'rus': 'Russian',
      'chi': 'Chinese',
      'kor': 'Korean',
      'ara': 'Arabic',
      'hin': 'Hindi',
      'tur': 'Turkish',
      'pol': 'Polish',
      'dut': 'Dutch',
      'swe': 'Swedish',
      'nor': 'Norwegian',
      'dan': 'Danish',
      'fin': 'Finnish',
      'gre': 'Greek',
      'heb': 'Hebrew',
      'tha': 'Thai',
      'vie': 'Vietnamese',
      'ind': 'Indonesian',
      'may': 'Malay',
      'cze': 'Czech',
      'hun': 'Hungarian',
      'rum': 'Romanian',
      'ukr': 'Ukrainian',
      'auto': 'Auto',
      'und': 'Unknown',
    };
    return languageMap[code.toLowerCase()] ?? code.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.cubit<_ScreenCubit>();
    final audioTracks = cubit.audioTracks;
    final subtitleTracks = cubit.subtitleTracks;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          // Left section - Settings buttons
          if (!Platform.isIOS && !Platform.isAndroid) ...[
            _ModernSettingsButton(
              icon: Icons.speed,
              label: LocaleKeys.player_speed.tr(),
              currentValue: '1.0x',
              onTap: () => _showSpeedMenu(context, cubit),
            ),
            const SizedBox(width: 8),
            _ModernSettingsButton(
              icon: Icons.fast_forward,
              label: LocaleKeys.player_seek_duration.tr(),
              currentValue: '${widget.state.seekDurationSeconds}s',
              onTap: () => _showSeekDurationMenu(context, cubit),
            ),
            const SizedBox(width: 8),
          ],
          if (audioTracks.length > 1) ...[
            _ModernSettingsButton(
              icon: Icons.audiotrack,
              label: LocaleKeys.player_audio_track.tr(),
              currentValue: _getAudioTrackLabel(
                  audioTracks, widget.playerManager.currentAudioTrack),
              onTap: () => _showAudioMenu(context, cubit, audioTracks),
            ),
            const SizedBox(width: 8),
          ],
          if (subtitleTracks.length > 1) ...[
            _ModernSettingsButton(
              icon: Icons.subtitles,
              label: LocaleKeys.player_subtitles.tr(),
              currentValue: _getSubtitleTrackLabel(
                  subtitleTracks, widget.playerManager.currentSubtitleTrack),
              onTap: () => _showSubtitleMenu(context, cubit, subtitleTracks),
            ),
            const SizedBox(width: 8),
          ],

          const Spacer(),

          // Center section - Playback controls
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                  onPressed: () async {
                    if (widget.state.canPlayPrevious) {
                      await cubit.playPrevious();
                    }
                  },
                  icon: AppIcons.skipPrevious.copyWith(
                      color: !widget.state.canPlayPrevious
                          ? AppColors.grey1
                          : null)),
              const SizedBox(width: 4),
              Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.replay),
                    tooltip: '${widget.state.seekDurationSeconds}s geri',
                    onPressed: () async =>
                        await widget.playerManager.seekBackward(),
                  ),
                  Positioned(
                    bottom: 8,
                    child: Text(
                      '${widget.state.seekDurationSeconds}',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white1,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white1.withValues(alpha: 0.1),
                ),
                child: IconButton(
                  iconSize: 32,
                  icon: widget.state.isPlaying
                      ? const Icon(Icons.pause)
                      : const Icon(Icons.play_arrow),
                  onPressed: () async => await cubit.playOrPause(),
                ),
              ),
              const SizedBox(width: 8),
              Stack(
                alignment: Alignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.forward),
                    tooltip: '${widget.state.seekDurationSeconds}s ileri',
                    onPressed: () async =>
                        await widget.playerManager.seekForward(),
                  ),
                  Positioned(
                    bottom: 8,
                    child: Text(
                      '${widget.state.seekDurationSeconds}',
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white1,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 4),
              IconButton(
                  onPressed: () async {
                    if (widget.state.canPlayNext) {
                      await cubit.playNext();
                    }
                  },
                  icon: AppIcons.skipNext.copyWith(
                      color:
                          !widget.state.canPlayNext ? AppColors.grey1 : null)),
              const SizedBox(width: 8),
              // Mark as watched and play next button
              if (widget.state.canPlayNext &&
                  widget.state.currentPlaying != null)
                IconButton(
                  onPressed: () async {
                    await cubit.markAsWatchedAndPlayNext();
                  },
                  icon: const Icon(Icons.done_all),
                  tooltip: LocaleKeys.player_mark_watched_next.tr(),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.white1.withValues(alpha: 0.1),
                  ),
                ),
            ],
          ),

          const Spacer(),

          // Right section - Volume, subtitle search, shuffle, and settings
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  widget.state.showNotes ? Icons.note : Icons.note_outlined,
                  color: widget.state.showNotes
                      ? AppColors.white1
                      : AppColors.grey1,
                ),
                tooltip: LocaleKeys.player_notes.tr(),
                onPressed: () => cubit.toggleNotes(),
              ),
              IconButton(
                icon: const Icon(Icons.closed_caption_outlined),
                tooltip: LocaleKeys.player_search_subtitles.tr(),
                onPressed: () {
                  if (widget.state.currentPlaying != null) {
                    showDialog(
                      context: context,
                      builder: (context) => _SubtitleSearchDialog(
                        video: widget.state.currentPlaying!,
                        playerManager: widget.playerManager,
                      ),
                    );
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.file_open),
                tooltip: LocaleKeys.player_load_local_subtitle.tr(),
                onPressed: () async {
                  if (widget.state.currentPlaying != null) {
                    await cubit.loadLocalSubtitle(widget.state.currentPlaying!);
                  }
                },
              ),
              IconButton(
                icon: const Icon(Icons.auto_awesome),
                tooltip: LocaleKeys.player_auto_play_settings.tr(),
                onPressed: () {
                  final cubit = context.read<_ScreenCubit>();
                  showDialog(
                    context: context,
                    builder: (dialogContext) => BlocProvider.value(
                      value: cubit,
                      child: const _AutoPlaySettings(),
                    ),
                  );
                },
              ),
              IconButton(
                icon: AppIcons.shuffle,
                onPressed: () async => widget.playerManager.setShuffle(true),
              ),
              if (context.width > 600) ...[
                const SizedBox(width: 8),
                SizedBox(
                  width: 120,
                  child: CustomSlider(
                    value: widget.state.volume,
                    onChanged: (value) async => await cubit.setVolume(value),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }

  String _getAudioTrackLabel(
      List<Map<String, String>> tracks, String currentId) {
    final track =
        tracks.firstWhere((t) => t['id'] == currentId, orElse: () => {});
    if (track.isEmpty) return 'Audio';

    final lang = track['language']!.isNotEmpty
        ? _getLanguageName(track['language']!)
        : '';
    return lang.isNotEmpty ? lang : 'Audio';
  }

  String _getSubtitleTrackLabel(
      List<Map<String, String>> tracks, String currentId) {
    if (currentId == 'no') return LocaleKeys.player_no_subtitle.tr();

    final track =
        tracks.firstWhere((t) => t['id'] == currentId, orElse: () => {});
    if (track.isEmpty) return LocaleKeys.player_subtitles.tr();

    final lang = track['language']!.isNotEmpty
        ? _getLanguageName(track['language']!)
        : '';
    return lang.isNotEmpty ? lang : LocaleKeys.player_subtitles.tr();
  }

  void _showSpeedMenu(BuildContext context, _ScreenCubit cubit) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.black2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleKeys.player_speed.tr(),
              style:
                  AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...[0.25, 0.5, 0.75, 1.0, 1.25, 1.5, 1.75, 2.0].map((speed) {
              return ListTile(
                leading: Icon(
                  speed == 1.0 ? Icons.check_circle : Icons.circle_outlined,
                  color: speed == 1.0 ? AppColors.white1 : AppColors.grey1,
                ),
                title: Text('${speed}x'),
                onTap: () {
                  cubit.setPlayRate(speed);
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showSeekDurationMenu(BuildContext context, _ScreenCubit cubit) {
    final currentDuration = widget.state.seekDurationSeconds;

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.black2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleKeys.player_seek_duration.tr(),
              style:
                  AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              LocaleKeys.player_seek_duration_desc.tr(),
              style: AppTypography.bodySmall.copyWith(color: AppColors.grey1),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ...[5, 10, 15, 30, 60].map((duration) {
              return ListTile(
                leading: Icon(
                  duration == currentDuration
                      ? Icons.check_circle
                      : Icons.circle_outlined,
                  color: duration == currentDuration
                      ? AppColors.white1
                      : AppColors.grey1,
                ),
                title: Text('${duration} saniye'),
                onTap: () async {
                  await cubit.setSeekDuration(duration);
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showAudioMenu(BuildContext context, _ScreenCubit cubit,
      List<Map<String, String>> tracks) {
    final currentTrack = widget.playerManager.currentAudioTrack;

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.black2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleKeys.player_audio_track.tr(),
              style:
                  AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...tracks.map((track) {
              final isSelected = track['id'] == currentTrack;
              final lang = track['language']!.isNotEmpty
                  ? _getLanguageName(track['language']!)
                  : '';
              final title = track['title']!.isNotEmpty &&
                      track['title']! != track['language']
                  ? track['title']!
                  : '';
              final label = lang.isNotEmpty
                  ? (title.isNotEmpty ? '$lang - $title' : lang)
                  : (title.isNotEmpty ? title : 'Track ${track['id']}');

              return ListTile(
                leading: Icon(
                  isSelected ? Icons.check_circle : Icons.circle_outlined,
                  color: isSelected ? AppColors.white1 : AppColors.grey1,
                ),
                title: Text(label),
                onTap: () {
                  cubit.setAudioTrack(track['id']!);
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showSubtitleMenu(BuildContext context, _ScreenCubit cubit,
      List<Map<String, String>> tracks) {
    final currentTrack = widget.playerManager.currentSubtitleTrack;
    final currentOffset = cubit.currentSubtitleOffset;

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.black2,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocaleKeys.player_subtitles.tr(),
              style:
                  AppTypography.bodyLarge.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Subtitle offset controls
            if (currentTrack != 'no') ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.white1.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: AppColors.white1.withValues(alpha: 0.1),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          LocaleKeys.player_subtitle_sync.tr(),
                          style: AppTypography.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${currentOffset >= 0 ? '+' : ''}${currentOffset.toStringAsFixed(1)}s',
                          style: AppTypography.bodyMedium.copyWith(
                            color: currentOffset == 0
                                ? AppColors.grey1
                                : AppColors.white1,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _SubtitleOffsetButton(
                          label: '-5s',
                          onTap: () async {
                            await cubit.adjustSubtitleOffset(-5.0);
                            Navigator.pop(context);
                          },
                        ),
                        _SubtitleOffsetButton(
                          label: '-0.5s',
                          onTap: () async {
                            await cubit.adjustSubtitleOffset(-0.5);
                            Navigator.pop(context);
                          },
                        ),
                        _SubtitleOffsetButton(
                          label: LocaleKeys.player_reset.tr(),
                          icon: Icons.refresh,
                          onTap: () async {
                            await cubit.resetSubtitleOffset();
                            Navigator.pop(context);
                          },
                        ),
                        _SubtitleOffsetButton(
                          label: '+0.5s',
                          onTap: () async {
                            await cubit.adjustSubtitleOffset(0.5);
                            Navigator.pop(context);
                          },
                        ),
                        _SubtitleOffsetButton(
                          label: '+5s',
                          onTap: () async {
                            await cubit.adjustSubtitleOffset(5.0);
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const Divider(color: AppColors.grey1),
              const SizedBox(height: 8),
            ],

            ...tracks.map((track) {
              final isSelected = track['id'] == currentTrack;
              final String label;

              if (track['id'] == 'no') {
                label = LocaleKeys.player_no_subtitle.tr();
              } else {
                final lang = track['language']!.isNotEmpty
                    ? _getLanguageName(track['language']!)
                    : '';
                final title = track['title']!.isNotEmpty &&
                        track['title']! != track['language']
                    ? track['title']!
                    : '';
                label = lang.isNotEmpty
                    ? (title.isNotEmpty ? '$lang - $title' : lang)
                    : (title.isNotEmpty ? title : 'Track ${track['id']}');
              }

              return ListTile(
                leading: Icon(
                  isSelected ? Icons.check_circle : Icons.circle_outlined,
                  color: isSelected ? AppColors.white1 : AppColors.grey1,
                ),
                title: Text(label),
                onTap: () {
                  cubit.setSubtitleTrack(track['id']!);
                  Navigator.pop(context);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

// Modern settings button widget
class _ModernSettingsButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String currentValue;
  final VoidCallback onTap;

  const _ModernSettingsButton({
    required this.icon,
    required this.label,
    required this.currentValue,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.white1.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.white1.withValues(alpha: 0.2),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 18, color: AppColors.white1),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: AppTypography.bodySmall.copyWith(
                      fontSize: 10,
                      color: AppColors.grey1,
                    ),
                  ),
                  Text(
                    currentValue,
                    style: AppTypography.bodySmall.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 4),
              Icon(Icons.arrow_drop_down, size: 20, color: AppColors.grey1),
            ],
          ),
        ),
      ),
    );
  }
}

// Subtitle offset button widget
class _SubtitleOffsetButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final VoidCallback onTap;

  const _SubtitleOffsetButton({
    required this.label,
    this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(6),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.white1.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: AppColors.white1.withValues(alpha: 0.2),
            ),
          ),
          child: icon != null
              ? Icon(icon, size: 18, color: AppColors.white1)
              : Text(
                  label,
                  style: AppTypography.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
        ),
      ),
    );
  }
}
