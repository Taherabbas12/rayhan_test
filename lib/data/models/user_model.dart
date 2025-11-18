class UserModel {
  final int id;
  final int shopId;
  String name;
  final String? city;
  final bool admin;
  final dynamic staff;
  final bool star;
  final String token;
  String phone;
  final String? img;
  final bool active;
  final String date;
  final String deviecidx;
  final String lat;
  final String lang;
  final String type;
  final dynamic debt;
  final dynamic maxdebt;
  final String? subcity;
  final String? storage;
  final dynamic resturant;
  final dynamic ky1;
  final dynamic ky2;
  final dynamic ky3;
  final dynamic ky4;
  final dynamic ky5;
  final dynamic ky6;
  final dynamic ordernow;
  final String? note1;
  final String? note2;
  String birthday;
  final dynamic six;
  final String addressid;
  final String? carName;
  final String? carNo;
  final String pass;
  final bool isBusy;
  final bool driverOnWork;

  UserModel({
    required this.id,
    required this.shopId,
    required this.name,
    this.city,
    required this.admin,
    this.staff,
    required this.star,
    required this.token,
    required this.phone,
    this.img,
    required this.active,
    required this.date,
    required this.deviecidx,
    required this.lat,
    required this.lang,
    required this.type,
    this.debt,
    this.maxdebt,
    this.subcity,
    this.storage,
    this.resturant,
    this.ky1,
    this.ky2,
    this.ky3,
    this.ky4,
    this.ky5,
    this.ky6,
    this.ordernow,
    this.note1,
    this.note2,
    required this.birthday,
    this.six,
    required this.addressid,
    this.carName,
    this.carNo,
    required this.pass,
    required this.isBusy,
    required this.driverOnWork,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
    id: json['id'] ?? 0,
    shopId: json['shopId'] ?? 0,
    name: json['name'] ?? '',
    city: json['city'],
    admin: json['admin'] ?? false,
    staff: json['staff'],
    star: json['star'] ?? false,
    token: json['token'] ?? '',
    phone: json['phone'] ?? '',
    img: json['img'],
    active: json['active'] ?? false,
    date: json['date'] ?? '',
    deviecidx: json['deviecidx'] ?? '',
    lat: json['lat'] ?? '0.0',
    lang: json['lang'] ?? '0.0',
    type: json['type'] ?? 'user',
    debt: json['debt'],
    maxdebt: json['maxdebt'],
    subcity: json['subcity'],
    storage: json['storage'],
    resturant: json['resturant'],
    ky1: json['ky1'],
    ky2: json['ky2'],
    ky3: json['ky3'],
    ky4: json['ky4'],
    ky5: json['ky5'],
    ky6: json['ky6'],
    ordernow: json['ordernow'],
    note1: json['note1'],
    note2: json['note2'],
    birthday: json['birthday'] ?? '',
    six: json['six'],
    addressid: json['addressid'] ?? '',
    carName: json['carName'],
    carNo: json['carNo'],
    pass: json['pass'] ?? '',
    isBusy: json['isBusy'] ?? false,
    driverOnWork: json['driverOnWork'] ?? false,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'shopId': shopId,
    'name': name,
    'city': city,
    'admin': admin,
    'staff': staff,
    'star': star,
    'token': token,
    'phone': phone,
    'img': img,
    'active': active,
    'date': date,
    'deviecidx': deviecidx,
    'lat': lat,
    'lang': lang,
    'type': type,
    'debt': debt,
    'maxdebt': maxdebt,
    'subcity': subcity,
    'storage': storage,
    'resturant': resturant,
    'ky1': ky1,
    'ky2': ky2,
    'ky3': ky3,
    'ky4': ky4,
    'ky5': ky5,
    'ky6': ky6,
    'ordernow': ordernow,
    'note1': note1,
    'note2': note2,
    'birthday': birthday,
    'six': six,
    'addressid': addressid,
    'carName': carName,
    'carNo': carNo,
    'pass': pass,
    'isBusy': isBusy,
    'driverOnWork': driverOnWork,
  };
}
