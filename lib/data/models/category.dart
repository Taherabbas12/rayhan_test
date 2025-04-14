class Category {
  final int id;
  final int index;
  final String name;
  final String? img;
  final int categories;
  final bool enable;
  final bool? showInHome;

  Category({
    required this.id,
    required this.index,
    required this.name,
    this.img,
    required this.categories,
    required this.enable,
    this.showInHome,
  });

  // Convert a JSON map into a Categoryط instance
  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      index: json['index'],
      name: json['name'],
      img: json['img'],
      // Parsing categories from string to int; defaults to 0 if parsing fails
      categories: int.tryParse(json['categories'].toString()) ?? 0,
      // Convert enable which is provided as a string in JSON to bool
      enable: json['enable'].toString().toLowerCase() == 'true',
      // Convert showlnhome if it is not null, otherwise keep as null
      showInHome:
          json['showlnhome'] != null
              ? json['showlnhome'].toString().toLowerCase() == 'true'
              : null,
    );
  }

  // Convert the Categoryط instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'index': index,
      'name': name,
      'img': img,
      'categories': categories.toString(),
      'enable': enable.toString(),
      'showlnhome': showInHome?.toString(),
    };
  }
}
