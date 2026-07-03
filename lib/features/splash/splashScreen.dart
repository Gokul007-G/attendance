import 'package:attendance/componentes/custom_text/custom_text.dart';
import 'package:attendance/features/login/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:svg_flutter/svg.dart';
import 'package:attendance/core/constant/appColors.dart';
import 'package:attendance/core/constant/string.dart';

class Splashscreen extends StatelessWidget {
  const Splashscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [primaryBlue, secondaryBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          children: [
            Positioned.fill(child: SvgPicture.asset(splashAppIcon)),

            Positioned(
              left: 50,
              right: 50,
              bottom: MediaQuery.of(context).size.height * 0.25,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CustomText.headingFive(splashTitle, Colors.white),
                  CustomText.caption(splashSubtitle, Colors.white),
                ],
              ),
            ),
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.1,
              left: 60,
              right: 60,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                    (route) => false,
                  );
                },
                child: Text(splashButton),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
