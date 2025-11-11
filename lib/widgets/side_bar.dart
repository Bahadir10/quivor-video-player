import 'package:app_materials/app_materials.dart';
import 'package:flutter/material.dart';
import 'package:nexor/nexor.dart';
import 'package:quivor/core/enum/route.dart';
import 'package:quivor/core/extensions/build_context.dart';
import 'package:quivor/core/fileManager/interface.dart';
import 'package:quivor/core/models/entities/video.dart';
import 'package:quivor/core/service/interface/video.dart';
import 'package:quivor/getit_settings.dart';
import 'package:quivor/views/play/play.dart';
import 'package:path/path.dart' as p;

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: context.col(2),
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
            right: BorderSide(
              color: AppColors.white1.withValues(alpha: 0.1),
              width: 1,
            ),
          ),
        ),
        child: Column(
          children: [
            const SizedBox(height: 24),

            // Logo/Brand area
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.white1.withValues(alpha: 0.15),
                      AppColors.white1.withValues(alpha: 0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.white1,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.play_circle_filled,
                        color: AppColors.black1,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Quivor',
                      style: TextStyle(
                        color: AppColors.white1,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Navigation buttons
            _NavButton(
              icon: Icons.home_rounded,
              text: 'Home',
              onPressed: () => navigate(context, AppRoute.home),
            ),
            const SizedBox(height: 8),
            _NavButton(
              icon: Icons.playlist_add_rounded,
              text: 'Create Playlist',
              onPressed: () => navigate(context, AppRoute.createPlaylist),
            ),
            const SizedBox(height: 8),
            _NavButton(
              icon: Icons.settings_rounded,
              text: 'Settings',
              onPressed: () => navigate(context, AppRoute.settings),
            ),

            const SizedBox(height: 24),

            // Divider
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                height: 1,
                color: AppColors.white1.withValues(alpha: 0.1),
              ),
            ),

            const SizedBox(height: 24),

            // Quick action card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.white1.withValues(alpha: 0.1),
                      AppColors.white1.withValues(alpha: 0.05),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColors.white1.withValues(alpha: 0.15),
                    width: 1,
                  ),
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.white1.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.video_file_rounded,
                        size: 48,
                        color: AppColors.white1,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Open Video',
                        style: TextStyle(
                          color: AppColors.white1,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        'Select video from your computer',
                        style: TextStyle(
                          color: AppColors.grey1.withValues(alpha: 0.8),
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          onPressed: () async {
                            final x =
                                await getIt<IFileManager>().getVideoFile();

                            if (x != null) {
                              VideoEntity? vid = await getIt<IVideoService>()
                                  .getVideoByPathOrNull(x);
                              if (vid.isNotNull) {
                              } else {
                                vid = await getIt<IVideoService>()
                                    .createVideo(name: p.basename(x), path: x);
                              }
                              context.go(AppRoute.player,
                                  data: PlayScreenParameters(paths: [vid!]));
                            }
                          },
                          icon: const Icon(Icons.folder_open, size: 18),
                          label: const Text('Select File'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.white1,
                            foregroundColor: AppColors.black1,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            const Spacer(),

            // Footer
            Padding(
              padding: const EdgeInsets.all(16),
              child: Text(
                'v1.0.0',
                style: TextStyle(
                  color: AppColors.grey1.withValues(alpha: 0.5),
                  fontSize: 11,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void navigate(BuildContext context, AppRoute route) =>
      context.goOffAll(route);
}

class _NavButton extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onPressed;

  const _NavButton({
    required this.icon,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: AppColors.white1.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.white1.withValues(alpha: 0.1),
              ),
            ),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: AppColors.white1,
                  size: 22,
                ),
                const SizedBox(width: 12),
                Text(
                  text,
                  style: const TextStyle(
                    color: AppColors.white1,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
