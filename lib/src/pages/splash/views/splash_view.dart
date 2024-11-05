import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.wait();
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/loading.png',
                package: 'event_managment',
                width: pageWidth(context),
              ),
              const CircularProgressIndicator(
                color: Color(0xFF2B4D3E),
              ),
            ],
          ),
        ),
      ),
    );
  }

  double pageWidth(BuildContext context) => MediaQuery.sizeOf(context).width;
}
