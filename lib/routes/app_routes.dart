import 'package:get/get.dart';

import '../bindings/auth_binding.dart';

import '../views/screens/auth/login.dart';
import '../views/screens/auth/otp.dart';
import '../views/screens/auth/re_password.dart';

class AppRoutes {
  static const login = '/login';
  static const register = '/Register';
  static const otp = '/otp';
  static const rePassword = '/rePassword';
  static const home = '/home';
  static const badgeScreen = '/badge-screen';
  static const visitProfile = '/Visit-Profile-Screen';
  static const myProfile = '/My-Profile-Screen';
  static const shakwa = '/Shakwa';
  static const contact = '/Contact';
  static const galleryScreen = '/Gallery-screen';
  static const imageScreenSelect = '/Select-Images-screen';
  static const videosScreen = '/Videos-screen';
  static const videoScreenSelect = '/Select-video-screen';
  static const postsScreen = '/Posts-screen';

  static final routes = [
    GetPage(name: login, page: () => Login(), binding: LoginBinding()),
    // GetPage(name: register, page: () => Register(), binding: LoginBinding()),
    GetPage(name: otp, page: () => OTPScreen(), binding: LoginBinding()),
    // GetPage(
    //   name: rePassword,
    //   page: () => RePassword(),
    //   binding: LoginBinding(),
    // ),

    //
  ];
}
