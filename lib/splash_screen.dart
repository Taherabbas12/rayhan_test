import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  // للتحكم في الشفافية
  double _opacity = 1.0;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: -20,
      end: 20,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _opacity = 0;
      });

      Future.delayed(const Duration(milliseconds: 385), () {
        Get.toNamed('/decider');
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 400),
          opacity: _opacity,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (_, child) {
              return Transform.translate(
                offset: Offset(0, _animation.value),
                child: child,
              );
            },
            child: Image.asset(
              "assets/images/logo_start.png",
              width: MediaQuery.of(context).size.width * 0.75,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
