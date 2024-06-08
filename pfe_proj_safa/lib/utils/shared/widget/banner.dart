import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyMenuBanner extends StatelessWidget {
  final String title;
  const MyMenuBanner({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150,
          margin: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                const Color.fromARGB(255, 1, 32, 99).withOpacity(0.9),
                const Color.fromARGB(255, 60, 150, 172).withOpacity(0.7),
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [
              BoxShadow(
                color: Colors.black38,
                blurRadius: 9,
                blurStyle: BlurStyle.normal,
                spreadRadius: 3,
              ),
            ],
          ),
        ),
        Positioned(
          right: -10,
          top: 11,
          child: Transform.rotate(
            angle: 0.2,
            child: Opacity(
              opacity: 0.6,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  "assets/images/energie.png",
                  width: 250,
                  height: 150,
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          left: 40,
          top: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 5,
                ),
              ),
            ],
          ),
        ),
        if (title != "Menu")
          Positioned(
            right: 10,
            top: 10,
            child: IconButton(
              icon: Icon(
                Icons.arrow_forward_ios,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
      ],
    );
  }
}
