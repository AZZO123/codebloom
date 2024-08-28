import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:palnt_app/Constant/colors.dart';
import 'package:palnt_app/Services/Responsive.dart';
import 'package:palnt_app/View/Splash/Controller/SplashController.dart';
import 'package:provider/provider.dart';

class Splash extends StatelessWidget {
  const Splash({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SplashController>(
      builder: (context, value, child) => Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/Logo.png",
                fit: BoxFit.fitWidth,
                width: Responsive.getWidth(context) * .5,
              ),
              Gap(20),
              Text(
                "CodeBloom",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: kSecendryColor),
              ),
              LoadingAnimationWidget.flickr(
                  leftDotColor: kBaseSecandryColor,
                  rightDotColor: kSecendryColor,
                  size: 18)
            ],
          ),
        ),
      ),
    );
  }
}
