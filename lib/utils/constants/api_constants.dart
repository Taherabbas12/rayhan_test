class ApiConstants {
  static String baseUrl = 'https://rayhan.shop/api/';
  static String baseUrlImage = 'https://rayhan.shop/api/storage/';
  // Auth User
  static const String login = 'login';
  static const String register = 'register';
  static const String updateProfile = 'customer/update';
  static const String customer = 'customer';
  // Mart
  static const String tbCatagorys = 'TbCatagorys';
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

  static const String serviceMainCategory = 'ServiceMainCategory';
}
