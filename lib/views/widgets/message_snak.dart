import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageSnak {
  static message(String message, {Color color = Colors.red}) {
    try {
      Get.showSnackbar(
        GetSnackBar(
          duration: const Duration(seconds: 4),
          backgroundColor: color,
          message: message,
        ),
      );
    } catch (e) {
      //
    }
  }
}
