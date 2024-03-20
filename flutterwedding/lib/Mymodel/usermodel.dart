class Usermodel {
  String? iduser;
  String? nameuser;
  String? username;
  String? password;
  String? phone;
  String? address;
  String? status;

  Usermodel(
      {this.iduser,
      this.nameuser,
      this.username,
      this.password,
      this.phone,
      this.address,
      this.status});

  Usermodel.fromJson(Map<String, dynamic> json) {
    iduser = json['iduser'];
    nameuser = json['nameuser'];
    username = json['username'];
    password = json['password'];
    phone = json['phone'];
    address = json['address'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['iduser'] = iduser;
    data['nameuser'] = nameuser;
    data['username'] = username;
    data['password'] = password;
    data['phone'] = phone;
    data['address'] = address;
    data['status'] = status;
    return data;
  }
}
