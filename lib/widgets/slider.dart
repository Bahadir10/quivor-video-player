import 'package:app_materials/app_materials.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class CustomSlider extends StatelessWidget {
  final double value;
  final void Function(double)? onChanged;
  const CustomSlider({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Slider(
      activeColor: AppColors.blue1,
      min: 0,
      max: 100,
      value: value,
      onChanged: onChanged,
    );
  }
}
