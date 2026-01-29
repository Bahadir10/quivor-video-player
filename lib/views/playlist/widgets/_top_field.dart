part of '../playlist.dart';

class _TopField extends StatelessWidget {
  final double percentage;
  final int watchedCount;
  final List<VideoEntity> videos;
  final PlaylistStateResponseModel playlist;
  const _TopField({
    required this.percentage,
    required this.watchedCount,
    required this.videos,
    required this.playlist,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.cubit<_ScreenCubit>();
    final isCompleted = percentage >= 100;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            const Color(0xFF2A2A2A),
            const Color(0xFF1A1A1A),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: AppColors.white1.withValues(alpha: 0.15),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header row
          Row(
            children: [
              IconButton(
                onPressed: () => cubit.toggleSideBar(context),
                icon: const Icon(Icons.menu),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.white1.withValues(alpha: 0.1),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      playlist.name,
                      style: AppTypography.headingMedium.copyWith(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          isCompleted
                              ? Icons.check_circle
                              : Icons.play_circle_outline,
                          size: 16,
                          color: isCompleted
                              ? const Color(0xFF4CAF50)
                              : AppColors.grey1,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          isCompleted ? 'Tamamlandı' : 'Devam Ediyor',
                          style: AppTypography.bodySmall.copyWith(
                            color: isCompleted
                                ? const Color(0xFF4CAF50)
                                : AppColors.grey1,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Stats row
          Row(
            children: [
              Expanded(
                child: _StatCard(
                  icon: Icons.video_library,
                  label: 'Total',
                  value: '${videos.length}',
                  color: AppColors.white1,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.check_circle_outline,
                  label: 'İzlendi',
                  value: '$watchedCount',
                  color: AppColors.grey1,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatCard(
                  icon: Icons.pending_outlined,
                  label: 'Kalan',
                  value: '${videos.length - watchedCount}',
                  color: AppColors.grey1,
                ),
              ),
            ],
          ),

          const SizedBox(height: 20),

          // Progress bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'İlerleme',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.grey1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '%${percentage.toStringAsFixed(0)}',
                    style: AppTypography.bodySmall.copyWith(
                      color: isCompleted
                          ? const Color(0xFF4CAF50)
                          : AppColors.white1,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: percentage / 100,
                  backgroundColor: AppColors.grey1.withValues(alpha: 0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.white1,
                  ),
                  minHeight: 8,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Action buttons
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: videos.isEmpty
                      ? null
                      : () {
                          context.go(AppRoute.player,
                              data: PlayScreenParameters(
                                  paths: videos,
                                  mainPath: playlist.name,
                                  playlistId: playlist.id));
                        },
                  icon: const Icon(Icons.play_arrow, size: 20),
                  label: const Text('Devam Et'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white1,
                    foregroundColor: AppColors.black1,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    disabledBackgroundColor:
                        AppColors.grey1.withValues(alpha: 0.2),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: () async => await cubit.addVideo(),
                icon: const Icon(Icons.add, size: 20),
                label: const Text('Video Ekle'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.white1,
                  side: BorderSide(
                    color: AppColors.white1.withValues(alpha: 0.3),
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 14,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                onPressed: () => _showAutoPlaySettings(context, cubit),
                icon: const Icon(Icons.auto_awesome),
                tooltip: LocaleKeys.player_auto_play_settings.tr(),
                style: IconButton.styleFrom(
                  backgroundColor: AppColors.white1.withValues(alpha: 0.1),
                  foregroundColor: AppColors.white1,
                  side: BorderSide(
                    color: AppColors.white1.withValues(alpha: 0.3),
                  ),
                  padding: const EdgeInsets.all(14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              IconButton(
                onPressed: watchedCount == 0
                    ? null
                    : () => _showStartOverDialog(context, cubit),
                icon: const Icon(Icons.restart_alt),
                tooltip: LocaleKeys.playlist_start_over.tr(),
                style: IconButton.styleFrom(
                  backgroundColor: watchedCount == 0
                      ? AppColors.grey1.withValues(alpha: 0.1)
                      : AppColors.white1.withValues(alpha: 0.1),
                  foregroundColor: watchedCount == 0
                      ? AppColors.grey1.withValues(alpha: 0.5)
                      : AppColors.white1,
                  side: BorderSide(
                    color: watchedCount == 0
                        ? AppColors.grey1.withValues(alpha: 0.2)
                        : AppColors.white1.withValues(alpha: 0.3),
                  ),
                  padding: const EdgeInsets.all(14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showStartOverDialog(BuildContext context, _ScreenCubit cubit) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: AppColors.black2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        title: Row(
          children: [
            Icon(
              Icons.restart_alt,
              color: Colors.orange.shade400,
            ),
            const SizedBox(width: 12),
            Text(LocaleKeys.playlist_start_over.tr()),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              LocaleKeys.playlist_start_over_confirm.tr(),
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            Text(
              LocaleKeys.playlist_start_over_warning.tr(),
              style: TextStyle(
                fontSize: 14,
                color: AppColors.grey1,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: Text(
              LocaleKeys.common_cancel.tr(),
              style: const TextStyle(color: AppColors.grey1),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () async {
              Navigator.pop(dialogContext);
              await cubit.startOver();
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(LocaleKeys.playlist_start_over_success.tr()),
                    backgroundColor: Colors.green,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            icon: const Icon(Icons.restart_alt, size: 18),
            label: Text(LocaleKeys.playlist_start_over.tr()),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange.shade400,
              foregroundColor: Colors.white,
            ),
          ),
        ],
      ),
    );
  }

  void _showAutoPlaySettings(BuildContext context, _ScreenCubit cubit) async {
    // Load current playlist settings
    final playlists = await getIt<IPlaylistService>().getPlaylists();
    final currentPlaylist =
        playlists.firstWhereOrNull((p) => p.id == playlist.id);

    // Get global defaults
    final userPrefs = await UserDataManager().userPrefrences;

    // Use playlist settings or fall back to global
    AutoPlayMode currentMode = currentPlaylist?.autoPlayMode != null
        ? AutoPlayMode.values.firstWhere(
            (mode) => mode.name == currentPlaylist!.autoPlayMode,
            orElse: () => userPrefs.autoPlayMode,
          )
        : userPrefs.autoPlayMode;

    int currentSeconds = currentPlaylist?.earlyTransitionSeconds ??
        userPrefs.earlyTransitionSeconds;

    int currentIntroSkip = currentPlaylist?.introSkipSeconds ?? 0;

    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (dialogContext) => _PlaylistAutoPlayDialog(
        playlist: currentPlaylist ??
            entities.Playlist(id: playlist.id, name: playlist.name),
        initialMode: currentMode,
        initialSeconds: currentSeconds,
        initialIntroSkip: currentIntroSkip,
        onSave: (mode, seconds, introSkip) async {
          // Update playlist
          final updatedPlaylist = (currentPlaylist ??
                  entities.Playlist(id: playlist.id, name: playlist.name))
              .copyWith(
            autoPlayMode: mode.name,
            earlyTransitionSeconds: seconds,
            introSkipSeconds: introSkip,
          );
          await getIt<IPlaylistService>().updatePlaylist(updatedPlaylist);

          if (context.mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(LocaleKeys.common_success.tr()),
                backgroundColor: Colors.green,
              ),
            );
          }
        },
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: color.withValues(alpha: 0.2),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: AppColors.grey1.withValues(alpha: 0.8),
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// AutoPlay settings dialog for playlist
class _PlaylistAutoPlayDialog extends StatefulWidget {
  final entities.Playlist playlist;
  final AutoPlayMode initialMode;
  final int initialSeconds;
  final int initialIntroSkip;
  final Function(AutoPlayMode mode, int seconds, int introSkip) onSave;

  const _PlaylistAutoPlayDialog({
    required this.playlist,
    required this.initialMode,
    required this.initialSeconds,
    required this.initialIntroSkip,
    required this.onSave,
  });

  @override
  State<_PlaylistAutoPlayDialog> createState() =>
      _PlaylistAutoPlayDialogState();
}

class _PlaylistAutoPlayDialogState extends State<_PlaylistAutoPlayDialog> {
  late AutoPlayMode _selectedMode;
  late int _selectedSeconds;
  late int _selectedIntroSkip;

  @override
  void initState() {
    super.initState();
    _selectedMode = widget.initialMode;
    _selectedSeconds = widget.initialSeconds;
    _selectedIntroSkip = widget.initialIntroSkip;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.black2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: 400,
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Header
            Row(
              children: [
                const Icon(Icons.auto_awesome, size: 24),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    LocaleKeys.autoplay_title.tr(),
                    style: AppTypography.bodyLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close, size: 20),
                  onPressed: () => Navigator.pop(context),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              widget.playlist.name,
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.grey1,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 16),

            // Mode selection
            ...AutoPlayMode.values.map((mode) {
              final isSelected = _selectedMode == mode;
              return InkWell(
                onTap: () => setState(() => _selectedMode = mode),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? AppColors.white1.withValues(alpha: 0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected
                          ? AppColors.white1
                          : AppColors.grey1.withValues(alpha: 0.3),
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        isSelected
                            ? Icons.radio_button_checked
                            : Icons.radio_button_unchecked,
                        size: 20,
                        color: isSelected ? AppColors.white1 : AppColors.grey1,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mode.displayName,
                              style: AppTypography.bodyMedium.copyWith(
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            Text(
                              mode.description,
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.grey1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            // Slider for early and autoTransition modes
            if (_selectedMode == AutoPlayMode.early ||
                _selectedMode == AutoPlayMode.autoTransition) ...[
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.white1.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Text(
                      '${LocaleKeys.autoplay_transition_time.tr()}: $_selectedSeconds ${LocaleKeys.autoplay_seconds.tr()}',
                      style: AppTypography.bodyMedium.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text('5', style: AppTypography.bodySmall),
                        Expanded(
                          child: Slider(
                            value: _selectedSeconds.toDouble(),
                            min: 5,
                            max: 60,
                            divisions: 11,
                            onChanged: (value) {
                              setState(() => _selectedSeconds = value.toInt());
                            },
                          ),
                        ),
                        Text('60', style: AppTypography.bodySmall),
                      ],
                    ),
                  ],
                ),
              ),
            ],

            const SizedBox(height: 16),

            // Intro Skip Setting
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.fast_forward, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          'Intro Atlama',
                          style: AppTypography.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Video ilk defa açıldığında otomatik olarak atlanacak süre',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.grey1,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    _selectedIntroSkip == 0
                        ? 'Kapalı'
                        : '$_selectedIntroSkip saniye',
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.bold,
                      color: _selectedIntroSkip == 0
                          ? AppColors.grey1
                          : AppColors.white1,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text('0', style: AppTypography.bodySmall),
                      Expanded(
                        child: Slider(
                          value: _selectedIntroSkip.toDouble(),
                          min: 0,
                          max: 120,
                          divisions: 24,
                          onChanged: (value) {
                            setState(() => _selectedIntroSkip = value.toInt());
                          },
                        ),
                      ),
                      Text('120', style: AppTypography.bodySmall),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Save button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.onSave(
                      _selectedMode, _selectedSeconds, _selectedIntroSkip);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.white1,
                  foregroundColor: AppColors.black1,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(LocaleKeys.common_save.tr()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
