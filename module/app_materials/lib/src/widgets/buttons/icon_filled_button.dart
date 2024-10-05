import 'package:flutter/material.dart';

class CustomIconFilledButton extends StatelessWidget {
  final String text;
  final Icon icon;
  final void Function()? onPressed;
  const CustomIconFilledButton(
      {super.key, required this.icon, required this.text, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
        onPressed: onPressed, label: Text(text), icon: icon);
  }
}
