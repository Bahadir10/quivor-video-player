import 'package:app_materials/app_materials.dart';
import 'package:flutter/material.dart';

class CustomFilledButton extends StatelessWidget {
  final void Function()? onPressed;
  final String text;
  const CustomFilledButton({super.key, this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(text),
      style: ButtonStyle(
          overlayColor: WidgetStateProperty.resolveWith<Color>(
            (states) {
              if (states.contains(WidgetState.hovered)) {
                return AppColors.grey3;
              }
              return AppColors.grey4;
            },
          ),
          foregroundColor: WidgetStatePropertyAll(AppColors.white1),
          backgroundColor: WidgetStatePropertyAll(AppColors.black1)),
    );
  }
}
