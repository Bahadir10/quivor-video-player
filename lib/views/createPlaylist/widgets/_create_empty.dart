part of '../create_playlist.dart';

class _CreateEmptyView extends StatelessWidget {
  const _CreateEmptyView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.cubit<_ScreenCubit>();

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500),
        padding: const EdgeInsets.all(32),
        child: Container(
          padding: const EdgeInsets.all(32),
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
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.white1.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.playlist_add_rounded,
                  size: 48,
                  color: AppColors.white1,
                ),
              ),

              const SizedBox(height: 24),

              // Title
              Text(
                'Yeni Playlist',
                style: AppTypography.headingMedium.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Playlist için bir isim girin',
                style: AppTypography.bodyMedium.copyWith(
                  color: AppColors.grey1,
                ),
              ),

              const SizedBox(height: 32),

              // Input
              Container(
                decoration: BoxDecoration(
                  color: AppColors.black1.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: AppColors.white1.withValues(alpha: 0.1),
                  ),
                ),
                child: TextField(
                  onChanged: cubit.updatePlaylistName,
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

              const SizedBox(height: 24),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.white1,
                        side: BorderSide(
                          color: AppColors.white1.withValues(alpha: 0.3),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('İptal'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 2,
                    child: ElevatedButton(
                      onPressed: () async => cubit.createEmptyPlaylist(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.white1,
                        foregroundColor: AppColors.black1,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Text('Oluştur'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
