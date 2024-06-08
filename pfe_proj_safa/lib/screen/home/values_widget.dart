import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pfe_proj_safa/utils/theme/colors.dart';

class MyValuesWidget extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String value;
  final String text;
  const MyValuesWidget(
      {super.key,
      required this.color,
      required this.icon,
      required this.value,
      required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: AppColors.onBackground,
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 9,
            blurStyle: BlurStyle.normal,
            spreadRadius: 3,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(
                color: color,
                width: 4,
              ),
              borderRadius: BorderRadius.circular(50),
            ),
            child: Icon(
              icon,
              color: color,
              size: 50,
            ),
          ),
          // SizedBox(width: 30),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  value,
                  style: TextStyle(
                    color: color,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  text,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
