part of '../play.dart';

class _NextEpisodeButton extends StatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onCancel;
  final int secondsRemaining;
  final bool autoPlayEnabled;

  const _NextEpisodeButton({
    required this.onNext,
    required this.onCancel,
    required this.secondsRemaining,
    required this.autoPlayEnabled,
  });

  @override
  State<_NextEpisodeButton> createState() => _NextEpisodeButtonState();
}

class _NextEpisodeButtonState extends State<_NextEpisodeButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  Timer? _autoPlayTimer;
  int _countdown = 0;

  @override
  void initState() {
    super.initState();
    _countdown = widget.secondsRemaining;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.2, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    ));

    _controller.forward();

    if (widget.autoPlayEnabled) {
      _startAutoPlayTimer();
    }
  }

  void _startAutoPlayTimer() {
    _autoPlayTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_countdown > 0) {
        setState(() => _countdown--);
      } else {
        timer.cancel();
        widget.onNext();
      }
    });
  }

  @override
  void dispose() {
    _autoPlayTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _slideAnimation,
      child: Align(
        alignment: Alignment.bottomRight,
        child: Container(
          margin: const EdgeInsets.all(32),
          constraints: const BoxConstraints(maxWidth: 380),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.black2.withValues(alpha: 0.98),
                AppColors.black1.withValues(alpha: 0.95),
              ],
            ),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: AppColors.white1.withValues(alpha: 0.15),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.6),
                blurRadius: 30,
                spreadRadius: 5,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: AppColors.white1.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.play_circle_outline,
                            size: 32,
                            color: AppColors.white1,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sonraki Bölüm',
                                style: AppTypography.bodyLarge.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                              const SizedBox(height: 4),
                              if (widget.autoPlayEnabled)
                                Row(
                                  children: [
                                    Icon(
                                      Icons.timer_outlined,
                                      size: 16,
                                      color: AppColors.grey1,
                                    ),
                                    const SizedBox(width: 6),
                                    Text(
                                      '$_countdown saniye içinde başlayacak',
                                      style: AppTypography.bodySmall.copyWith(
                                        color: AppColors.grey1,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          ),
                        ),
                        if (widget.autoPlayEnabled)
                          SizedBox(
                            width: 48,
                            height: 48,
                            child: Stack(
                              children: [
                                CircularProgressIndicator(
                                  value: _countdown / widget.secondsRemaining,
                                  strokeWidth: 4,
                                  backgroundColor:
                                      AppColors.grey1.withValues(alpha: 0.2),
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    AppColors.white1,
                                  ),
                                ),
                                Center(
                                  child: Text(
                                    '$_countdown',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            onPressed: () {
                              _autoPlayTimer?.cancel();
                              _controller.reverse().then((_) {
                                widget.onCancel();
                              });
                            },
                            icon: const Icon(Icons.close, size: 18),
                            label: const Text('İptal'),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: AppColors.white1,
                              side: BorderSide(
                                color: AppColors.white1.withValues(alpha: 0.3),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          flex: 2,
                          child: ElevatedButton.icon(
                            onPressed: () {
                              _autoPlayTimer?.cancel();
                              widget.onNext();
                            },
                            icon: const Icon(Icons.skip_next, size: 20),
                            label: const Text('Şimdi Oynat'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.white1,
                              foregroundColor: AppColors.black1,
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
