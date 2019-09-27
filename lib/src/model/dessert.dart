class Dessert {
  Dessert(this.name, this.calories, this.fat, this.carbs, this.protein,
      this.sodium, this.calcium, this.iron);

  final String name;
  final int calories;
  final double fat;
  final int carbs;
  final double protein;
  final int sodium;
  final int calcium;
  final int iron;

  bool selected = false;
}

class Ntb {
  final int serialNo;
  final String name;
  final String sex;
  final String address;
  final String townShipTbNo;
  final String nameOfTreatmentCenter;
  final String regGp;
  final String dsc;
  final String xPertR;
  final String culture;
  final double S;
  final double H;
  final double R;
  final double E;
  final double Z;
  final double am;
  final double cm;
  final double fq;
  final double ptoEto;
  final double other;
  final double other2;

  Ntb(
      this.serialNo,
      this.name,
      this.sex,
      this.address,
      this.townShipTbNo,
      this.nameOfTreatmentCenter,
      this.regGp,
      this.dsc,
      this.xPertR,
      this.culture,
      this.S,
      this.H,
      this.R,
      this.E,
      this.Z,
      this.am,
      this.cm,
      this.fq,
      this.ptoEto,
      this.other,
      this.other2);

  bool selected = false;
}
