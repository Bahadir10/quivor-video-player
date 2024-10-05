import 'package:flutter/material.dart';

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
      style: ButtonStyle(foregroundColor: WidgetStatePropertyAll(Colors.white)),
    );
  }
}
