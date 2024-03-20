
class Customermodel {
  String? idcustomer;
  String? iduser;
  String? nameuser;
  String? picture;
  String? namecustomer;
  String? usercustomer;
  String? password;
  String? phone;
  String? address;
  String? status;

  Customermodel(
      {this.idcustomer,
      this.iduser,
      this.nameuser,
      this.picture,
      this.namecustomer,
      this.usercustomer,
      this.password,
      this.phone,
      this.address,
      this.status});

  Customermodel.fromJson(Map<String, dynamic> json) {
    idcustomer = json['idcustomer'];
    iduser = json['iduser'];
    nameuser = json['nameuser'];
    picture = json['picture'];
    namecustomer = json['namecustomer'];
    usercustomer = json['usercustomer'];
    password = json['password'];
    phone = json['phone'];
    address = json['address'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idcustomer'] = idcustomer;
    data['iduser'] = iduser;
    data['nameuser'] = nameuser;
    data['picture'] = picture;
    data['namecustomer'] = namecustomer;
    data['usercustomer'] = usercustomer;
    data['password'] = password;
    data['phone'] = phone;
    data['address'] = address;
    data['status'] = status;
    return data;
  }
}
