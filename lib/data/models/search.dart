class Search {
  final int id;
  final String name;
  final String descc;
  final String cat;
  final bool active;
  final int count;
  final String img1;
  final String? img2;
  final String? img3;
  final String? img4;
  final String? img5;
  final dynamic simple;
  final DateTime date;
  final int price1;
  final int price2;
  final String curncy;
  final dynamic user;
  final dynamic star;
  final dynamic from;
  final dynamic starcount;
  final bool haveAmount;
  final String? companyname;
  final int subcategory;
  final String? uid;

  Search({
    required this.id,
    required this.name,
    required this.descc,
    required this.cat,
    required this.active,
    required this.count,
    required this.img1,
    this.img2,
    this.img3,
    this.img4,
    this.img5,
    this.simple,
    required this.date,
    required this.price1,
    required this.price2,
    required this.curncy,
    this.user,
    this.star,
    this.from,
    this.starcount,
    required this.haveAmount,
    this.companyname,
    required this.subcategory,
    this.uid,
  });

  /// Creates a Search instance from a JSON map.
  factory Search.fromJson(Map<String, dynamic> json) {
    return Search(
      id: json['id'],
      name: json['name'] ?? "",
      descc: json['descc'] ?? "",
      cat: json['cat'] ?? "",
      active: json['active'] ?? false,
      count: int.tryParse(json['count'].toString()) ?? 0,
      img1: json['img1'] ?? "",
      img2: json['img2'],
      img3: json['img3'],
      img4: json['img4'],
      img5: json['img5'],
      simple: json['simple'],
      date: DateTime.parse(json['date']),
      price1: int.tryParse(json['price1'].toString()) ?? 0,
      price2: int.tryParse(json['price2'].toString()) ?? 0,
      curncy: json['curncy'] ?? "",
      user: json['user'],
      star: json['star'],
      from: json['from'],
      starcount: json['starcount'],
      haveAmount: json['haveAmount'].toString().toLowerCase() == 'true',
      companyname:
          (json['companyname'] == null ||
                  json['companyname'].toString().toLowerCase() == 'null')
              ? null
              : json['companyname'],
      subcategory:
          json['subcategory'] is int
              ? json['subcategory']
              : int.tryParse(json['subcategory'].toString()) ?? 0,
      uid:
          (json['uid'] == null ||
                  json['uid'].toString().toLowerCase() == 'null')
              ? null
              : json['uid'],
    );
  }

  /// Converts the Search instance into a JSON map.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'descc': descc,
      'cat': cat,
      'active': active,
      'count': count.toString(),
      'img1': img1,
      'img2': img2,
      'img3': img3,
      'img4': img4,
      'img5': img5,
      'simple': simple,
      'date': date.toIso8601String(),
      'price1': price1.toString(),
      'price2': price2.toString(),
      'curncy': curncy,
      'user': user,
      'star': star,
      'from': from,
      'starcount': starcount,
      'haveAmount': haveAmount.toString(),
      'companyname': companyname,
      'subcategory': subcategory,
      'uid': uid,
    };
  }
}
