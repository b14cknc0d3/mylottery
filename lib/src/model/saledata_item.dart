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
      data['one_ls'] = this.oneLs.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OneLs {
  int id;
  String lno;
  String reseller;
  String address;
  String nth;
  String isWinner;
  String prizeDetails;
  String createdAt;
  String updatedAt;

  OneLs(
      {this.id,
        this.lno,
        this.reseller,
        this.address,
        this.nth,
        this.isWinner,
        this.prizeDetails,
        this.createdAt,
        this.updatedAt});

  OneLs.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    lno = json['lno'];
    reseller = json['reseller'];
    address = json['address'];
    nth = json['nth'];
    isWinner = json['is_winner'];
    prizeDetails = json['prize_details'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['lno'] = this.lno;
    data['reseller'] = this.reseller;
    data['address'] = this.address;
    data['nth'] = this.nth;
    data['is_winner'] = this.isWinner;
    data['prize_details'] = this.prizeDetails;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}