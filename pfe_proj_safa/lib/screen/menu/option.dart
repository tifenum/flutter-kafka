import 'package:flutter/material.dart';
import 'package:pfe_proj_safa/utils/theme/colors.dart';

class MyMenuOption extends StatelessWidget {
  final String text;
  final IconData icon;
  final void Function()? onTap;
  const MyMenuOption(
      {super.key, required this.text, required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        children: [
          Container(
            height: 100,
            width: MediaQuery.of(context).size.width * 0.43,
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.onBackground,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(60),
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadowLight,
                  blurRadius: 9,
                  blurStyle: BlurStyle.normal,
                  spreadRadius: 3,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 50,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: AppColors.primaryVariant,
              borderRadius: BorderRadius.circular(50),
            ),
            child: Center(child: Icon(icon, color: AppColors.white, size: 30)),
          )
        ],
      ),
    );
  }
}
