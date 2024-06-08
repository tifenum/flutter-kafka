import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pfe_proj_safa/screen/auth/login.dart';
import 'package:pfe_proj_safa/utils/router/routers.dart';
import 'firebase_options.dart';
import 'utils/services/notification.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(fontFamily: GoogleFonts.robotoMono().fontFamily),
      home: const MyLoginScreen(),
      routes: AppRouters.routes,
    );
  }
}
