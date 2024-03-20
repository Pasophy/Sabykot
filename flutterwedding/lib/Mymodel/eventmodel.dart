
class Eventmodel {
  String? idevent;
  String? iduser;
  String? nameuser;
  String? eventname;
  String? picture;
  String? eventdetail;
  String? eventdate;
  String? expridate;
  String? status;

  Eventmodel(
      {this.idevent,
      this.iduser,
      this.nameuser,
      this.eventname,
      this.picture,
      this.eventdetail,
      this.eventdate,
      this.expridate,
      this.status});

  Eventmodel.fromJson(Map<String, dynamic> json) {
    idevent = json['idevent'];
    iduser = json['iduser'];
    nameuser = json['nameuser'];
    eventname = json['eventname'];
    picture = json['picture'];
    eventdetail = json['eventdetail'];
    eventdate = json['eventdate'];
    expridate = json['expridate'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idevent'] = idevent;
    data['iduser'] = iduser;
    data['nameuser'] = nameuser;
    data['eventname'] = eventname;
    data['picture'] = picture;
    data['eventdetail'] = eventdetail;
    data['eventdate'] = eventdate;
    data['expridate'] = expridate;
    data['status'] = status;
    return data;
  }
}
