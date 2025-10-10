class NotificationModel {
  int id;
  String title;
  String body;
  int userx;
  String? img;
  String date;

  NotificationModel({
    required this.id,
    required this.title,
    required this.body,
    required this.userx,
    required this.date,
    this.img,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      userx: json['userx'] ?? 0,
      img: json['img'],
      date: json['date'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'body': body,
      'userx': userx,
      'img': img,
      'date': date,
    };
  }

  static List<NotificationModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => NotificationModel.fromJson(json)).toList();
  }
}
