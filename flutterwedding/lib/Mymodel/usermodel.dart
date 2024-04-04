class Usermodel {
  String? iduser;
  String? picture;
  String? nameuser;
  String? username;
  String? password;
  String? phone;
  String? address;
  String? status;

  Usermodel(
      {this.iduser,
      this.picture,
      this.nameuser,
      this.username,
      this.password,
      this.phone,
      this.address,
      this.status});

  Usermodel.fromJson(Map<String, dynamic> json) {
    iduser = json['iduser'];
    picture = json['picture'];
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
    data['picture'] = picture;
    data['nameuser'] = nameuser;
    data['username'] = username;
    data['password'] = password;
    data['phone'] = phone;
    data['address'] = address;
    data['status'] = status;
    return data;
  }
}
