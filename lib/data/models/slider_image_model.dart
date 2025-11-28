class SliderImageModel {
  final String img;

  SliderImageModel({required this.img});

  factory SliderImageModel.fromJson(Map<String, dynamic> json) {
    return SliderImageModel(img: json['img'] ?? json['image'] ?? '');
  }
  static List<SliderImageModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => SliderImageModel.fromJson(json)).toList();
  }
}
