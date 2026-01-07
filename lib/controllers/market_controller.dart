import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/controllers/market_product_controller.dart';
import 'package:rayhan_test/routes/app_routes.dart';

import '../data/models/product_model.dart';
import '../data/models/restaurant.dart';
import '../data/models/category.dart';
import '../data/models/slider_image_model.dart';
import '../services/api_service.dart';
import '../services/error_message.dart';
import '../utils/constants/api_constants.dart';
import '../utils/constants/values_constant.dart';

class MarketController extends GetxController {
  // Select Restaurant
  Rx<Restaurant?> restaurantSelect = Rx(null);
  void selectRestorent(Restaurant restaurant) {
    restaurantSelect(restaurant);
    Get.toNamed(AppRoutes.shopScreen);
  }

  RxInt countView() =>
      (Values.width ~/ 150 == 0 ? 1 : (Values.width / 150).round()).obs;

  //Filter

  RxBool isLoading = false.obs;
  RxBool isLoadingStart = true.obs;
  RxBool isLoadingRestaurant = true.obs;
  RxBool isLoadingSliderImageModel = true.obs;
  ScrollController scrollController = ScrollController();

  RxList<Category> marketCategories = RxList([]);

  Rx<Category?> selectCategories = Rx(null);

  void selectCategory(Category category) {
    selectCategories(category);
    Get.find<MarketProductController>().productsMarket.clear();

    Get.toNamed(AppRoutes.categoryDetailsScreen);
  }

  RxList<SliderImageModel> sliderImageModel = RxList([]);

  @override
  void onInit() {
    super.onInit();
    fetchCategores();
    fetchSliderImage();
  }

  Future<void> fetchCategores() async {
    isLoading.value = true;

    try {
      final StateReturnData response = await ApiService.getData(
        ApiConstants.marketCatagorys,
      );
      // logger.e('Market categories response: ${response.data}');
      if (response.isStateSucess < 3) {
        List<dynamic> newCategoresJson = response.data;
        logger.w('----- market ---- ');
        logger.w(newCategoresJson);
        List<Category> newRestaurantCategory = Category.fromJsonList(
          newCategoresJson,
        );
        marketCategories.clear();
        // marketCategories.add(
        //   Category(
        //     image: 'https://iili.io/3gQmEEN.png',
        //     id: 0,
        //     name: "العروض",
        //     type: '',
        //   ),
        // );
        marketCategories.addAll(newRestaurantCategory);
        marketCategories.sort(
          (a, b) => int.parse(a.sort!).compareTo(int.parse(b.sort!)),
        );
        selectCategories(marketCategories[0]);
      }
    } catch (e) {
      // logger.i("خطأ في تحميل البيانات: $e");
    }
    isLoadingStart(false);
    isLoading.value = false;
  }

  Future<void> fetchSliderImage() async {
    isLoadingSliderImageModel.value = true;

    try {
      final StateReturnData response = await ApiService.getData(
        ApiConstants.marketShowBanners,
      );
      if (response.isStateSucess < 3) {
        List<dynamic> newVideosJson = response.data;

        List<SliderImageModel> newRestaurantCategory =
            SliderImageModel.fromJsonList(newVideosJson);
        sliderImageModel([]);
        sliderImageModel.addAll(newRestaurantCategory);
      }
    } catch (e) {
      // logger.i("خطأ في تحميل البيانات: $e");
    } finally {
      isLoadingSliderImageModel(false);
    }
  }
  // Search

  RxList<Product> productsSearch = RxList([]);
  RxBool isLoadingProductSearch = false.obs;
  Future<void> fetchShopProductsSearch(String value) async {
    isLoadingProductSearch.value = true;

    try {
      final StateReturnData response = await ApiService.postData(
        ApiConstants.searchRayhan,
        {"name": value.tr},
      );
      // logger.e("respaaa onse : ${response.data}");
      if (response.isStateSucess < 3) {
        List<dynamic> newJson = response.data;

        List<Product> newShopCategores = Product.fromJsonList(newJson);
        productsSearch.clear();

        productsSearch.addAll(newShopCategores);
      }
    } catch (e) {
      // logger.i("خطأ في تحميل البيانات: $e");
    }

    isLoadingProductSearch.value = false;
  }
}

class FilterOption {
  final String label;
  bool isSelect;
  FilterOption({required this.label, this.isSelect = false});
}
