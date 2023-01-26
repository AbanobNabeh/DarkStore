class ModelCategory {
  int? id;
  String? nameAr;
  String? nameEn;
  String? image;
  String? userId;

  ModelCategory({this.id, this.nameAr, this.nameEn, this.image, this.userId});

  ModelCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nameAr = json['name_ar'];
    nameEn = json['name_en'];
    image = json['image'];
    userId = json['user_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name_ar'] = this.nameAr;
    data['name_en'] = this.nameEn;
    data['image'] = this.image;
    data['user_id'] = this.userId;
    return data;
  }
}
