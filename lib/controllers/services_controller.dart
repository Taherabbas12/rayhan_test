import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/utils/constants/images_url.dart';

import '../data/models/product_model.dart';
import '../data/models/category.dart';
import '../routes/app_routes.dart';
import '../services/api_service.dart';
import '../services/error_message.dart';
import '../utils/constants/api_constants.dart';
import '../utils/constants/values_constant.dart';

class ServicesController extends GetxController {
  //
  RxBool isLoading = false.obs;
  RxBool isLoadingStart = true.obs;
  ScrollController scrollController = ScrollController();

  //

  RxInt countView() =>
      (Values.width ~/ 200 == 0 ? 2 : (Values.width / 200).round()).obs;

  //
  void selectProduct(Product product) {
    // Handle product selection
    if (product.name == 'التكسي') {
      Get.toNamed(AppRoutes.taxiScreen);
    } else {
      Get.toNamed('/product', arguments: product);
    }
    logger.e(product.toJson());
  }

  RxList<Category> servicesCategories = RxList([]);
  RxList<Product> products = RxList([]);
  Rx<Category?> servicesCategorie = Rx(null);
  var isAppBarVisible = true.obs;
  double previousOffset = 0.0;
  DateTime? lastTime;

  @override
  void onInit() {
    super.onInit();
    fetchCategores();
  }

  void selectSection(Category category) {
    servicesCategorie.value = category;
    logger.e(servicesCategorie.value!.toJson());
    if (category.type == 'taxi' ||
        servicesCategorie.value!.type == 'all' ||
        servicesCategorie.value!.type == 'iron') {
      //
      products.clear();
      products.add(Product(name: 'التكسي', image: ImagesUrl.imageTaxi));
      logger.e(servicesCategorie.value!.toJson());
    } else {
      products.clear();
    }
  }

  Future<void> fetchCategores() async {
    isLoading.value = true;

    try {
      final StateReturnData response = await ApiService.getData(
        ApiConstants.serviceMainCategory,
      );
      logger.e(response.data);
      if (response.isStateSucess < 3) {
        List<dynamic> newVideosJson = response.data;

        List<Category> newRestaurantCategory = Category.fromJsonList(
          newVideosJson,
        );
        servicesCategories.clear();
        servicesCategories.add(
          Category(id: 0, name: 'الكل', image: '', type: 'all'),
        );
        servicesCategories.addAll(newRestaurantCategory);
        if (servicesCategories.isNotEmpty) {
          selectSection(servicesCategories[0]);
        }
      }
    } catch (e) {
      logger.i("خطأ في تحميل البيانات: $e");
    }
    isLoadingStart(false);
    isLoading.value = false;
  }

  Future<void> fetchSubCategores() async {
    isLoading.value = true;

    try {
      final StateReturnData response = await ApiService.getData(
        ApiConstants.serviceMainCategory,
      );
      logger.e(response.data);
      if (response.isStateSucess < 3) {
        List<dynamic> newVideosJson = response.data;

        List<Category> newRestaurantCategory = Category.fromJsonList(
          newVideosJson,
        );
        servicesCategories.clear();
        servicesCategories.add(
          Category(id: 0, name: 'الكل', image: '', type: 'all'),
        );
        servicesCategories.addAll(newRestaurantCategory);
        if (servicesCategories.isNotEmpty) {
          selectSection(servicesCategories[0]);
        }
      }
    } catch (e) {
      logger.i("خطأ في تحميل البيانات: $e");
    }
    isLoadingStart(false);
    isLoading.value = false;
  }
}
