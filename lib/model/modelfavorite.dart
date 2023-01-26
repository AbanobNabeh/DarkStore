class ModelFavorite {
  int? id;
  int? idFavProduct;
  String? idFavUser;
  Products? products;

  ModelFavorite({this.id, this.idFavProduct, this.idFavUser, this.products});

  ModelFavorite.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idFavProduct = json['id_fav_product'];
    idFavUser = json['id_fav_user'];
    products = json['products'] != null
        ? new Products.fromJson(json['products'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_fav_product'] = this.idFavProduct;
    data['id_fav_user'] = this.idFavUser;
    if (this.products != null) {
      data['products'] = this.products!.toJson();
    }
    return data;
  }
}

class Products {
  int? id;
  String? titleAr;
  String? titleEn;
  String? descriptionAr;
  String? descriptionEn;
  int? quantity;
  int? rate;
  String? idUser;
  int? idCategorie;
  String? idProduct;
  int? price;
  int? discount;
  int? active;
  String? image;

  Products(
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
      this.image});

  Products.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
