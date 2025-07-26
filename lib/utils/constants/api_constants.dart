class ApiConstants {
  static String baseUrl = 'https://rayhan.shop/api/';
  static String baseUrlImage = 'https://rayhan.shop/api/storage/';
  // Auth User
  static String login(String phone) => 'Login/loginWithOtp?phone=$phone';

  static String smsSendWhats =
      'https://gateway.standingtech.com/api/v4/sms/send';

  // Market
  static const String marketCatagorys = 'TbCatagorys';
  static String marketSubCatagorys(int id) => 'Subcategories/category?id=$id';
  static String marketProduct(int category, {int subCategory = 0}) =>
      'TbProducts/FilterByCategoryAndSub?page=1&pageSize=100&category=$category&subCategory=$subCategory';
  static String marketDiscountProduct(int category, {int subCategory = 0}) =>
      'TbProducts/FilterByCategoryAndSubHaveDiscount?page=1&pageSize=1000&category=$category&subCategory=$subCategory';
  static const String marketShowBanners = 'TbShows';

  // Resturents (Shop)
  static const String shopMainCategories = 'ShopMainCategories';
  static String shopCategories(int id) =>
      'ShopCategory/ShopCategoriesFilter?shopId=$id';
  static String shopProducts(int id) =>
      'ShopProduct/ForUser?page=1&pageSize=150&categoryId=$id';

  static const String shopShowBanners = 'ShopShow';
  static String resturens(
    int page, {
    bool sort = true,
    bool star4 = false,
    bool freeDelevry = false,
    int categoryId = 0,
  }) =>
      'Shop/ForUser?pageSize=10&page=$page&sort=${sort ? 'Ascending' : 'Descending'}&grantThan4Star=$star4&freeDelivery=$freeDelevry&type=restaurant&categoryId=$categoryId';
  static String resturensOrShop(
    int page, {
    bool sort = true,
    bool star4 = false,
    bool freeDelevry = false,
    int categoryId = 0,
    String type = 'restaurant',
  }) => 'Shop/ForUser?pageSize=50&page=1&categoryId=0&sort=true&type=Shop';
  // Services
  static const String serviceMainCategory = 'ServiceMainCategory';
  // Order
  static const String creatOrder = 'PlaysorderController1';
  static String getOrders(int id) => 'TbOrders/OrdersForUser?id=$id';
}
