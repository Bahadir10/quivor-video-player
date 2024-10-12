import 'package:app_materials/app_materials.dart';
import 'package:flutter/material.dart';

class CustomTextButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const CustomTextButton({super.key, this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text),
      style: ButtonStyle(
        foregroundColor: const WidgetStatePropertyAll(AppColors.white1),
        overlayColor: WidgetStateProperty.resolveWith<Color>(
          (states) {
            if (states.contains(WidgetState.hovered)) {
              return AppColors.grey3;
            }
            return AppColors.grey4;
          },
        ),
      ),
    );
  }
}
