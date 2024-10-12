import 'package:app_materials/app_materials.dart';
import 'package:flutter/material.dart';
import 'package:nexor/nexor.dart';

class CustomDropdown<T> extends StatelessWidget {
  final void Function(T?)? onSelected;
  final List<DropdownMenuEntry<T>> dropdownMenuEntries;
  final double? width;
  final bool enableSearch;
  final T? initialSelection;
  final String? hintText;
  const CustomDropdown(
      {super.key,
      this.onSelected,
      required this.dropdownMenuEntries,
      this.initialSelection,
      this.width,
      this.enableSearch = true,
      this.hintText});

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<T>(
        width: width,
        enableSearch: enableSearch,
        inputDecorationTheme: const InputDecorationTheme(
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.white1)),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.white1))),
        menuStyle:
            MenuStyle(backgroundColor: AppColors.white1.widgetStatePropertyAll),
        trailingIcon: AppIcons.arrowDown,
        hintText: hintText,
        initialSelection: initialSelection,
        onSelected: onSelected,
        textStyle: AppTypography.bodySmall,
        dropdownMenuEntries: dropdownMenuEntries);
  }
}
