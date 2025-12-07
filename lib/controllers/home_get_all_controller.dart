import 'package:get/get.dart';
import 'package:rayhan_test/data/models/address_model.dart';
import '../data/models/home_response.dart';
import '../data/models/restaurant.dart';
import '../data/models/slider_image_model.dart';
import '../data/models/user_model.dart';
import '../services/api_service.dart';
import '../utils/constants/api_constants.dart';
import '../services/error_message.dart';
import 'storage_controller.dart';

class HomeGetAllController extends GetxController {
  RxBool isLoading = false.obs;

  // الأقسام
  RxList<Restaurant> forNowShop = RxList([]);
  RxList<ShowsItemModel> shows = RxList([]);
  RxList<SliderImageModel> sliderImageModel = RxList([]);
  RxInt freeDeliveryCount = 0.obs;
  Rx<AddressModel?> adddress = Rx(null);

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
      // logger.w(response.data);
      if (response.isStateSucess < 3) {
        final data = HomeResponseModel.fromJson(response.data);

        // تحديث الـ RxList
        forNowShop.assignAll(data.forNow);
        shows.assignAll(data.shows);
        // logger.e(forNowShop.first.toJson());
        sliderImageModel.assignAll(data.sliderImageModel);
        freeDeliveryCount.value = data.freeDeliveryCount;
        // ___________________
        getAddress();
        // ___________________
      } else {
        logger.i("❌ فشل في جلب بيانات الهوم");
      }
    } catch (e) {
      logger.i("❌ خطأ في تحميل البيانات: $e");
    }

    isLoading.value = false;
  }

  Future<void> getAddress() async {
    UserModel userModel = UserModel.fromJson(StorageController.getAllData());

    final response2 = await ApiService.getData(
      ApiConstants.tbAddressesById(userModel.addressid),
    );

    // logger.w('_______ Address ${userModel.addressid} ________');
    // logger.w(response2.data);
    if (response2.isStateSucess < 3) {
      adddress.value = null;
      adddress.value = AddressModel.fromJson(response2.data);
      logger.w('_______ Address ${userModel.addressid} ________');
      logger.w(adddress.value!.toJson());
      //
    }
  }
}
