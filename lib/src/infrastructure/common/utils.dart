import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Utils {
  Utils._();

  static void showFailSnackBar({required String message}) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: Colors.red.shade200,
        duration: const Duration(seconds: 3),
        messageText: Text(
          message,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  static void showSuccessSnackBar({required String message}) {
    Get.showSnackbar(
      GetSnackBar(
        backgroundColor: Colors.green.shade200,
        duration: const Duration(seconds: 3),
        messageText: Text(
          message,
          style: const TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}
