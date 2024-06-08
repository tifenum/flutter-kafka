import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../utils/theme/colors.dart';

class statsCurve extends StatefulWidget {
  final int variable;
  final int statsBy;
  const statsCurve({super.key, required this.variable, required this.statsBy});

  @override
  State<statsCurve> createState() => _statsCurveState();
}

class _statsCurveState extends State<statsCurve> {
  List<Color> gradientColors = [
    AppColors.contentColorCyan,
    AppColors.contentColorBlue,
  ];

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.70,
      child: Padding(
        padding: const EdgeInsets.only(
          right: 18,
          left: 12,
          top: 24,
          bottom: 12,
        ),
        child: mainData(),
      ),
    );
  }

  mainData() {
    return FutureBuilder(
      future: getValues(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (!snapshot.hasData) {
          return const Text("ee");
        }
        List values = snapshot.data!;
        return LineChart(
          LineChartData(
            gridData: FlGridData(
              show: true,
              drawVerticalLine: true,
              horizontalInterval: 1,
              verticalInterval: 1,
              getDrawingHorizontalLine: (value) {
                return const FlLine(
                  color: AppColors.mainGridLineColor,
                  strokeWidth: 1,
                );
              },
              getDrawingVerticalLine: (value) {
                return const FlLine(
                  color: AppColors.mainGridLineColor,
                  strokeWidth: 1,
                );
              },
            ),
            titlesData: FlTitlesData(
              show: true,
              rightTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              topTitles: const AxisTitles(
                sideTitles: SideTitles(showTitles: false),
              ),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  reservedSize: 30,
                  interval: 1,
                  getTitlesWidget: bottomTitleWidgets,
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: leftTitleWidgets,
                  reservedSize: 42,
                ),
              ),
            ),
            borderData: FlBorderData(
              show: true,
              border: Border.all(color: const Color(0xff37434d)),
            ),
            minX: 0,
            maxX: 11,
            minY: 0,
            maxY: widget.variable == 2 ? 50 : 100,
            lineBarsData: [
              LineChartBarData(
                spots: values
                    .map(
                      (e) => FlSpot(
                        values.indexOf(e).toDouble(),
                        double.parse(
                                  e.toString(),
                                ) >
                                100
                            ? 100
                            : double.parse(
                                e.toString(),
                              ),
                      ),
                    )
                    .toList(),
                isCurved: true,
                gradient: LinearGradient(
                  colors: gradientColors,
                ),
                barWidth: 5,
                isStrokeCapRound: true,
                dotData: const FlDotData(
                  show: false,
                ),
                belowBarData: BarAreaData(
                  show: true,
                  gradient: LinearGradient(
                    colors: gradientColors
                        .map((color) => color.withOpacity(0.3))
                        .toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

// Future<List<double>> getValues() async { // Specify the return type as List<double>
//   String variable = "";
//   switch (widget.statsBy) {
//     case 0:
//       variable = "last-day";
//       break;
//     case 1:
//       variable = "last-week";
//       break;
//     case 2:
//       variable = "last-month";
//       break;
//     default:
//   }

//   try {
//     final response = await http.get(Uri.http('192.168.1.13:3010', '/api/$variable/${widget.variable}'));
//     if (response.statusCode == 200) {
//       final List<dynamic> jsonData = json.decode(response.body);
//       List<double> values = jsonData.map((value) => double.parse(value)).toList();
//       return values;
//     } else {
//       throw Exception('Failed to load data');
//     }
//   } catch (e) {
//     print('Error fetching data: $e');
//     return []; // Return an empty list in case of error
//   }
// }
Future<List<double>> getValues() async {
  String variable = "";
  switch (widget.statsBy) {
    case 0:
      variable = "last-day";
      break;
    case 1:
      variable = "last-week";
      break;
    case 2:
      variable = "last-month";
      break;
    default:
  }
    String variable1 = "";
    switch (widget.variable) {
      case 0:
        variable1 = "energie";
        break;
      case 1:
        variable1 = "power";
        break;
      case 2:
        variable1 = "courant";
        break;
      default:
    }

  try {
    final response = await http.get(Uri.http('192.168.1.41:3010', '/api/values/$variable/$variable1'));
    print("/api/$variable/$variable1");
    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      List<double> values = [];
      print(jsonData);
      for (var value in jsonData) {
        if (value is int) {
          values.add(value.toDouble());
        } else if (value is double) {
          values.add(value);
        } else if (value is String) {
          try {
            values.add(double.parse(value));
          } catch (e) {
            print('Error parsing value $value: $e');
          }
        }
      }

      return values;
    } else {
      throw Exception('Failed to load data');
    }
  } catch (e) {
    print('Error fetching data: $e');
    return []; // Return an empty list in case of error
  }
}


  // Future<List> getValues() async {
  //   String variable = "";
  //   switch (widget.variable) {
  //     case 0:
  //       variable = "energie";
  //       break;
  //     case 1:
  //       variable = "power";
  //       break;
  //     case 2:
  //       variable = "courant";
  //       break;
  //     default:
  //   }
  //   final snapshot = await FirebaseFirestore.instance
  //       .collection(variable)
  //       .doc(variable)
  //       .get();
  //   print(snapshot.data());
  //   final doc = snapshot.data();
  //   final data = doc![variable];
  //   List months = data["month"];
  //   List weeks = months.last["week"];
  //   List days = weeks.last["day"];
  //   switch (widget.statsBy) {
  //     case 0:
  //       List values = [];
  //       for (int i = 0; i < days.length; i++) {
  //         values.add(days[i]["value"]);
  //       }
  //       print(values);
  //       return values;

  //     case 1:
  //       List values = [];
  //       for (int i = 0; i < weeks.length; i++) {
  //         values.add(weeks[i]["total"]);
  //       }
  //       return values;
  //     case 2:
  //       List values = [];
  //       for (int i = 0; i < months.length; i++) {
  //         values.add(months[i]["total"]);
  //       }
  //       return values;
  //     default:
  //       return [];
  //   }
  // }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    if (widget.statsBy == 0) {
      const style = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      );
      Widget text;
      switch (value.toInt()) {
        case 1:
          text = const Text('D1', style: style);
          break;
        case 3:
          text = const Text('D2', style: style);
          break;
        case 5:
          text = const Text('D3', style: style);
          break;
        case 7:
          text = const Text('D4', style: style);
          break;
        case 9:
          text = const Text('D5', style: style);
          break;
        default:
          text = const Text('', style: style);
          break;
      }

      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: text,
      );
    } else if (widget.statsBy == 1) {
      const style = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      );
      Widget text;
      switch (value.toInt()) {
        case 1:
          text = const Text('S1', style: style);
          break;
        case 4:
          text = const Text('S2', style: style);
          break;
        case 7:
          text = const Text('S3', style: style);
          break;
        case 10:
          text = const Text('S4', style: style);
          break;
        default:
          text = const Text('', style: style);
          break;
      }

      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: text,
      );
    } else {
      const style = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      );
      Widget text;
      switch (value.toInt()) {
        case 2:
          text = const Text('MAR', style: style);
          break;
        case 5:
          text = const Text('JUN', style: style);
          break;
        case 8:
          text = const Text('SEP', style: style);
          break;
        default:
          text = const Text('', style: style);
          break;
      }

      return SideTitleWidget(
        axisSide: meta.axisSide,
        child: text,
      );
    }
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    if (widget.variable == 0) {
      const style = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
      );
      String text;
      switch (value.toInt()) {
        case 10:
          text = '10 KW';
          break;
        case 50:
          text = '50 kW';
          break;
        case 99:
          text = '100 kW';
          break;
        default:
          return Container();
      }

      return Text(text, style: style, textAlign: TextAlign.left);
    } else if (widget.variable == 1) {
      const style = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
      );
      String text;
      switch (value.toInt()) {
        case 10:
          text = '10 KW';
          break;
        case 50:
          text = '50 kW';
          break;
        case 99:
          text = '100 kW';
          break;
        default:
          return Container();
      }

      return Text(text, style: style, textAlign: TextAlign.left);
    } else {
      const style = TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 15,
      );
      String text;
      switch (value.toInt()) {
        case 10:
          text = '10 A';
          break;
        case 30:
          text = '30 A';
          break;
        case 50:
          text = '50 A';
          break;
        default:
          return Container();
      }

      return Text(text, style: style, textAlign: TextAlign.left);
    }
  }
}
