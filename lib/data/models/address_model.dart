class AddressModel {
  final int id;
  final String homeNo;
  final String buildingNo;
  final String roofNo;
  final String blockNo;
  final String nickName;
  final bool inBasmaya;
  final String userid;

  AddressModel({
    required this.id,
    required this.homeNo,
    required this.buildingNo,
    required this.roofNo,
    required this.blockNo,
    required this.nickName,
    required this.inBasmaya,
    required this.userid,
  });
  static List<AddressModel> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => AddressModel.fromJson(json)).toList();
  }

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] ?? 0,
      homeNo: json['homeNo'] ?? '',
      buildingNo: json['buildingNo'] ?? '',
      roofNo: json['roofNo'] ?? '',
      blockNo: json['blockNo'] ?? '',
      nickName: json['nickName'] ?? '',
      inBasmaya: json['inBasmaya'] ?? false,
      userid: json['userid']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'homeNo': homeNo,
      'buildingNo': buildingNo,
      'roofNo': roofNo,
      'blockNo': blockNo,
      'nickName': nickName,
      'inBasmaya': inBasmaya,
      'userid': userid,
    };
  }

  AddressModel copyWith({
    int? id,
    String? homeNo,
    String? buildingNo,
    String? roofNo,
    String? blockNo,
    String? nickName,
    bool? inBasmaya,
    String? userid,
  }) {
    return AddressModel(
      id: id ?? this.id,
      homeNo: homeNo ?? this.homeNo,
      buildingNo: buildingNo ?? this.buildingNo,
      roofNo: roofNo ?? this.roofNo,
      blockNo: blockNo ?? this.blockNo,
      nickName: nickName ?? this.nickName,
      inBasmaya: inBasmaya ?? this.inBasmaya,
      userid: userid ?? this.userid,
    );
  }

  // 🇸🇦 عرض مختصر في سطر واحد فقط
  @override
  String toString() {
    final name = nickName.isNotEmpty ? "($nickName)" : "";
    return "🏠 $name بلوك $blockNo، بناية $buildingNo، منزل $homeNo";
  }
}
