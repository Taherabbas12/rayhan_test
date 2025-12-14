import 'package:get/get.dart';

import '../data/database/favorites_db.dart';
import '../data/models/favorite_product_model.dart';
import '../data/models/product_model.dart';

import '../views/screens/market/view_category_details/view_product_screen.dart'
    as market;
import '../views/screens/restaurants/restaurant/view_product_screen.dart'
    as resturant;
import '../views/screens/shop/shop_select/view_shop_product_screen.dart';

import 'market_product_controller.dart';
import 'restaurant_controller.dart';
import 'shops_controller.dart';

class VendorInfo {
  final int id;
  final String name;

  const VendorInfo({required this.id, required this.name});
}

class FavoritesController extends GetxController {
  final FavoritesDb db = FavoritesDb.instance;

  final RestaurantController restaurantController =
      Get.find<RestaurantController>();
  final ShopsController shopsController = Get.find<ShopsController>();
  final MarketProductController marketController =
      Get.find<MarketProductController>();

  /// جميع المنتجات المفضلة
  RxList<FavoriteProduct> allFavorites = <FavoriteProduct>[].obs;

  /// 0 = الطعام | 1 = المتاجر | 2 = الماركت
  RxInt tabIndex = 0.obs;
  RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadFavorites();
  }

  /* ================= LOAD ================= */

  Future<void> loadFavorites() async {
    isLoading.value = true;
    allFavorites.value = await db.getAll(); // ✅ الصحيح
    isLoading.value = false;
  }

  /* ================= FILTER ================= */

  List<FavoriteProduct> get filteredFavorites {
    if (tabIndex.value == 0) {
      return allFavorites.where((e) => e.shopType == 'restaurant').toList();
    }
    if (tabIndex.value == 1) {
      return allFavorites.where((e) => e.shopType == 'shop').toList();
    }
    return allFavorites.where((e) => e.shopType.isEmpty).toList();
  }

  bool isEmptyForCurrentTab() => filteredFavorites.isEmpty;

  void setTab(int index) => tabIndex.value = index;

  /* ================= FAVORITE ================= */

  Future<void> removeFavorite(FavoriteProduct p) async {
    await db.removeFavorite(p.id);
    allFavorites.removeWhere((e) => e.id == p.id);
  }

  /// ⭐ API نظيف: Product + VendorInfo فقط
  Future<void> toggleFavorite({
    required Product product,
    required VendorInfo vendor,
  }) async {
    final exists = await db.exists(product.id);

    if (exists) {
      await db.removeFavorite(product.id);
      allFavorites.removeWhere((e) => e.id == product.id);
    } else {
      final fav = FavoriteProduct(
        id: product.id,
        name: product.name,
        descc: product.descc,
        curncy: product.curncy,
        active: product.active,
        count: product.count,
        image: product.image,
        price1: product.price1,
        price2: product.price2,
        shopType: product.shopType,
        vendorId: vendor.id,
        vendorName: vendor.name,
      );
      await db.addFavorite(fav);
      allFavorites.add(fav);
    }
  }

  /* ================= NAVIGATION ================= */

  void openProduct(Product product) {
    final type = product.shopType;

    if (type == 'restaurant') {
      Get.to(() => resturant.ViewProductScreen(product: product));
      return;
    }

    if (type == 'shop') {
      Get.to(() => ViewShopProductScreen(product: product));
      return;
    }

    Get.to(() => market.ViewProductScreen(product: product));
  }

  /* ================= ADD TO CART ================= */

  void addCartProduct(FavoriteProduct product) {
    final p = Product.fromFavorite(product);

    if (product.shopType == 'restaurant') {
      restaurantController.addToCart(p, '', 1, isBack: false);
      return;
    }

    if (product.shopType == 'shop') {
      shopsController.addToCart(p, '', 1, isBack: false);
      return;
    }

    marketController.addToCart(p, '', 1, isBack: false);
  }
}
