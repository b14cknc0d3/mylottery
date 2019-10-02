import 'dart:convert';

class SearchResult {
  List<OneLs> oneLs;

  SearchResult({this.oneLs});

  SearchResult.fromJson(Map<String, dynamic> json) {
    if (json['one_ls'] != null) {
      oneLs = new List<OneLs>();
      json['one_ls'].forEach((v) {
        oneLs.add(new OneLs.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.oneLs != null) {
      data['one_ls'] = this.oneLs.map((v) => v.toMap()).toList();
    }
    return data;
  }
}

class OneLs {
  int id;

  String lno;
  String name;
  String reseller;
  String address;
  String phone;
  String nth;
  String isWinner;
  String prizeDetails;
  String createdAt;
  String updatedAt;
  bool selected = false;

  OneLs(
      {this.id,
      this.lno,
      this.phone,
      this.reseller,
      this.address,
      this.nth,
      this.isWinner,
      this.prizeDetails,
      this.createdAt,
      this.updatedAt});

  OneLs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    phone = json['phone'];
    lno = json['lno'];
    name = json['name'];
    reseller = json['reseller'];
    address = json['address'];
    nth = json['nth'];
    isWinner = json['is_winner'];
    prizeDetails = json['prize_details'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        "lno": lno,
        "phone": phone,
        "address": address,
        "is_winner": isWinner,
        "prize_details": prizeDetails,
      };
}
