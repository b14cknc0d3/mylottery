import 'dart:convert';

class SearchSale {
  List<SaleResultItem> items;

  SearchSale({
    this.items,
  });
static SearchSale fromJson(Map<String,dynamic>json){
  final items = (json['one_ls'] as List<dynamic>).map((dynamic item)=>
  SaleResultItem.fromMap(item as Map<String,dynamic>)).toList();
  return SearchSale(items: items);
}
//  factory SearchSale.fromJson(String str) => SearchSale.fromMap(json.decode(str));
//
//  String toJson() => json.encode(toMap());
//
//  factory SearchSale.fromMap(Map<String, dynamic> json) => new SearchSale(
//    items: new List<SaleResultItem>.from(json["one_ls"].map((x) => SaleResultItem.fromMap(x))),
//  );
//
//  Map<String, dynamic> toMap() => {
//    "one_ls": new List<dynamic>.from(items.map((x) => x.toMap())),
//  };
}

class SaleResultItem {
  int id;
  String name;
  String lno;
  String reseller;
  String phone;
  String address;
  String nth;
  String isWinner;
  dynamic prizeDetails;
  DateTime createdAt;
  DateTime updatedAt;

  SaleResultItem({
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

  factory SaleResultItem.fromJson(String str) => SaleResultItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory SaleResultItem.fromMap(Map<String, dynamic> json) => new SaleResultItem(
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
