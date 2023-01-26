class ModelCart {
  int? id;
  int? idProduct;
  String? idUser;
  String? status;
  int? quantityCart;
  int? orderId;
  Products? products;

  ModelCart(
      {this.id,
      this.idProduct,
      this.idUser,
      this.status,
      this.quantityCart,
      this.orderId,
      this.products});

  ModelCart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idProduct = json['id_product'];
    idUser = json['id_user'];
    status = json['status'];
    quantityCart = json['quantity_cart'];
    orderId = json['order_id'];
    products = json['products'] != null
        ? new Products.fromJson(json['products'])
        : null;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_product'] = this.idProduct;
    data['id_user'] = this.idUser;
    data['status'] = this.status;
    data['quantity_cart'] = this.quantityCart;
    data['order_id'] = this.orderId;
    if (this.products != null) {
      data['products'] = this.products!.toMap();
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

  Map<String, dynamic> toMap() {
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
