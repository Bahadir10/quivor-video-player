import 'package:flutter/material.dart';
import 'package:app_materials/app_materials.dart';

class CustomIconTextButton extends StatelessWidget {
  final String text;
  final Icon icon;
  final void Function()? onPressed;
  const CustomIconTextButton(
      {super.key, required this.icon, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton.icon(
      onPressed: onPressed,
      label: Text(text),
      icon: icon,
      style: ButtonStyle(
          overlayColor: WidgetStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(WidgetState.hovered)) {
                return AppColors.grey3;
              }
              return AppColors.grey4;
            },
          ),
          foregroundColor: const WidgetStatePropertyAll(AppColors.white1)),
    );
  }
}
