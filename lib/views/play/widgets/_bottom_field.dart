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
          // Left section - Settings dropdowns
          if (!Platform.isIOS && !Platform.isAndroid) ...[
            CustomDropdown<double>(
                width: 80,
                enableSearch: false,
                hintText: Strings.playSpeed(),
                initialSelection: 1,
                onSelected: (value) async => await cubit.setPlayRate(value),
                dropdownMenuEntries: [
                  DropdownMenuEntry(
                      value: widget.playerManager.playSpeedVerySlow,
                      label: '${widget.playerManager.playSpeedVerySlow}'),
                  DropdownMenuEntry(
                      value: widget.playerManager.playSpeedSlow,
                      label: '${widget.playerManager.playSpeedSlow}'),
                  DropdownMenuEntry(
                      value: widget.playerManager.playSpeedMedium,
                      label: '${widget.playerManager.playSpeedMedium}'),
                  DropdownMenuEntry(
                      value: widget.playerManager.playSpeedFast,
                      label: '${widget.playerManager.playSpeedFast}'),
                  DropdownMenuEntry(
                      value: widget.playerManager.playSpeedVeryFast,
                      label: '${widget.playerManager.playSpeedVeryFast}'),
                ]),
            const SizedBox(width: 8),
          ],
          if (audioTracks.length > 1) ...[
            CustomDropdown<String>(
                width: 130,
                enableSearch: false,
                hintText: 'Audio',
                initialSelection: widget.playerManager.currentAudioTrack,
                onSelected: (value) async {
                  if (value != null) await cubit.setAudioTrack(value);
                },
                dropdownMenuEntries: audioTracks.map((track) {
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
                  return DropdownMenuEntry(value: track['id']!, label: label);
                }).toList()),
            const SizedBox(width: 8),
          ],
          if (subtitleTracks.length > 1) ...[
            CustomDropdown<String>(
                width: 130,
                enableSearch: false,
                hintText: 'Subtitle',
                initialSelection: widget.playerManager.currentSubtitleTrack,
                onSelected: (value) async {
                  if (value != null) await cubit.setSubtitleTrack(value);
                },
                dropdownMenuEntries: subtitleTracks.map((track) {
                  if (track['id'] == 'no') {
                    return DropdownMenuEntry(
                        value: track['id']!, label: 'None');
                  }
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
                  return DropdownMenuEntry(value: track['id']!, label: label);
                }).toList()),
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
              IconButton(
                icon: AppIcons.backward10,
                onPressed: () async =>
                    await widget.playerManager.seekBackward(),
              ),
              const SizedBox(width: 8),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.white1.withOpacity(0.1),
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
              IconButton(
                icon: AppIcons.forward10,
                onPressed: () async => await widget.playerManager.seekForward(),
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
            ],
          ),

          const Spacer(),

          // Right section - Volume, subtitle search, shuffle, and settings
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: const Icon(Icons.closed_caption_outlined),
                tooltip: 'Search Subtitles',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => _SubtitleSearchDialog(
                      videoPath: widget.state.currentPlaying?.path ?? '',
                      videoName: widget.state.currentPlaying?.name ?? '',
                      playerManager: widget.playerManager,
                    ),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.auto_awesome),
                tooltip: 'Otomatik Oynatma Ayarları',
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
}
