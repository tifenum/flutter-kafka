import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pfe_proj_safa/utils/services/notification.dart';
import 'package:pfe_proj_safa/utils/shared/widget/alert_snack_bar.dart';
import 'package:pfe_proj_safa/utils/shared/widget/login_text_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../utils/theme/colors.dart';
import '../../utils/shared/widget/banner.dart';

class MyAlert extends StatefulWidget {
  const MyAlert({super.key});

  @override
  State<MyAlert> createState() => _MyAlertState();
}

class _MyAlertState extends State<MyAlert> {
  TextEditingController myController = TextEditingController();
  bool notification = false;
  getSeuil() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      myController.text = prefs.getString("seuil") ?? "";
      notification = prefs.getBool("notif") ?? false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSeuil();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const MyMenuBanner(title: "Alert"),
              const SizedBox(height: 10),
              Container(
                width: double.infinity,
                margin: const EdgeInsets.all(15),
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.onBackground,
                  boxShadow: [
                    const BoxShadow(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Activer la notification",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 60,
                          width: 60,
                          child: Checkbox(
                            value: notification,
                            onChanged: (value) {
                              setState(() {
                                notification = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Seuil de consommation",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 50,
                          width: 65,
                          child: MyLoginTextField(
                              text: "...",
                              isPassword: false,
                              myController: myController,
                              isNum: true,
                              isalert: true),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    GestureDetector(
                      onTap: () async {
                        if (myController.text.isEmpty) {
                          showErrorSnackBar(context,
                              "Veuillez entrer un seuil de consommation");
                          return;
                        }
                        final prefs = await SharedPreferences.getInstance();
                        prefs.setString("seuil", myController.text);
                        prefs.setBool("notif", true);

                        setupNotification();
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.secondary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: 50,
                        width: 200,
                        child: const Center(
                          child: Text(
                            "Enregistrer",
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  setupNotification() {
    if (notification) {
      FirebaseFirestore.instance
          .collection("values")
          .doc("values")
          .snapshots()
          .listen(
        (event) {
          final data = event.data();
          final values = data!["values"];
          if (values["courant"] <= 0) {
            NotificationService.showCourantAlert();
          } else if (values["energie"] > double.parse(myController.text)) {
            NotificationService.showEnergieAlert();
          }
        },
      );
    } else {
      showErrorSnackBar(context, "Notification désactivée");
      return;
    }
    showSuccessSnackBar(
        context, "Seuil de consommation enregistré avec succès");
  }
}
