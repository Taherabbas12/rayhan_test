import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageSnak {
  static message(String message, {Color color = Colors.red}) {
    try {
      final context = Get.context;
      if (context == null) return;

      OverlayState? overlay = Overlay.of(context);

      OverlayEntry entry = OverlayEntry(
        builder:
            (_) => Positioned(
              bottom: 50,
              left: 20,
              right: 20,
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      height: 1.3,
                    ),
                  ),
                ),
              ),
            ),
      );

      overlay.insert(entry);

      Future.delayed(const Duration(seconds: 3)).then((_) {
        entry.remove();
      });
    } catch (e) {
      // Ignore errors
    }
  }
}
