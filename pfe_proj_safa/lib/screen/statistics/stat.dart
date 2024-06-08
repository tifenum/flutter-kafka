import 'package:flutter/material.dart';
import '../../utils/theme/colors.dart';
import '../../utils/shared/widget/banner.dart';
import 'curve.dart';
import 'stats_by.dart';
import 'var_icon_widget.dart';

class MyStats extends StatefulWidget {
  const MyStats({super.key});

  @override
  State<MyStats> createState() => _MyStatsState();
}

class _MyStatsState extends State<MyStats> {
  int selectedVaribale = 0;
  int statsBy = 0;
  List variables = [];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const MyMenuBanner(title: "Statistiques"),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.onBackground,
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.shadowLight,
                        blurRadius: 9,
                        blurStyle: BlurStyle.normal,
                        spreadRadius: 3,
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MyVariableIcon(
                            icon: Icons.battery_charging_full_outlined,
                            selected: selectedVaribale == 0,
                            text: "Energie",
                            onTap: () {
                              setState(() {
                                selectedVaribale = 0;
                              });
                            },
                          ),
                          MyVariableIcon(
                            icon: Icons.electric_bolt_outlined,
                            text: "Power",
                            selected: selectedVaribale == 1,
                            onTap: () {
                              setState(() {
                                selectedVaribale = 1;
                              });
                            },
                          ),
                          MyVariableIcon(
                            icon: Icons.electrical_services_outlined,
                            text: "Courant",
                            selected: selectedVaribale == 2,
                            onTap: () {
                              setState(() {
                                selectedVaribale = 2;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          MyStatByWidget(
                            selected: statsBy == 0,
                            text: "Jour",
                            onTap: () {
                              setState(() {
                                statsBy = 0;
                              });
                            },
                          ),
                          MyStatByWidget(
                            selected: statsBy == 1,
                            text: "Semaine",
                            onTap: () {
                              setState(() {
                                statsBy = 1;
                              });
                            },
                          ),
                          MyStatByWidget(
                            selected: statsBy == 2,
                            text: "Mois",
                            onTap: () {
                              setState(() {
                                statsBy = 2;
                              });
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        height: 250,
                        width: double.infinity,
                        child: statsCurve(
                          variable: selectedVaribale,
                          statsBy: statsBy,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
