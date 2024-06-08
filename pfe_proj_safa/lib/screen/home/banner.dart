import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class MyBanner extends StatelessWidget {
  const MyBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 150,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromARGB(255, 1, 32, 99).withOpacity(0.9),
                Color.fromARGB(255, 60, 150, 172).withOpacity(0.7),
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
          left: 30,
          top: 30,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Bienvenue ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Energy Monitoring ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 10),
              Text(
                "${DateTime.now().year}/${DateTime.now().month}/${DateTime.now().day}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
