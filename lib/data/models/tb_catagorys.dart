class TbCatagorys {
  final int id;
  final String name;
  final bool active;
  final String img;
  final DateTime date;
  final int sort;
  final bool home;
  final dynamic enable;
  final bool showInHome;

  TbCatagorys({
    required this.id,
    required this.name,
    required this.active,
    required this.img,
    required this.date,
    required this.sort,
    required this.home,
    this.enable,
    required this.showInHome,
  });

  // Convert a JSON map into a TbCatagorys instance
  factory TbCatagorys.fromJson(Map<String, dynamic> json) {
    return TbCatagorys(
      id: json['id'],
      name: json['name'],
      active: json['active'],
      img: json['img'],
      date: DateTime.parse(json['date']),
      // Parsing sort from string to int; defaults to 0 if parsing fails
      sort: int.tryParse(json['sort'].toString()) ?? 0,
      // Converting string value to bool for the home field
      home: json['home'].toString().toLowerCase() == 'true',
      enable: json['enable'],
      // Converting string value to bool for the showlnhome field (renamed to showInHome)
      showInHome: json['showlnhome'].toString().toLowerCase() == 'true',
    );
  }

  // Convert the TbCatagorys instance into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'active': active,
      'img': img,
      'date': date.toIso8601String(),
      // Converting sort back to a string to match the original JSON format
      'sort': sort.toString(),
      'home': home.toString(),
      'enable': enable,
      'showlnhome': showInHome.toString(),
    };
  }
}
