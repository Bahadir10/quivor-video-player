import 'package:flutter/material.dart';

class AppCheckbox extends StatelessWidget {
  final bool value;
  final void Function(bool?)? onChanged;
  const AppCheckbox({super.key, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Checkbox(
        activeColor: Color(0xFF3A6D8C), value: value, onChanged: onChanged);
  }
}
