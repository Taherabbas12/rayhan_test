import 'package:get/get.dart';

import '../bindings/auth_binding.dart';

import '../bindings/restaurant_category_binding.dart';
import '../views/screens/auth/login.dart';
import '../views/screens/auth/otp.dart';
import '../views/screens/restaurants/resturants_screen.dart';

class AppRoutes {
  static const login = '/login';
  static const register = '/Register';
  static const otp = '/otp';
  static const resturantsScreen = '/Resturants-Screen';
  static const home = '/Home-Screen';

  static final routes = [
    GetPage(name: login, page: () => Login(), binding: LoginBinding()),
    // GetPage(name: register, page: () => Register(), binding: LoginBinding()),
    GetPage(name: otp, page: () => OTPScreen(), binding: LoginBinding()),
    // GetPage(
    //   name: rePassword,
    //   page: () => RePassword(),
    //   binding: LoginBinding(),
    // ),
    GetPage(
      name: resturantsScreen,
      page: () => ResturantsScreen(),
      binding: RestaurantCategoryBinding(),
    ),
  ];
}
