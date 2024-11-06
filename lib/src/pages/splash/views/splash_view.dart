import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Obx(
            () => Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/loading.png',
                  package: 'event_managment',
                  // width: pageWidth(context),
                  height: pageHeight(context) / 2,
                ),
                (controller.isFailed.value)
                    ? IconButton(
                        onPressed: controller.checkServer,
                        icon: const Icon(Icons.replay_circle_filled_outlined),
                      )
                    : const CircularProgressIndicator(
                        color: Color(0xFF2B4D3E),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  double pageWidth(BuildContext context) => MediaQuery.sizeOf(context).width;
  double pageHeight(BuildContext context) => MediaQuery.sizeOf(context).height;
}
