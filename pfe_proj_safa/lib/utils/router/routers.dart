import 'package:flutter/material.dart';
import 'package:pfe_proj_safa/screen/about.dart';
import 'package:pfe_proj_safa/screen/auth/login.dart';
import 'package:pfe_proj_safa/screen/home/home.dart';
import 'package:pfe_proj_safa/screen/navigation.dart';
import 'package:pfe_proj_safa/screen/statistics/stat.dart';
import 'package:pfe_proj_safa/screen/signup/signup.dart';

import '../../screen/alert/alert.dart';

class AppRouters {
  static String home = "/home";
  static String login = "/login";
  static String register = "/register";
  static String welcome = "/welcome";
  static String alert = "/alert";
  static String stats = "/stats";
  static String nav = "/nav";
  static String about = "/about";
  static String signup = "/signup"; // Add the signup route

  static Map<String, WidgetBuilder> routes = {
    home: (context) => const MyHomeScreen(),
    login: (context) => const MyLoginScreen(),
    about: (context) => const MyAbout(),
    alert: (context) => const MyAlert(),
    stats: (context) => const MyStats(),
    nav: (context) => const MyNavigationBar(),
    signup: (context) => const SignupPage(), // Add the SignupPage route
  };

}
