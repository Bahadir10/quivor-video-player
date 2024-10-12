import 'package:app_materials/app_materials.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:nexor/nexor.dart';

import 'package:quivor/core/bloc/cubits/recent_video.dart';

import 'package:quivor/core/enum/standarts.dart';
import 'package:quivor/getit_settings.dart';
import 'package:quivor/intialize.dart';

import 'package:quivor/views/home/home.dart';

Future<void> main() async {
  await AppInitialize().run();
  runApp(const Quivor());
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
        theme: ThemeData(
            extensions: [NexorSpacerThemeExtension(standarts: standarts)],
            scaffoldBackgroundColor: AppColors.black2,
            appBarTheme: const AppBarTheme(
                backgroundColor: AppColors.white1,
                foregroundColor: AppColors.black1)),
        home: const HomeScreen(),
      ),
    );
  }
}
