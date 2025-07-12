import 'package:get/get.dart';

class TaxiController extends GetxController {
  RxBool isLoading = false.obs;

  // يتحكم في عرض واجهة الانطلاق أو الوصول
  RxBool isCompleteStartingPoint = false.obs;

  List<TaxiViewName> textTitles = [
    TaxiViewName(
      title: 'حدد نقطة الانطلاق',
      subtitle: 'يرجى تحديد نقطة الانطلاق التي سيتوجه السائق إليها ليقلك منها.',
    ),
    TaxiViewName(
      title: 'حدد نقطة الوصول',
      subtitle: 'يرجى تحديد نقطة الوصول التي ترغب ان يقلك السائق إليها.',
    ),
  ];

  Rx<TaxiViewName> textTitle =
      TaxiViewName(
        title: 'حدد نقطة الانطلاق',
        subtitle:
            'يرجى تحديد نقطة الانطلاق التي سيتوجه السائق إليها ليقلك منها.',
      ).obs;
  void selectLocation(Taxi location, String address) {
    selectTaxi(location);
    selectTaxiAddress(address);
    setCompleteStartingPoint(true);
  }

  void setCompleteStartingPoint(bool value) {
    isCompleteStartingPoint.value = value;
    textTitle.value = value ? textTitles[1] : textTitles[0];
  }

  // بيانات العنوان الأول (الانطلاق)
  Rx<Taxi?> selectedTaxi = Rx<Taxi?>(null);
  Rx<String?> selectedTaxiAddress = Rx<String?>(null);

  void selectTaxi(Taxi taxi) {
    selectedTaxiAddress.value = null;
    selectedTaxi.value = taxi;
  }

  void selectTaxiAddress(String address) {
    selectedTaxiAddress.value = address;
  }

  // بيانات العنوان الثاني (الوصول)
  Rx<Taxi?> selectedTaxi2 = Rx<Taxi?>(null);
  Rx<String?> selectedTaxiAddress2 = Rx<String?>(null);

  void selectTaxi2(Taxi taxi) {
    selectedTaxiAddress2.value = null;
    selectedTaxi2.value = taxi;
  }

  void selectTaxiAddress2(String address) {
    selectedTaxiAddress2.value = address;
  }

  // أنواع العناوين (للتبديل بين قائمة العناوين والاخيرة)
  List<String> addressType = ['عناويني', 'المدخلات الأخيرة'];
  RxString selectedAddressType = 'عناويني'.obs;

  void onAddressTypeChanged(String value) {
    selectedAddressType.value = value;
  }

  // عناوين افتراضية
}

List<Taxi> taxiAddresses = [
  Taxi(name: 'A1', addresses: List.generate(12, (index) => '${index + 1}')),
  Taxi(name: 'A2', addresses: List.generate(14, (index) => '${index + 1}')),
  Taxi(name: 'A3', addresses: List.generate(14, (index) => '${index + 1}')),
  Taxi(name: 'A4', addresses: List.generate(12, (index) => '${index + 1}')),
  Taxi(name: 'A5', addresses: List.generate(12, (index) => '${index + 1}')),
  Taxi(name: 'A6', addresses: List.generate(12, (index) => '${index + 1}')),
  Taxi(name: 'A7', addresses: List.generate(13, (index) => '${index + 1}')),
  Taxi(name: 'A8', addresses: List.generate(15, (index) => '${index + 1}')),
  Taxi(name: 'A9', addresses: List.generate(15, (index) => '${index + 1}')),
  Taxi(name: 'B1', addresses: List.generate(12, (index) => '${index + 1}')),
  Taxi(name: 'B2', addresses: List.generate(18, (index) => '${index + 1}')),
  Taxi(name: 'B3', addresses: List.generate(18, (index) => '${index + 1}')),
  Taxi(name: 'B8', addresses: List.generate(12, (index) => '${index + 1}')),
];

// الموديل المستخدم للعناوين
class Taxi {
  String name;
  List<String> addresses;

  Taxi({required this.name, required this.addresses});

  factory Taxi.fromJson(Map<String, dynamic> json) {
    return Taxi(
      name: json['name'] as String,
      addresses: List<String>.from(json['addresses'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'addresses': addresses};
  }

  @override
  String toString() => name;
}

// بيانات العنوان (العنوان + وصف)
class TaxiViewName {
  String title;
  String subtitle;

  TaxiViewName({required this.title, required this.subtitle});
}




// Restaurant and shops

// get Categories
// https://rayhan.shop/api/ShopMainCategories - this use only on restaurant page to get main categories

// Search about product
// If u want restaurant product send restaurant else send shop
// https://rayhan.shop/api/Shop/Filter?type=name&value=${searchTextEditController.text}&hisType=restaurant


// Restaurant banners
// https://rayhan.shop/api/ShopShow


// Get restaurant as filter
// 'https://rayhan.shop/api/Shop/ForUser?pageSize=$pageSize&page=$page&categoryId=$category&sort=${restController.sort.value}&grantThan4Star=${restController.grantThe4Star.value}&freeDelivery=${restController.freeDelivery.value}&type=$type'

// Page and pageSize for pagination
// Category is category id if not found send 0 
// Sort send “Ascending” or “Descending” 
// grantThan4Star send true or false 
// freeDelivery send true or false
// Type send restaurant or shop 

// Get products as category id
// https://rayhan.shop/api/ShopProduct/ForUser?page=$page&pageSize=$pageSize&categoryId=$category
 

// Get category for restaurant or shop 
// https://rayhan.shop/api/ShopCategory/ShopCategoriesFilter?shopId=$id