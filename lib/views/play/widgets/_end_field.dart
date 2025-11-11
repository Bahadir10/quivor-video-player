part of '../play.dart';

class _EndField extends StatelessWidget {
  final List<VideoEntity> videos;
  final String text;
  final int? playingId;
  const _EndField({
    required this.videos,
    required this.text,
    required this.playingId,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.cubit<_ScreenCubit>();
    return Container(
      width: context.width * 0.3 < 320 ? 320 : context.width * 0.3,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1A1A1A),
            Color(0xFF0F0F0F),
          ],
        ),
        border: Border(
          left: BorderSide(
            color: AppColors.white1.withValues(alpha: 0.1),
            width: 1,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 16,
            offset: const Offset(-4, 0),
          ),
        ],
      ),
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.white1.withValues(alpha: 0.1),
                  AppColors.white1.withValues(alpha: 0.05),
                ],
              ),
              border: Border(
                bottom: BorderSide(
                  color: AppColors.white1.withValues(alpha: 0.1),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.white1.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(
                    Icons.playlist_play_rounded,
                    color: AppColors.white1,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Playlist',
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.grey1,
                          fontSize: 11,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        text,
                        style: AppTypography.bodyMedium.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Stats
          if (videos.length > 1)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: AppColors.black1.withValues(alpha: 0.3),
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.white1.withValues(alpha: 0.1),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                children: [
                  _StatBadge(
                    icon: Icons.video_library,
                    label: 'Toplam',
                    value: '${videos.length}',
                  ),
                  const SizedBox(width: 12),
                  _StatBadge(
                    icon: Icons.check_circle_outline,
                    label: 'İzlendi',
                    value: '${videos.where((v) => v.isWatched).length}',
                  ),
                ],
              ),
            ),

          // Videos list
          if (videos.length > 1)
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: videos.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final video = videos[index];
                  final isPlaying = video.id == playingId;

                  return Container(
                    decoration: BoxDecoration(
                      color: isPlaying
                          ? AppColors.white1.withValues(alpha: 0.15)
                          : AppColors.black1.withValues(alpha: 0.3),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(
                        color: isPlaying
                            ? AppColors.white1.withValues(alpha: 0.3)
                            : AppColors.white1.withValues(alpha: 0.05),
                        width: isPlaying ? 1.5 : 1,
                      ),
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () async =>
                            await cubit.playIndex(videos.indexOf(video)),
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              // Checkbox
                              GestureDetector(
                                onTap: () async =>
                                    await cubit.toggleWatch(video),
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    color: video.isWatched
                                        ? AppColors.grey1
                                        : Colors.transparent,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: video.isWatched
                                          ? AppColors.grey1
                                          : AppColors.grey1
                                              .withValues(alpha: 0.5),
                                      width: 2,
                                    ),
                                  ),
                                  child: video.isWatched
                                      ? const Icon(
                                          Icons.check,
                                          size: 12,
                                          color: Colors.white,
                                        )
                                      : null,
                                ),
                              ),

                              const SizedBox(width: 12),

                              // Episode number
                              Container(
                                width: 32,
                                height: 32,
                                decoration: BoxDecoration(
                                  color: isPlaying
                                      ? AppColors.white1.withValues(alpha: 0.2)
                                      : AppColors.white1.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Center(
                                  child: Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      color: isPlaying
                                          ? AppColors.white1
                                          : AppColors.grey1,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 12),

                              // Video name
                              Expanded(
                                child: Text(
                                  video.name,
                                  style: AppTypography.bodySmall.copyWith(
                                    fontWeight: isPlaying
                                        ? FontWeight.w600
                                        : FontWeight.normal,
                                    color: isPlaying
                                        ? AppColors.white1
                                        : AppColors.grey1,
                                    decoration: video.isWatched
                                        ? TextDecoration.lineThrough
                                        : null,
                                    decorationColor: AppColors.grey1,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 2,
                                ),
                              ),

                              const SizedBox(width: 8),

                              // Playing indicator
                              if (isPlaying)
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color:
                                        AppColors.white1.withValues(alpha: 0.2),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Icon(
                                    Icons.equalizer,
                                    color: AppColors.white1,
                                    size: 16,
                                  ),
                                ),
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
    );
  }
}

class _StatBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatBadge({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.white1.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: AppColors.grey1),
            const SizedBox(width: 6),
            Text(
              value,
              style: TextStyle(
                color: AppColors.white1,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                color: AppColors.grey1,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
