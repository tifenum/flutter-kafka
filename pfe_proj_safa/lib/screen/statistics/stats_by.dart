import 'package:flutter/material.dart';
import 'package:pfe_proj_safa/utils/theme/colors.dart';

class MyStatByWidget extends StatelessWidget {
  final String text;
  final void Function()? onTap;
  final bool selected;
  const MyStatByWidget(
      {super.key, this.onTap, required this.text, required this.selected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        decoration: BoxDecoration(
          color: selected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: selected ? Colors.white : AppColors.primary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
