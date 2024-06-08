import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pfe_proj_safa/utils/services/authentication.dart';
import 'package:pfe_proj_safa/utils/theme/colors.dart';
import 'package:pfe_proj_safa/utils/shared/widget/login_text_field.dart';
import 'package:pfe_proj_safa/screen/signup/signup.dart';

import '../../utils/shared/widget/alert_snack_bar.dart';

class MyLoginScreen extends StatefulWidget {
  const MyLoginScreen({Key? key}) : super(key: key);

  @override
  State<MyLoginScreen> createState() => _MyLoginScreenState();
}

class _MyLoginScreenState extends State<MyLoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Image.asset("assets/images/logo.png", width: 200),
              const Text(
                "Energy Monitoring ",
                style: TextStyle(
                    fontSize: 25,
                    color: AppColors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1),
              ),
              const SizedBox(height: 40),
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30),
                    ),
                    color: AppColors.white,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Text(
                          "Bienvenue",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 2),
                        ),
                        const SizedBox(height: 30),
                        MyLoginTextField(
                          isPassword: false,
                          myController: emailController,
                          text: "Email",
                          icon: Icons.email_outlined,
                        ),
                        const SizedBox(height: 20),
                        MyLoginTextField(
                          isPassword: isPassword,
                          myController: passwordController,
                          text: "mot de passe",
                          icon: Icons.visibility_off_outlined,
                          onTap: () => setState(() {
                            isPassword = !isPassword;
                          }),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              showInfoSnackBar(context,
                                  "Mot de passe oublié ?\nContactez l'administrateur");
                            },
                            child: const Text(
                              "Mot de passe oublié ?",
                              style: TextStyle(
                                color: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Align(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
Navigator.pushNamed(context, "/signup");
                            },
                            child: const Text(
                              "Pas de compte ? Inscrivez-vous",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 30),
                        GestureDetector(
                          onTap: () async {
                            String? valid = verifieInputs();
                            if (valid != null) {
                              showErrorSnackBar(context, valid);
                            } else {
                              await AuthServices().signIn(
                                  context,
                                  emailController.text,
                                  passwordController.text);
                            }
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: AppColors.primary,
                            ),
                            child: const Center(
                              child: Text(
                                "Se connecter",
                                style: TextStyle(
                                    color: AppColors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String? verifieInputs() {
    // Perform input validation here
  }
}
