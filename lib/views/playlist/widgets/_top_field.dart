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
                                  paths: videos, mainPath: playlist.name));
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
