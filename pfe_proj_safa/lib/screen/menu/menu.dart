import 'package:flutter/material.dart';
import 'package:pfe_proj_safa/utils/services/authentication.dart';
import 'package:pfe_proj_safa/utils/shared/widget/alert_snack_bar.dart';

import '../../utils/theme/colors.dart';
import '../../utils/shared/widget/banner.dart';
import 'option.dart';

class MyMenu extends StatelessWidget {
  const MyMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: Column(
          children: [
            const MyMenuBanner(title: "Menu"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyMenuOption(
                        icon: Icons.query_stats_outlined,
                        text: "Stats",
                        onTap: () => Navigator.pushNamed(context, "/stats"),
                      ),
                      MyMenuOption(
                        icon: Icons.battery_alert_outlined,
                        text: "Alert",
                        onTap: () => Navigator.pushNamed(context, "/alert"),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      MyMenuOption(
                        icon: Icons.logout,
                        text: "Deconnecter",
                        onTap: () {
                          AuthServices().signOut();
                          Navigator.pushNamed(context, "/login");
                        },
                      ),
                      MyMenuOption(
                        icon: Icons.info_outlined,
                        text: "A propos",
                        onTap: () => Navigator.pushNamed(context, "/about"),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
