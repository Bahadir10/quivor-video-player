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
          foregroundColor: WidgetStatePropertyAll(Color(0xFFFFFFFF)),
          backgroundColor: WidgetStatePropertyAll(Color(0xFF000000))),
    );
  }
}
