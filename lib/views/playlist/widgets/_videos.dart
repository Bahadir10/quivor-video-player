part of '../playlist.dart';

class _VideosField extends StatelessWidget {
  final List<VideoEntity> videos;
  final PlaylistStateResponseModel playlist;
  const _VideosField({required this.videos, required this.playlist});

  @override
  Widget build(BuildContext context) {
    final cubit = context.cubit<_ScreenCubit>();

    if (videos.isEmpty) {
      return Expanded(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(48),
            decoration: BoxDecoration(
              color: AppColors.black1.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.white1.withValues(alpha: 0.1),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.video_library_outlined,
                  size: 64,
                  color: AppColors.grey1.withValues(alpha: 0.5),
                ),
                const SizedBox(height: 16),
                Text(
                  'Henüz video eklenmemiş',
                  style: AppTypography.bodyLarge.copyWith(
                    color: AppColors.grey1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Başlamak için video ekleyin',
                  style: AppTypography.bodySmall.copyWith(
                    color: AppColors.grey1.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton.icon(
                  onPressed: () async => await cubit.addVideo(),
                  icon: const Icon(Icons.add),
                  label: const Text('Video Ekle'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.white1,
                    foregroundColor: AppColors.black1,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 14,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Expanded(
      child: ListView.separated(
        itemCount: videos.length,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          final VideoEntity video = videos[index];
          final hasProgress = video.lastPositionSecond > 0;

          return Container(
            decoration: BoxDecoration(
              color: video.isWatched
                  ? AppColors.black1.withValues(alpha: 0.3)
                  : AppColors.black1.withValues(alpha: 0.5),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: video.isWatched
                    ? AppColors.grey1.withValues(alpha: 0.3)
                    : AppColors.white1.withValues(alpha: 0.08),
                width: 1,
              ),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  context.go(AppRoute.player,
                      data: PlayScreenParameters(
                          paths: videos,
                          mainPath: playlist.name,
                          startIndex: index));
                },
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      // Checkbox
                      GestureDetector(
                        onTap: () async => await cubit.handleWatchState(video),
                        child: Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: video.isWatched
                                ? AppColors.blue1
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(6),
                            border: Border.all(
                              color: video.isWatched
                                  ? AppColors.blue1
                                  : AppColors.grey1.withValues(alpha: 0.5),
                              width: 2,
                            ),
                          ),
                          child: video.isWatched
                              ? const Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Episode number
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: AppColors.white1.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: Text(
                            '${index + 1}',
                            style: const TextStyle(
                              color: AppColors.white1,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      // Video info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              video.name,
                              style: AppTypography.bodyMedium.copyWith(
                                fontWeight: FontWeight.w500,
                                decoration: video.isWatched
                                    ? TextDecoration.lineThrough
                                    : null,
                                decorationColor: AppColors.grey1,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            if (hasProgress) ...[
                              const SizedBox(height: 6),
                              Row(
                                children: [
                                  Icon(
                                    Icons.access_time,
                                    size: 12,
                                    color: AppColors.grey1,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    _formatDuration(video.lastPositionSecond),
                                    style: AppTypography.bodySmall.copyWith(
                                      color: AppColors.grey1,
                                      fontSize: 11,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(2),
                                      child: LinearProgressIndicator(
                                        value:
                                            0.5, // TODO: Calculate actual progress
                                        backgroundColor: AppColors.grey1
                                            .withValues(alpha: 0.2),
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                          AppColors.white1
                                              .withValues(alpha: 0.6),
                                        ),
                                        minHeight: 3,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ],
                        ),
                      ),

                      const SizedBox(width: 12),

                      // Status badge
                      if (video.isWatched)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.grey1.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Text(
                            'İzlendi',
                            style: TextStyle(
                              color: AppColors.grey1,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),

                      const SizedBox(width: 8),

                      // Delete button
                      IconButton(
                        onPressed: () async => await cubit.removeVideo(video),
                        icon: const Icon(Icons.delete_outline),
                        color: AppColors.grey1,
                        iconSize: 20,
                        style: IconButton.styleFrom(
                          backgroundColor:
                              AppColors.white1.withValues(alpha: 0.05),
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
    );
  }

  String _formatDuration(int seconds) {
    final duration = Duration(seconds: seconds);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final secs = duration.inSeconds.remainder(60);

    if (hours > 0) {
      return '${hours}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    }
    return '${minutes}:${secs.toString().padLeft(2, '0')}';
  }
}
