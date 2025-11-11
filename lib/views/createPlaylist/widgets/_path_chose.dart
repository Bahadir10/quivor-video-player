part of '../create_playlist.dart';

class _PathChose extends StatelessWidget {
  final List<String> paths;
  const _PathChose({required this.paths});

  @override
  Widget build(BuildContext context) {
    final cubit = context.cubit<_ScreenCubit>();

    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF2A2A2A),
                  Color(0xFF1A1A1A),
                ],
              ),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: AppColors.white1.withValues(alpha: 0.15),
                width: 1.5,
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppColors.white1.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.folder_open_rounded,
                        color: AppColors.white1,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Create Playlist',
                            style: AppTypography.headingMedium.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${paths.length} video bulundu',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.grey1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // Playlist name input
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.black1.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: AppColors.white1.withValues(alpha: 0.1),
                    ),
                  ),
                  child: TextField(
                    controller: cubit.playlistNameController,
                    style: const TextStyle(color: AppColors.white1),
                    decoration: InputDecoration(
                      hintText: 'Playlist adı...',
                      hintStyle: TextStyle(
                        color: AppColors.grey1.withValues(alpha: 0.6),
                      ),
                      prefixIcon: Icon(
                        Icons.edit,
                        color: AppColors.grey1.withValues(alpha: 0.6),
                      ),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Videos list header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              children: [
                const Icon(
                  Icons.video_library,
                  size: 20,
                  color: AppColors.white1,
                ),
                const SizedBox(width: 8),
                Text(
                  'Videolar',
                  style: AppTypography.bodyLarge.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          // Videos list
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.black1.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.white1.withValues(alpha: 0.1),
                ),
              ),
              child: ListView.separated(
                padding: const EdgeInsets.all(12),
                itemCount: paths.length,
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemBuilder: (context, index) {
                  final path = paths[index];
                  final fileName = p.basename(path);

                  return Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.black1.withValues(alpha: 0.5),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: AppColors.white1.withValues(alpha: 0.05),
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: AppColors.white1.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: AppColors.white1,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            fileName,
                            style: AppTypography.bodyMedium,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Create button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () async => await cubit.createPlaylistFromPath(),
              icon: const Icon(Icons.check),
              label: const Text('Create Playlist'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white1,
                foregroundColor: AppColors.black1,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
