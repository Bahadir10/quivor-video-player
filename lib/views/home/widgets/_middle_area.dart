part of '../home.dart';

class _MiddleArea extends StatelessWidget {
  final List<PlaylistStateResponseModel> playlists;
  final bool isMobile;
  const _MiddleArea({required this.playlists, this.isMobile = false});

  @override
  Widget build(BuildContext context) {
    final cubit = context.cubit<_ScreenCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 24),

        // Search bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              if (isMobile) ...[
                IconButton(
                  onPressed: () => Scaffold.of(context).openDrawer(),
                  icon: const Icon(Icons.menu),
                  style: IconButton.styleFrom(
                    backgroundColor: AppColors.white1.withValues(alpha: 0.1),
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.black1.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.white1.withValues(alpha: 0.1),
                    ),
                  ),
                  child: TextField(
                    onChanged: (value) async => cubit.search(value),
                    style: const TextStyle(color: AppColors.white1),
                    decoration: InputDecoration(
                      hintText: 'Playlist ara...',
                      hintStyle: TextStyle(
                        color: AppColors.grey1.withValues(alpha: 0.6),
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: AppColors.grey1.withValues(alpha: 0.6),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 32),

        // Playlists section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.white1.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.video_library,
                  size: 20,
                  color: AppColors.white1,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Playlistler',
                style: AppTypography.headingMedium.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.white1.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${playlists.length}',
                  style: AppTypography.bodySmall.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.white1,
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Playlists list - 50% of available space
        Expanded(
          flex: 5,
          child: _PlaylistField(
            playlists: playlists,
          ),
        ),

        const SizedBox(height: 24),

        // Recent videos section
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: AppColors.white1.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.history,
                  size: 20,
                  color: AppColors.white1,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Son İzlenenler',
                style: AppTypography.headingMedium.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 16),

        // Recent videos list - 50% of available space
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: const _RecentVideosField(),
          ),
        ),

        const SizedBox(height: 24),
      ],
    );
  }
}
