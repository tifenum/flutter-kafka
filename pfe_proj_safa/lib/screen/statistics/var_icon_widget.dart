import 'package:flutter/material.dart';
import 'package:pfe_proj_safa/utils/theme/colors.dart';

class MyVariableIcon extends StatelessWidget {
  final IconData icon;
  final String text;
  final void Function()? onTap;
  final bool selected;
  const MyVariableIcon(
      {super.key,
      required this.icon,
      this.onTap,
      required this.text,
      required this.selected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.background,
              border: selected
                  ? Border.all(
                      color: AppColors.primary,
                      width: 4,
                    )
                  : null,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              icon,
              color: selected
                  ? AppColors.primary
                  : AppColors.primary.withOpacity(0.7),
              size: 30,
            ),
          ),
          Text(
            text,
            style: TextStyle(
              color: selected ? AppColors.primary : Colors.grey,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
