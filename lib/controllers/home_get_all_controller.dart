import 'package:get/get.dart';
import '../data/models/home_response.dart';
import '../data/models/restaurant.dart';
import '../data/models/slider_image_model.dart';
import '../services/api_service.dart';
import '../utils/constants/api_constants.dart';
import '../services/error_message.dart';

class HomeGetAllController extends GetxController {
  RxBool isLoading = false.obs;

  // الأقسام
  RxList<Restaurant> forNowShop = RxList([]);
  RxList<ShowsItemModel> shows = RxList([]);
  RxList<SliderImageModel> sliderImageModel = RxList([]);
  RxInt freeDeliveryCount = 0.obs;

  @override
  void onInit() {
    super.onInit();
    fetchHomeData();
  }

  Future<void> fetchHomeData() async {
    isLoading.value = true;

    try {
      final response = await ApiService.postData(
        ApiConstants.getAllDataHome,
        {},
      );
      logger.w(response.data);
      if (response.isStateSucess < 3) {
        // تحويل الـ JSON إلى موديل كامل
        final data = HomeResponseModel.fromJson(response.data);

        // تحديث الـ RxList
        forNowShop.assignAll(data.forNow);
        shows.assignAll(data.shows);
        logger.e(forNowShop.first.toJson());
        sliderImageModel.assignAll(data.sliderImageModel);
        freeDeliveryCount.value = data.freeDeliveryCount;
      } else {
        logger.i("❌ فشل في جلب بيانات الهوم");
      }
    } catch (e) {
      logger.i("❌ خطأ في تحميل البيانات: $e");
    }

    isLoading.value = false;
  }
}
