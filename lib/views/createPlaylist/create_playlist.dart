import 'dart:io';

import 'package:app_materials/app_materials.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:nexor/nexor.dart';
import 'package:quivor/core/enum/route.dart';
import 'package:quivor/core/extensions/build_context.dart';
import 'package:quivor/core/fileManager/interface.dart';
import 'package:quivor/core/models/entities/video.dart';
import 'package:quivor/core/service/interface/playlist.dart';
import 'package:quivor/core/service/interface/video.dart';
import 'package:quivor/core/service/responseModel/playlist_state.dart';
import 'package:quivor/getit_settings.dart';
import 'package:quivor/utils/material_standarts.dart';
import 'package:quivor/utils/strings.dart';
import 'package:quivor/views/playlist/playlist.dart';

import 'package:responsive_builder/responsive_builder.dart';
import 'package:path/path.dart' as p;
part 'viewModel/cubit/_cubit.dart';
part 'viewModel/cubit/_state.dart';

class CreatePlaylistScreen extends StatelessWidget {
  const CreatePlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _ScreenCubit(context),
      child: Scaffold(
        appBar: AppBar(),
        body: BlocBuilder<_ScreenCubit, _ScreenState>(
          builder: (context, state) {
            final cubit = context.cubit<_ScreenCubit>();
            final paths = state.playlistItems;
            if (state.choise == true) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomTextField(
                    onChanged: cubit.updatePlaylistName,
                  ),
                  context.spacer.vertical(AppStandarts.high),
                  CustomFilledButton(
                    onPressed: () async => cubit.createEmptyPlaylist(),
                    text: Strings.create(),
                  )
                ],
              );
            }

            if (paths.isNotNull) {
              return Padding(
                padding: Paddings.medium.all,
                child: Column(
                  children: [
                    CustomTextField(
                      controller: cubit.playlistNameController,
                    ),
                    Spacers.small.vertical,
                    Expanded(
                      child: ListView(
                        shrinkWrap: true,
                        children: [
                          for (final item in paths!)
                            Padding(
                              padding: Paddings.small.vertical,
                              child:
                                  Text(item, style: AppTypography.bodyMedium),
                            )
                        ],
                      ),
                    ),
                    CustomFilledButton(
                      onPressed: () async =>
                          await cubit.createPlaylistFromPath(),
                      text: Strings.create(),
                    )
                  ],
                ),
              );
            }

            final itemFromFolder = _selectionItem(
                'From Folder',
                Icon(Icons.folder_open_rounded, color: Colors.white),
                'Select Folder',
                true,
                context);
            final emptyList = _selectionItem(
                'Empty',
                Icon(
                  Icons.playlist_add,
                  color: Colors.white,
                ),
                'Create New',
                false,
                context);
            return ScreenTypeLayout.builder(
              desktop: (context) {
                return Column(
                  children: [
                    Spacer(),
                    Row(
                      children: [
                        Spacer(flex: 1),
                        Expanded(
                          flex: 2,
                          child: itemFromFolder,
                        ),
                        Spacers.high.horizontal,
                        Expanded(
                          flex: 2,
                          child: emptyList,
                        ),
                        Spacer(flex: 1)
                      ],
                    ),
                    Spacer(),
                  ],
                );
              },
              mobile: (context) {
                return Center(
                  child: Padding(
                    padding: Paddings.medium.all,
                    child: Container(
                      height: 240,
                      decoration: BoxDecoration(
                          color: Color(0xFF2c2c2c),
                          borderRadius: Cutter.medium.all),
                      child: Padding(
                        padding: Paddings.medium.all,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            _mobileSelectionItem(
                                'From Folder',
                                Icon(Icons.folder_open_rounded,
                                    color: Colors.white),
                                'Select Folder'),
                            Container(
                              height: 220,
                              width: 1,
                              decoration: BoxDecoration(
                                  color: Color(0xFF656565),
                                  borderRadius: Cutter.medium.all),
                            ),
                            _mobileSelectionItem(
                                'Empty',
                                Icon(
                                  Icons.playlist_add,
                                  color: Colors.white,
                                ),
                                'Create New')
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _mobileSelectionItem(String text, Icon icon, String buttonText) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        icon,
        Spacers.small.vertical,
        Text(
          text,
          style: AppTypography.headingSmall,
        ),
        Spacers.medium.vertical,
        CustomFilledButton(
          onPressed: () => {},
          text: buttonText,
        ),
      ],
    );
  }

  Widget _selectionItem(String text, Icon icon, String buttonText,
      bool openFolder, BuildContext context) {
    return Container(
        height: 240,
        decoration: BoxDecoration(
            color: Color(0xFF2c2c2c), borderRadius: Cutter.medium.all),
        child: Padding(
          padding: Paddings.high.horizontal,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              icon,
              Spacers.small.vertical,
              Text(
                text,
                style: AppTypography.headingSmall,
              ),
              Spacers.medium.vertical,
              CustomFilledButton(
                onPressed: () async {
                  if (openFolder) {
                    await context.cubit<_ScreenCubit>().openPath();
                  } else {
                    context.cubit<_ScreenCubit>().makeChoise();
                  }
                },
                text: buttonText,
              ),
            ],
          ),
        ));
  }
}
