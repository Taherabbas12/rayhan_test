import 'package:get/get.dart';

class TaxiController extends GetxController {
  RxBool isLoading = false.obs;
  bool isCompleteStartingPoint = false;
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
  void setCompleteStartingPoint(bool value) {
    isCompleteStartingPoint = true;
  }

  Rx<TaxiViewName> get textTitle =>
      isCompleteStartingPoint ? textTitles[1].obs : textTitles[0].obs;
  Rx<Taxi?> selectedTaxi = Rx<Taxi?>(null);
  Rx<String?> selectedTaxiAddress = Rx<String?>(null);
  List<String> addressType = ['عناويني', 'المدخلات الأخيرة'];
  RxString selectedAddressType = 'عناويني'.obs;

  void onAddressTypeChanged(String value) {
    selectedAddressType.value = value;
  }

  void selectLocation(Taxi location, String address) {
    selectTaxi(location);
    selectTaxiAddress(address);
    print('Selected Location: ${location.name}, Address: $address');
    print('Selected Location: ${selectedTaxi.value!.name} ');
    print('Selected Location: ${selectedTaxiAddress.value} ');
  }

  void selectTaxi(taxi) {
    selectedTaxi.value = taxi;
    selectedTaxiAddress.value = null;
  }

  void selectTaxiAddress(taxi) {
    selectedTaxiAddress.value = taxi;
  }

  // -----
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
}

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
  String toString() {
    return name;
  }
}

class TaxiViewName {
  String title;
  String subtitle;
  TaxiViewName({required this.title, required this.subtitle});
}
