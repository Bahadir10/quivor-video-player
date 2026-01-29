part of '../play.dart';

class _AutoPlaySettings extends StatelessWidget {
  const _AutoPlaySettings();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<_ScreenCubit, PlayScreenState>(
      builder: (context, state) {
        final cubit = context.cubit<_ScreenCubit>();

        return Dialog(
          backgroundColor: AppColors.black2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Container(
            width: 350,
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Row(
                  children: [
                    const Icon(Icons.auto_awesome, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      LocaleKeys.autoplay_title.tr(),
                      style: AppTypography.bodyLarge.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.close, size: 20),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Mode selection - Simple list
                ...AutoPlayMode.values.map((mode) {
                  final isSelected = state.autoPlayMode == mode;
                  return InkWell(
                    onTap: () => cubit.setAutoPlayMode(mode),
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.white1.withValues(alpha: 0.1)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.white1
                              : AppColors.grey1.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            isSelected
                                ? Icons.radio_button_checked
                                : Icons.radio_button_unchecked,
                            size: 20,
                            color:
                                isSelected ? AppColors.white1 : AppColors.grey1,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  mode.displayName,
                                  style: AppTypography.bodyMedium.copyWith(
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                                ),
                                Text(
                                  mode.description,
                                  style: AppTypography.bodySmall.copyWith(
                                    color: AppColors.grey1,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),

                // Slider for early and autoTransition modes
                if (state.autoPlayMode == AutoPlayMode.early ||
                    state.autoPlayMode == AutoPlayMode.autoTransition) ...[
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.white1.withValues(alpha: 0.05),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(
                      children: [
                        Text(
                          '${LocaleKeys.autoplay_transition_time.tr()}: ${state.earlyTransitionSeconds} ${LocaleKeys.autoplay_seconds.tr()}',
                          style: AppTypography.bodyMedium.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            Text('5', style: AppTypography.bodySmall),
                            Expanded(
                              child: Slider(
                                value: state.earlyTransitionSeconds.toDouble(),
                                min: 5,
                                max: 60,
                                divisions: 11,
                                onChanged: (value) {
                                  cubit
                                      .setEarlyTransitionSeconds(value.toInt());
                                },
                              ),
                            ),
                            Text('60', style: AppTypography.bodySmall),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
