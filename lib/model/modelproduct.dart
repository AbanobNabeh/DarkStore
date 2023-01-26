class ModelProduct {
  int? id;
  String? titleAr;
  String? titleEn;
  String? descriptionAr;
  String? descriptionEn;
  int? quantity;
  String? rate;
  String? idUser;
  int? idCategorie;
  String? idProduct;
  int? price;
  int? discount;
  int? active;
  String? image;
  bool? myrate;
  bool? myfavorite;
  List<Reviews>? reviews;

  ModelProduct(
      {this.id,
      this.titleAr,
      this.titleEn,
      this.descriptionAr,
      this.descriptionEn,
      this.quantity,
      this.rate,
      this.idUser,
      this.idCategorie,
      this.idProduct,
      this.price,
      this.discount,
      this.active,
      this.image,
      this.myrate,
      this.myfavorite,
      this.reviews});

  ModelProduct.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    titleAr = json['title_ar'];
    titleEn = json['title_en'];
    descriptionAr = json['description_ar'];
    descriptionEn = json['description_en'];
    quantity = json['quantity'];
    rate = json['rate'];
    idUser = json['id_user'];
    idCategorie = json['id_categorie'];
    idProduct = json['id_product'];
    price = json['price'];
    discount = json['discount'];
    active = json['active'];
    image = json['image'];
    myrate = json['myrate'];
    myfavorite = json['myfavorite'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(Reviews.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title_ar'] = this.titleAr;
    data['title_en'] = this.titleEn;
    data['description_ar'] = this.descriptionAr;
    data['description_en'] = this.descriptionEn;
    data['quantity'] = this.quantity;
    data['rate'] = this.rate;
    data['id_user'] = this.idUser;
    data['id_categorie'] = this.idCategorie;
    data['id_product'] = this.idProduct;
    data['price'] = this.price;
    data['discount'] = this.discount;
    data['active'] = this.active;
    data['image'] = this.image;
    data['myrate'] = this.myrate;
    data['myfavorite'] = this.myfavorite;
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toMap()).toList();
    }
    return data;
  }
}

class Reviews {
  int? reviewsId;
  int? productId;
  String? comment;
  String? imageUser;
  String? date;
  String? idUser;
  String? review;
  String? nameUser;

  Reviews(
      {this.reviewsId,
      this.productId,
      this.comment,
      this.imageUser,
      this.date,
      this.idUser,
      this.review,
      this.nameUser});

  Reviews.fromJson(Map<String, dynamic> json) {
    reviewsId = json['reviews_id'];
    productId = json['product_id'];
    comment = json['comment'];
    imageUser = json['image_user'];
    date = json['date'];
    idUser = json['id_user'];
    review = json['review'];
    nameUser = json['name_user'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reviews_id'] = this.reviewsId;
    data['product_id'] = this.productId;
    data['comment'] = this.comment;
    data['image_user'] = this.imageUser;
    data['date'] = this.date;
    data['id_user'] = this.idUser;
    data['review'] = this.review;
    data['name_user'] = this.nameUser;
    return data;
  }
}
