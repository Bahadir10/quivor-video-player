import 'package:app_materials/app_materials.dart';
import 'package:flutter/widgets.dart';

class CustomProgressIndicator extends StatelessWidget {
  final double percentage;
  const CustomProgressIndicator({super.key, required this.percentage});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: AppColors.white1,
          width: 100,
          height: 1.5,
        ),
        Container(
          color: AppColors.blue2,
          width: percentage,
          height: 1.5,
        ),
      ],
    );
  }
}
