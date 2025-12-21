import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/constants/color_app.dart';
import '../../utils/constants/style_app.dart';

class MessageSnak {
  static message(String message, {Color color = Colors.red}) {
    final context = Get.context;
    if (context == null) return;

    // Colors based on type
    Color bgColor = Colors.green;
    IconData icon = Icons.check_circle_rounded;

    switch (color) {
      case Colors.green:
        bgColor = ColorApp.primaryColor;
        icon = Icons.check_circle_rounded;
        break;
      case Colors.red:
        bgColor = ColorApp.redColor;
        icon = Icons.error_outline_rounded;
        break;
      case Colors.amber:
        bgColor = ColorApp.textFourColor;
        icon = Icons.info_outline_rounded;
        break;
    }

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.transparent,
        duration: const Duration(seconds: 3),
        content: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: bgColor,
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: bgColor.withOpacity(0.35),
                  spreadRadius: 1,
                  blurRadius: 14,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Icon(icon, color: Colors.white, size: 26),
                const SizedBox(width: 12),

                // Texts
                Expanded(
                  child: Text(
                    message,
                    style: StringStyle.textTable.copyWith(
                      color: Colors.white,
                      height: 1.3,
                      fontSize: 13.8,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
