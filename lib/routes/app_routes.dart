import 'package:get/get.dart';

import '../bindings/auth_binding.dart';

import '../bindings/home_binding.dart';
import '../bindings/market_binding.dart';
import '../bindings/market_product_binding.dart';
import '../bindings/restaurant_binding.dart';
import '../bindings/services_binding.dart';
import '../bindings/shop_binding.dart';
import '../views/screens/auth/otp.dart';
import '../views/screens/home/home_screen.dart';
import '../views/screens/market/market_screen.dart';
import '../views/screens/market/view_category_details/category_details_screen.dart';
import '../views/screens/notification/notification_screen.dart';
import '../views/screens/restaurants/resturants_screen.dart';
import '../views/screens/restaurants/shop/shop_screen.dart';
import '../views/screens/services/services_screen.dart';
import '../views/screens/services/taxi/taxi_screen.dart';

class AppRoutes {
  static const login = '/login';
  static const register = '/Register';
  static const otp = '/otp';
  static const resturantsScreen = '/Resturants-Screen';
  static const servicesScreen = '/Services-Screen';
  static const home = '/Home-Screen';
  static const shopScreen = '/Shop-Screen';
  static const marketScreen = '/Market-Screen';
  static const categoryDetailsScreen = '/Category-Details-Screen';
  static const notificationScreen = '/Notification-Screen';
  static const taxiScreen = '/Taxi-Screen';

  static final routes = [
    // GetPage(name: login, page: () => Login(), binding: LoginBinding()),
    // GetPage(name: register, page: () => Register(), binding: LoginBinding()),
    GetPage(name: otp, page: () => OTPScreen(), binding: LoginBinding()),
    GetPage(name: home, page: () => HomeScreen(), binding: HomeBinding()),
    GetPage(name: shopScreen, page: () => ShopScreen(), binding: ShopBinding()),
    GetPage(name: notificationScreen, page: () => NotificationScreen()),
    GetPage(name: taxiScreen, page: () => TaxiScreen()),
    GetPage(
      name: categoryDetailsScreen,
      page: () => CategoryDetailsScreen(),
      binding: MarketProductBinding(),
    ),
    GetPage(
      name: marketScreen,
      page: () => MarketScreen(),
      binding: MarketBinding(),
    ),
    // GetPage(
    //   name: rePassword,
    //   page: () => RePassword(),
    //   binding: LoginBinding(),
    // ),
    GetPage(
      name: resturantsScreen,
      page: () => ResturantsScreen(),
      binding: RestaurantBinding(),
    ),
    GetPage(
      name: servicesScreen,
      page: () => ServicesScreen(),
      binding: ServicesBinding(),
    ),
  ];
}

// Get banners 
// https://rayhan.shop/api/TbShows

// Get categories
// https://rayhan.shop/api/TbCatagorys

// Product search 
// Post https://rayhan.shop/api/Search
// Body : {“name”: value}

// Get subCategories 
// Post https://rayhan.shop/api/Subcategories/category
// query: {"id": catehoryId}


// Get products has discount as category and subcategory 
// https://rayhan.shop/api/TbProducts/FilterByCategoryAndSubHaveDiscount?page=$page&pageSize=$pageSize&category=$category&subCategory=$sub


// Get all products as category and subcategory
// https://rayhan.shop/api/TbProducts/FilterByCategoryAndSub?page=$page&pageSize=$pageSize&category=$category&subCategory=$sub