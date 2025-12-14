import 'package:get/get.dart';

import 'restaurant.dart';
import 'slider_image_model.dart';

class HomeResponseModel {
  final RxList<Restaurant> forNow;
  final RxList<Restaurant> freeDelivery; // لم ترسل تركيبه، نخليه ديناميك مؤقتًا
  final RxList<ShowsItemModel> shows;
  final RxList<SliderImageModel> sliderImageModel;
  int freeDeliveryCount;

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
          (json["customShops"] as List)
              .map((item) => Restaurant.fromJson(item))
              .toList()
              .obs,
      freeDelivery:
          (json["freeDelivery"] as List)
              .map((item) => Restaurant.fromJson(item))
              .toList()
              .obs,
      shows:
          ((json['shows'] as List<dynamic>?)
                      ?.map(
                        (e) =>
                            ShowsItemModel.fromJson(e as Map<String, dynamic>),
                      )
                      .toList() ??
                  [])
              .obs,
      sliderImageModel:
          ((json['shows'] as List<dynamic>?)
                      ?.map(
                        (e) => SliderImageModel.fromJson(
                          e as Map<String, dynamic>,
                        ),
                      )
                      .toList() ??
                  [])
              .obs,
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
