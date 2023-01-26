class ModelBanner {
  int? id;
  String? banner;
  String? time;

  ModelBanner({this.id, this.banner, this.time});

  ModelBanner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    banner = json['banner'];
    time = json['time'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['banner'] = this.banner;
    data['time'] = this.time;
    return data;
  }
}
