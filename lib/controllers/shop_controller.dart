import 'package:get/get.dart';

import '../data/models/product_model.dart';
import '../data/models/shop_category.dart';
import '../services/api_service.dart';
import '../services/error_message.dart';
import '../utils/constants/api_constants.dart';
import '../utils/constants/values_constant.dart';

class ShopController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isLoadingProduct = false.obs;
  RxBool isLoadingStart = true.obs;
  RxList<Product> productsShop = RxList([]);
  RxList<ShopCategory> shopCategores = RxList([]);
  Rx<ShopCategory?> shopCategorySelect = Rx(null);

  // @override
  // void onInit() {
  //   super.onInit();
  // }
  RxInt countView() =>
      (Values.width ~/ 250 == 0 ? 1 : (Values.width / 250).round()).obs;

  void selectCategory(ShopCategory category) {
    shopCategorySelect.value = category;
    fetchShopProducts(idCategores: category.id);
  }

  Future<void> fetchShopCategores({required int id}) async {
    isLoading.value = true;

    try {
      final StateReturnData response = await ApiService.postData(
        ApiConstants.shopCategories(id),
        {},
      );
      // logger.e("response $id : ${response.data}");
      if (response.isStateSucess < 3) {
        List<dynamic> newJson = response.data;

        List<ShopCategory> newShopCategores = ShopCategory.fromJsonList(
          newJson,
        );
        shopCategores.clear();
        // shopCategores.add(ShopCategory(id: 0, name: "الكل"));
        shopCategores.addAll(newShopCategores);
        if (shopCategores.isNotEmpty) {
          // Select the first category by default
          selectCategory(shopCategores[0]);
        }
      }
    } catch (e) {
      logger.i("خطأ في تحميل البيانات: $e");
    }
    isLoadingStart(false);
    isLoading.value = false;
  }

  Future<void> fetchShopProducts({required int idCategores}) async {
    isLoadingProduct.value = true;

    try {
      final StateReturnData response = await ApiService.postData(
        ApiConstants.shopProducts(idCategores),
        {},
      );
      // logger.e("response $idCategores : ${response.data}");
      if (response.isStateSucess < 3) {
        List<dynamic> newJson = response.data['data'];

        List<Product> newShopCategores = Product.fromJsonList(newJson);
        productsShop.clear();

        productsShop.addAll(newShopCategores);
      }
    } catch (e) {
      logger.i("خطأ في تحميل البيانات: $e");
    }

    isLoadingProduct.value = false;
  }
}
