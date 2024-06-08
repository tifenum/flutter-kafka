import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pfe_proj_safa/screen/home/banner.dart';
import 'package:pfe_proj_safa/utils/theme/colors.dart';
import 'values_widget.dart';

class MyHomeScreen extends StatefulWidget {
  const MyHomeScreen({Key? key}) : super(key: key);

  @override
  _MyHomeScreenState createState() => _MyHomeScreenState();
}

class _MyHomeScreenState extends State<MyHomeScreen> {
  late Timer _timer;
  Map<String, dynamic>? _values;
double p = 0.0;
double c = 0.0;
double e = 0.0;
String id = '';
String power = '0.0';
String courant = '0.0';
String energie = '0.0';
  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 1), (_) => fetchData());
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }


Future<void> fetchData() async {
  try {
    var response = await http.get(
      Uri.http('192.168.1.41:3010', '/api/values')
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      String currentId = data['_id'].toString();

      if (currentId != id || id.isEmpty) { 
        setState(() {
          id = currentId;
          e += _parseDynamicToDouble(data['energie']);
          c += _parseDynamicToDouble(data['courant']);
          p += _parseDynamicToDouble(data['power']);
          energie = formatDouble(e);
          courant = formatDouble(c);
          power = formatDouble(p);
          _values = data;
        });
      }
    } else {
      print('Failed to load data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error fetching data: $e');
  }
}

double _parseDynamicToDouble(dynamic value) {
  if (value is int) {
    return value.toDouble();
  } else if (value is double) {
    return value;
  } else {
    throw Exception('Unexpected value type');
  }
}

  void resetValues() {
    setState(() {
      e = 0.0;
      c = 0.0;
      p = 0.0;
      energie = '0.0';
      courant = '0.0';
      power = '0.0';
    });
  }

String formatDouble(double value) {
  return value.toStringAsFixed(2);
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const MyBanner(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                child: _values != null
                    ? Column(
                        children: [
                          MyValuesWidget(
                            color: Colors.amber,
                            icon: Icons.battery_charging_full_outlined,
                            value: "${energie} KW",
                            text: "Energie",
                          ),
                          SizedBox(height: 15),
                          MyValuesWidget(
                            color: Colors.blueAccent,
                            icon: Icons.electric_bolt_outlined,
                            value: "${power} KW",
                            text: "Power",
                          ),
                          SizedBox(height: 15),
                          MyValuesWidget(
                            color: Colors.purpleAccent,
                            icon: Icons.electrical_services_outlined,
                            value: "${courant} A",
                            text: "Courant",
                          ),
                          SizedBox(height: 15),
                          ElevatedButton(
                            onPressed: resetValues,
                            child: Text('Reset Values'),
                          ),
                        ],
                      )
                    : const Center(child: CircularProgressIndicator()),
              ),
            ],
          ),
        ),
      ),
    );
  }
}