class ModelProfile {
  String? name;
  String? email;
  String? password;
  String? phonenumber;
  String? image;
  String? uid;
  List? location;
  bool? verify;

  ModelProfile(
      {this.name,
      this.email,
      this.password,
      this.phonenumber,
      this.image,
      this.uid,
      this.verify,
      this.location});

  ModelProfile.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phonenumber = json['phonenumber'];
    image = json['image'];
    uid = json['uid'];
    verify = json['verify'];
    location = json['location'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['password'] = this.password;
    data['phonenumber'] = this.phonenumber;
    data['image'] = this.image;
    data['uid'] = this.uid;
    data['verify'] = this.verify;
    data['location'] = this.location;
    return data;
  }
}
