part of '../home.dart';

class _PlaylistField extends StatelessWidget {
  final List<PlaylistStateResponseModel> playlists;

  const _PlaylistField({
    required this.playlists,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = context.cubit<_ScreenCubit>();
    return ListView.separated(
      padding: Paddings.medium.horizontal,
      itemCount: playlists.length,
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final playlist = playlists[index];
        final isCompleted = playlist.progressPercentage == 100;

        return Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF2A2A2A),
                Color(0xFF1A1A1A),
              ],
            ),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppColors.white1.withValues(alpha: 0.1),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () async => await cubit.goPlaylistScreen(playlist),
              borderRadius: BorderRadius.circular(12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    // Icon container
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: isCompleted
                            ? AppColors.white1.withValues(alpha: 0.15)
                            : AppColors.white1.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        isCompleted
                            ? Icons.check_circle_outline
                            : Icons.play_circle_outline,
                        color: isCompleted
                            ? const Color(0xFF4CAF50)
                            : AppColors.white1,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            playlist.name,
                            style: AppTypography.bodyLarge.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              Text(
                                '${playlist.watchedCount}/${playlist.length} bölüm',
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.grey1,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '•',
                                style: TextStyle(
                                  color: AppColors.grey1.withValues(alpha: 0.5),
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                '%${playlist.progressPercentage.toStringAsFixed(0)}',
                                style: AppTypography.bodySmall.copyWith(
                                  color: isCompleted
                                      ? const Color(0xFF4CAF50)
                                      : AppColors.grey1,
                                  fontWeight: isCompleted
                                      ? FontWeight.w600
                                      : FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          // Progress bar
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: playlist.progressPercentage / 100,
                              backgroundColor:
                                  AppColors.grey1.withValues(alpha: 0.2),
                              valueColor: AlwaysStoppedAnimation<Color>(
                                isCompleted
                                    ? const Color(0xFF4CAF50)
                                    : AppColors.white1,
                              ),
                              minHeight: 4,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 16),

                    // Play button
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () async => await cubit.playPlaylist(playlist),
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.blue1.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.play_arrow_rounded,
                            color: AppColors.white1,
                            size: 20,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    // Delete button
                    Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () async =>
                            await cubit.removePlaylist(playlist.id),
                        borderRadius: BorderRadius.circular(8),
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.white1.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Icon(
                            Icons.delete_outline,
                            color: AppColors.grey1,
                            size: 20,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
