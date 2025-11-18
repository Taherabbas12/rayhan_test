import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:rayhan_test/utils/constants/images_url.dart';

import '../data/models/cart_item.dart';
import '../data/models/product_model.dart';
import '../data/models/category.dart';
import '../routes/app_routes.dart';
import '../services/api_service.dart';
import '../services/error_message.dart';
import '../utils/constants/api_constants.dart';
import '../utils/constants/values_constant.dart';
import '../views/screens/services/service/service_view_screen.dart';
import 'cart_item_controller.dart';

class ServicesController extends GetxController {
  //
  RxBool isLoading = false.obs;
  RxBool isLoadingStart = true.obs;
  ScrollController scrollController = ScrollController();
  TextEditingController note = TextEditingController(text: '');

  //
  CartItemController cartItemController = Get.find<CartItemController>();

  RxInt countView() =>
      (Values.width ~/ 200 == 0 ? 2 : (Values.width / 200).round()).obs;
  void addToCart(
    Product product,
    String note,
    int quantity, {
    bool isBack = true,
  }) {
    cartItemController.addToCart(
      CartItem(
        vendorName: '',
        productId: product.id.toString(),
        name: product.name,
        image: product.image,
        note: note,
        price2: product.price2,
        price1: product.price1,
        quantity: quantity,
        vendorId: '',
        cartType: CartType.service,
      ),

      isBack: isBack,
    );
  }

  //
  void selectProduct(Product product) {
    // Handle product selection
    if (product.name == 'التكسي') {
      Get.toNamed(AppRoutes.taxiScreen);
    } else {
      selectProductService(product);
      // Get.find<ServiceOrderController>()initFromProduct(
      //   product,
      //   servicesCategorie.value!.id,
      // );
      // fetchProductsOfSubCategores(product.id);
      Get.to(() => ServiceViewScreen(product: product));
    }
    logger.e(product.toJson());
  }

  RxList<Category> servicesCategories = RxList([]);
  RxList<Product> products = RxList([]);
  Rx<Category?> servicesCategorie = Rx(null);
  Rx<Product?> selectProductService = Rx(null);
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
    if (category.type == 'taxi' || servicesCategorie.value!.type == 'all') {
      //
      products.clear();
      products.add(Product(name: 'التكسي', image: ImagesUrl.imageTaxi));
      // logger.e(servicesCategorie.value!.toJson());
    } else {
      products.clear();
      fetchProductsOfSubCategores(category.id);
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

  Future<void> fetchProductsOfSubCategores(int id) async {
    isLoading.value = true;

    try {
      // 🔹 الخطوة 1: جلب الفئات الفرعية (Subcategories)
      final StateReturnData response = await ApiService.getData(
        ApiConstants.serviceSubCategory(id),
      );

      logger.i('استجابة الفئات الفرعية: ${response.data}');

      if (response.isStateSucess < 3) {
        List<dynamic> serviceSubCategoryList = response.data ?? [];

        logger.i('عدد الفئات الفرعية: ${serviceSubCategoryList.length}');

        if (serviceSubCategoryList.isNotEmpty) {
          // 🔹 الخطوة 2: تنفيذ جميع الطلبات الفرعية بالتوازي
          final results = await Future.wait(
            serviceSubCategoryList.map((e) async {
              try {
                logger.i('Subcategory item: $e');
                logger.e(
                  'Subcategory URL: ${ApiConstants.serviceProductsOfSubCategores(e['id'])}',
                );
                final StateReturnData responseSub = await ApiService.postData(
                  ApiConstants.serviceProductsOfSubCategores(e['id']),
                  {},
                );

                if (responseSub.isStateSucess < 3) {
                  logger.i('✅ فئة فرعية ${e['id']} -> ${responseSub.data}');
                  return responseSub.data;
                } else {
                  logger.w('⚠️ فشل في جلب منتجات الفئة الفرعية ${e['id']}');
                  return null;
                }
              } catch (error) {
                logger.e('❌ خطأ أثناء جلب منتجات الفئة ${e['id']}: $error');
                return null;
              }
            }),
          );

          // تصفية النتائج غير الفارغة أولاً
          final validResults = results.where((item) => item != null).toList();

          // دمج جميع القوائم في قائمة واحدة
          final List<dynamic> allProducts =
              validResults.expand((item) => item!).toList();

          logger.i('📦 إجمالي عدد المنتجات بعد الدمج: ${allProducts.length}');
          logger.f('0000000000');
          logger.f(validResults);
          logger.f('0000000000');
          products.addAll(Product.fromJsonList(allProducts));

          logger.i('📦 إجمالي المنتجات المحمّلة: ${products.length}');

          // يمكنك هنا حفظها داخل observable مثلاً:
          // productsList.assignAll(allProducts);
        } else {
          logger.w('⚠️ لا توجد فئات فرعية');
        }
      } else {
        logger.w('⚠️ فشل في جلب الفئات الفرعية من السيرفر');
      }
    } catch (e) {
      logger.e("❌ خطأ عام أثناء تحميل البيانات: $e");
    } finally {
      isLoading.value = false;
    }
  }
}
