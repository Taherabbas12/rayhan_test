import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/utils/constants/images_url.dart';

import '../data/models/product_model.dart';
import '../data/models/category.dart';
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
    if (category.type == 'taxi') {
      //
      products.clear();
      products.add(Product(name: 'التكسي', image: ImagesUrl.imageTaxi));
      logger.e(category.toJson());
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

        servicesCategories.addAll(newRestaurantCategory);
        if (servicesCategories.isNotEmpty) {
          servicesCategorie.value = servicesCategories[0];
        }
      }
    } catch (e) {
      logger.i("خطأ في تحميل البيانات: $e");
    }
    isLoadingStart(false);
    isLoading.value = false;
  }
}
