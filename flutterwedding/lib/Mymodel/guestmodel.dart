
class Guestmodel {
  String? idguest;
  String? idevent;
  String? idcustomer;
  String? nameguest;
  String? amount;
  String? currency;
  String? paymenttype;
  String? address;
  String? status;

  Guestmodel(
      {this.idguest,
      this.idevent,
      this.idcustomer,
      this.nameguest,
      this.amount,
      this.currency,
      this.paymenttype,
      this.address,
      this.status});

  Guestmodel.fromJson(Map<String, dynamic> json) {
    idguest = json['idguest'];
    idevent = json['idevent'];
    idcustomer = json['idcustomer'];
    nameguest = json['nameguest'];
    amount = json['amount'];
    currency = json['currency'];
    paymenttype = json['paymenttype'];
    address = json['address'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idguest'] = idguest;
    data['idevent'] = idevent;
    data['idcustomer'] = idcustomer;
    data['nameguest'] = nameguest;
    data['amount'] = amount;
    data['currency'] = currency;
    data['paymenttype'] = paymenttype;
    data['address'] = address;
    data['status'] = status;
    return data;
  }
}
