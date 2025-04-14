class TbShowsBanners {
  final int id;
  final String? name;
  final String descc;
  final String img;
  final String? link;
  final dynamic prod;
  final DateTime date;

  TbShowsBanners({
    required this.id,
    this.name,
    required this.descc,
    required this.img,
    this.link,
    this.prod,
    required this.date,
  });

  // Create a TbShowsBanners instance from a JSON object.
  factory TbShowsBanners.fromJson(Map<String, dynamic> json) {
    return TbShowsBanners(
      id: json['id'],
      name: json['name'],
      descc: json['descc'] ?? "",
      img: json['img'] ?? "",
      link: json['link'],
      prod: json['prod'],
      date: DateTime.parse(json['date']),
    );
  }

  // Convert a TbShowsBanners instance into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'descc': descc,
      'img': img,
      'link': link,
      'prod': prod,
      'date': date.toIso8601String(),
    };
  }
}
