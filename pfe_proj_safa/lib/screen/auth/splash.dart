import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pfe_proj_safa/utils/theme/colors.dart';
import 'package:pfe_proj_safa/screen/auth/login.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  bool _visible = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 2),
      () => setState(() => _visible = false),
    );
    Timer(
      const Duration(seconds: 3),
      () => Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const MyLoginScreen(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Center(
        child: AnimatedOpacity(
          opacity: _visible ? 0.4 : 1.0,
          duration: const Duration(seconds: 1),
          child: Image.asset(
            'assets/images/logo.png',
            width: 200,
          ),
        ),
      ),
    );
  }
}
