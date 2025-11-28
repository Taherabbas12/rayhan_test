import 'restaurant.dart';
import 'slider_image_model.dart';

class HomeResponseModel {
  final List<Restaurant> forNow;
  final List<dynamic> freeDelivery; // لم ترسل تركيبه، نخليه ديناميك مؤقتًا
  final List<ShowsItemModel> shows;
  final List<SliderImageModel> sliderImageModel;
  final int freeDeliveryCount;

  HomeResponseModel({
    required this.forNow,
    required this.freeDelivery,
    required this.shows,
    required this.freeDeliveryCount,
    required this.sliderImageModel,
  });

  factory HomeResponseModel.fromJson(Map<String, dynamic> json) {
    return HomeResponseModel(
      forNow:
          (json["forNow"] as List)
              .map((item) => Restaurant.fromJson(item))
              .toList(),
      freeDelivery: json['freeDelivery'] ?? [],
      shows:
          (json['shows'] as List<dynamic>?)
              ?.map((e) => ShowsItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      sliderImageModel:
          (json['shows'] as List<dynamic>?)
              ?.map((e) => SliderImageModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
      freeDeliveryCount: json['freeDeliveryCount'] ?? 0,
    );
  }
}

class ShowsItemModel {
  int id;
  int index;
  String image;
  String type;
  DateTime date;

  ShowsItemModel({
    required this.id,
    required this.index,
    required this.image,
    required this.type,
    required this.date,
  });

  factory ShowsItemModel.fromJson(Map<String, dynamic> json) {
    return ShowsItemModel(
      id: json['id'],
      index: json['index'],
      image: json['image'] ?? "",
      type: json['type'] ?? "",
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "index": index,
      "image": image,
      "type": type,
      "date": date.toIso8601String(),
    };
  }
}
