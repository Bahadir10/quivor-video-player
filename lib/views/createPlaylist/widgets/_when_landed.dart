part of '../create_playlist.dart';

class _WhenLandedView extends StatelessWidget {
  const _WhenLandedView();

  @override
  Widget build(BuildContext context) {
    final cubit = context.cubit<_ScreenCubit>();

    return Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 900),
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Header
            Text(
              'Playlist Oluştur',
              style: AppTypography.headingLarge.copyWith(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Nasıl bir playlist oluşturmak istersiniz?',
              style: AppTypography.bodyLarge.copyWith(
                color: AppColors.grey1,
              ),
            ),

            const SizedBox(height: 48),

            // Options
            Row(
              children: [
                Expanded(
                  child: _SelectionCard(
                    icon: Icons.folder_open_rounded,
                    title: 'Klasörden',
                    description: 'Bir klasördeki tüm videoları ekle',
                    buttonText: 'Klasör Seç',
                    onPressed: () async => await cubit.openPath(),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: _SelectionCard(
                    icon: Icons.playlist_add_rounded,
                    title: 'Boş Playlist',
                    description: 'Yeni bir boş playlist oluştur',
                    buttonText: 'Oluştur',
                    onPressed: () => cubit.makeChoise(),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SelectionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onPressed;

  const _SelectionCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          color: AppColors.white1.withValues(alpha: 0.1),
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
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.white1.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 48,
              color: AppColors.white1,
            ),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: AppTypography.headingMedium.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: AppTypography.bodyMedium.copyWith(
              color: AppColors.grey1,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.white1,
                foregroundColor: AppColors.black1,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(buttonText),
            ),
          ),
        ],
      ),
    );
  }
}
