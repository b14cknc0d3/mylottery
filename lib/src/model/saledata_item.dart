import 'dart:convert';

class SaleData {
  int id;
  String lno;
  String reseller;
  String phone;
  String address;
  String nth;
  String isWinner;
  dynamic prizeDetails;
  DateTime createdAt;
  DateTime updatedAt;

  SaleData({
    this.id,
    this.lno,
    this.reseller,
    this.phone,
    this.address,
    this.nth,
    this.isWinner,
    this.prizeDetails,
    this.createdAt,
    this.updatedAt,
    bool selected = false,
  });

  factory SaleData.fromJson(String str) => SaleData.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SaleData.fromMap(Map<String, dynamic> json) => new SaleData(
    id: json["id"],
    lno: json["lno"],
    reseller: json["reseller"],
    phone: json["phone"],
    address: json["address"],
    nth: json["nth"],
    isWinner: json["is_winner"],
    prizeDetails: json["prize_details"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "lno": lno,
    "reseller": reseller,
    "phone": phone,
    "address": address,
    "nth": nth,
    "is_winner": isWinner,
    "prize_details": prizeDetails,
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
  };
}
