import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {
  Utils._();

  static void showFailSnackBar({required String message, int? duration}) {
    Get.showSnackbar(
      GetSnackBar(
        isDismissible: true,
        margin: const EdgeInsets.all(8),
        borderRadius: 12,
        backgroundColor: Colors.red.shade200,
        duration: Duration(seconds: duration ?? 2),
        messageText: Text(
          message,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  static void showSuccessSnackBar({required String message, int? duration}) {
    Get.showSnackbar(
      GetSnackBar(
        isDismissible: true,
        margin: const EdgeInsets.all(8),
        borderRadius: 12,
        backgroundColor: Colors.green.shade200,
        duration: Duration(seconds: duration ?? 2),
        messageText: Text(
          message,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
