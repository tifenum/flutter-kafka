import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:pfe_proj_safa/screen/menu/menu.dart';
import 'package:pfe_proj_safa/utils/theme/colors.dart';

import 'home/home.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int selectedIndex = 0;
  final screen = [
    MyHomeScreen(),
    MyMenu(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: screen[selectedIndex],
        bottomNavigationBar: CurvedNavigationBar(
          animationDuration: Duration(milliseconds: 300),
          buttonBackgroundColor: AppColors.primary,
          height: 60,
          index: 0,
          color: AppColors.primary,
          items: [
            Icon(
              Icons.home_rounded,
              size: 40,
              color: Colors.white,
            ),
            Icon(
              Icons.menu_outlined,
              size: 40,
              color: Colors.white,
            ),
          ],
          backgroundColor: Colors.transparent,
          onTap: (value) => setState(() {
            selectedIndex = value;
          }),
        ),
      ),
    );
  }
}
