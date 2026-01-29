import 'package:app_materials/app_materials.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:nexor/nexor.dart';

import 'package:quivor/core/bloc/cubits/recent_video.dart';

import 'package:quivor/core/enum/standarts.dart';
import 'package:quivor/core/service/error/error_handler.dart';
import 'package:quivor/core/service/logger/logger_service.dart';
import 'package:quivor/core/service/env/env_config_service.dart';
import 'package:quivor/core/localization/localization_service.dart';
import 'package:quivor/core/localization/easy_localization_impl.dart';
import 'package:quivor/getit_settings.dart';
import 'package:quivor/intialize.dart';

import 'package:quivor/views/home/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  // Initialize logger
  logger.init();
  logger.info('🚀 Application starting...');

  // Initialize error handler
  errorHandler.init();
  logger.info('✅ Error handler initialized');

  // Initialize environment configuration
  await envConfig.initialize();
  logger.info('✅ Environment configuration loaded');

  // Initialize app
  await AppInitialize().run();
  logger.info('✅ App initialization completed');

  // Initialize localization service
  initLocalizationService(EasyLocalizationService());
  logger.info('✅ Localization service initialized');

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('tr')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const Quivor(),
    ),
  );
}

class Quivor extends StatelessWidget {
  const Quivor({super.key});

  @override
  Widget build(BuildContext context) {
    final standarts = {
      Standarts.low.name: Standarts.low.value,
      Standarts.small.name: Standarts.small.value,
      Standarts.medium.name: Standarts.medium.value,
      Standarts.high.name: Standarts.high.value,
    };
    return BlocProvider(
      create: (BuildContext context) => getIt<RecentVideosCubit>(),
      child: MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        theme: ThemeData(
          brightness: Brightness.dark,
          scaffoldBackgroundColor: AppColors.black2,

          // AppBar theme
          appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.white1,
            foregroundColor: AppColors.black1,
          ),

          // Dialog theme
          dialogTheme: DialogThemeData(
            backgroundColor: AppColors.black2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),

          // Slider theme
          sliderTheme: SliderThemeData(
            activeTrackColor: AppColors.white1,
            inactiveTrackColor: AppColors.grey1.withValues(alpha: 0.3),
            thumbColor: AppColors.white1,
            overlayColor: AppColors.white1.withValues(alpha: 0.2),
            valueIndicatorColor: AppColors.white1,
            valueIndicatorTextStyle: const TextStyle(
              color: AppColors.black1,
            ),
          ),

          // Radio button theme
          radioTheme: RadioThemeData(
            fillColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.white1;
              }
              return AppColors.grey1;
            }),
          ),

          // Icon theme
          iconTheme: const IconThemeData(
            color: AppColors.white1,
          ),

          // Text theme
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: AppColors.white1),
            bodyMedium: TextStyle(color: AppColors.white1),
            bodySmall: TextStyle(color: AppColors.grey1),
          ),

          // Page transitions
          pageTransitionsTheme: PageTransitionsTheme(
            builders: Map<TargetPlatform, PageTransitionsBuilder>.fromIterable(
              TargetPlatform.values,
              value: (_) => const FadeUpwardsPageTransitionsBuilder(),
            ),
          ),

          // Extensions
          extensions: [NexorSpacerThemeExtension(standarts: standarts)],
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
