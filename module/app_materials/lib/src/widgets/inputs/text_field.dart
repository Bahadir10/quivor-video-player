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
          hintStyle: AppTypography.bodySmall.copyWith(color: Color(0xFFb7b7b7)),
          filled: true,
          fillColor: Color(0xFF2c2c2c),
          //hintText: 'Enter your text here',
          border: OutlineInputBorder(
            borderRadius: Cutter.small.all,
            borderSide: BorderSide(color: Colors.grey),
          )),
      onChanged: (value) {
        if (onChanged != null) {
          onChanged!(value.trim());
        }
      },
    );
  }
}
