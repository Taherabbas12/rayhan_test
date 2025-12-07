// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_secure_storage/get_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'controllers/storage_controller.dart';
import 'routes/app_routes.dart';
import 'splash_screen.dart'; // ← أضفنا شاشة السبلاتش
import 'utils/constants/color_app.dart';
import 'utils/constants/style_app.dart';
import 'utils/constants/values_constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting('ar', null); // 🔥 مهم جداً

  await GetSecureStorage.init(
    password: Values.passwordStorage,
    container: Values.pathContiner,
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Values.width = MediaQuery.sizeOf(context).width;
    Values.height = MediaQuery.sizeOf(context).height;

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.cupertino,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: GoogleFonts.notoKufiArabicTextTheme(),
        fontFamily: 'Noto Kufi Arabic',
        scaffoldBackgroundColor: ColorApp.backgroundColor,
        appBarTheme: AppBarTheme(
          surfaceTintColor: ColorApp.backgroundColor,
          backgroundColor: ColorApp.backgroundColor,
          titleTextStyle: StringStyle.titleApp,
          centerTitle: true,
        ),
        colorScheme: ColorScheme.fromSwatch(
          backgroundColor: ColorApp.primaryColor,
        ),
      ),

      // ⭐⭐ شاشة البداية هي السبلاتش ⭐⭐
      initialRoute: '/splash',

      getPages:
          [
            GetPage(name: '/splash', page: () => const SplashScreen()),

            GetPage(name: '/decider', page: () => const DeciderPage()),
          ] +
          AppRoutes.routes,
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        double textScaleFactor = mediaQuery.size.width / 400;

        return MediaQuery(
          data: mediaQuery.copyWith(
            textScaler: TextScaler.linear(textScaleFactor.clamp(0.8, 0.9)),
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: child!,
          ),
        );
      },
      title: 'ريحان',
    );
  }
}

class DeciderPage extends StatelessWidget {
  const DeciderPage({super.key});

  @override
  Widget build(BuildContext context) {
    final loggedIn = StorageController.checkLoginStatus();

    Future.microtask(() {
      Get.offAllNamed(
        loggedIn ? AppRoutes.home : AppRoutes.rayhanWelcomeScreen,
      );
    });

    return const Scaffold(body: SizedBox());
  }
}
