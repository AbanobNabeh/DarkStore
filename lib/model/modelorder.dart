class ModelOrder {
  int? id;
  int? orderId;
  String? location;
  String? phonenumber;
  String? idUser;
  String? statusOrder;
  String? amountCents;
  String? nameUser;
  String? updatedAt;
  String? createdAt;
  List<Cart>? cart;

  ModelOrder(
      {this.id,
      this.orderId,
      this.location,
      this.phonenumber,
      this.idUser,
      this.statusOrder,
      this.amountCents,
      this.nameUser,
      this.updatedAt,
      this.createdAt,
      this.cart});

  ModelOrder.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    orderId = json['order_id'];
    location = json['location'];
    phonenumber = json['phonenumber'];
    idUser = json['id_user'];
    statusOrder = json['status_order'];
    amountCents = json['amount_cents'];
    nameUser = json['name_user'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    if (json['cart'] != null) {
      cart = <Cart>[];
      json['cart'].forEach((v) {
        cart!.add(new Cart.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['order_id'] = this.orderId;
    data['location'] = this.location;
    data['phonenumber'] = this.phonenumber;
    data['id_user'] = this.idUser;
    data['status_order'] = this.statusOrder;
    data['amount_cents'] = this.amountCents;
    data['name_user'] = this.nameUser;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    if (this.cart != null) {
      data['cart'] = this.cart!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Cart {
  int? id;
  int? idProduct;
  String? idUser;
  String? status;
  int? quantityCart;
  int? orderId;
  List<Product>? product;

  Cart(
      {this.id,
      this.idProduct,
      this.idUser,
      this.status,
      this.quantityCart,
      this.orderId,
      this.product});

  Cart.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    idProduct = json['id_product'];
    idUser = json['id_user'];
    status = json['status'];
    quantityCart = json['quantity_cart'];
    orderId = json['order_id'];
    if (json['product'] != null) {
      product = <Product>[];
      json['product'].forEach((v) {
        product!.add(new Product.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['id_product'] = this.idProduct;
    data['id_user'] = this.idUser;
    data['status'] = this.status;
    data['quantity_cart'] = this.quantityCart;
    data['order_id'] = this.orderId;
    if (this.product != null) {
      data['product'] = this.product!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Product {
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

  Product(
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

  Product.fromJson(Map<String, dynamic> json) {
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
