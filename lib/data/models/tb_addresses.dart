class TbAddresses {
  final int id;
  final String homeNo;
  final String buildingNo;
  final String roofNo;
  final String blockNo;
  final String nickName;
  final bool inBasmaya;
  final String userid;

  TbAddresses({
    required this.id,
    required this.homeNo,
    required this.buildingNo,
    required this.roofNo,
    required this.blockNo,
    required this.nickName,
    required this.inBasmaya,
    required this.userid,
  });

  // Create a TbAddresses instance from a JSON map.
  factory TbAddresses.fromJson(Map<String, dynamic> json) {
    return TbAddresses(
      id: json['id'],
      homeNo: json['homeNo'] ?? "",
      buildingNo: json['buildingNo'] ?? "",
      roofNo: json['roofNo'] ?? "",
      blockNo: json['blockNo'] ?? "",
      nickName: json['nickName'] ?? "",
      inBasmaya: json['inBasmaya'] ?? false,
      userid: json['userid'] ?? "",
    );
  }

  // Convert a TbAddresses instance into a JSON map.
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
}
