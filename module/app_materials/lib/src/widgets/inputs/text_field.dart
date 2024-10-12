import 'package:app_materials/app_materials.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final void Function(String)? onChanged;
  final String? hintText;
  const CustomTextField({
    super.key,
    this.onChanged,
    this.controller,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: AppTypography.bodyMedium,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppTypography.bodySmall.copyWith(color: AppColors.grey4),
          filled: true,
          fillColor: AppColors.black3,
          focusedBorder: OutlineInputBorder(
            borderRadius: Cutter.small.all,
            borderSide: BorderSide(color: AppColors.blue1),
          ),
          border: OutlineInputBorder(
            borderRadius: Cutter.small.all,
            borderSide: BorderSide(color: AppColors.grey1),
          )),
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(value.trim());
        }
      },
    );
  }
}
