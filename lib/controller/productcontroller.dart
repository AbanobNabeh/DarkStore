import 'package:darkstore/components/linkapi.dart';
import 'package:darkstore/controller/homecontroller.dart';
import 'package:darkstore/model/modelproduct.dart';
import 'package:darkstore/network/dioapp.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/constants.dart';

class ProductController extends GetxController {
  TextEditingController comment = TextEditingController();
  double rate = 1;

  int changepriceafterdic(int discount, int price) {
    int i = price * discount ~/ 100;
    int b = price - i;
    return b;
  }

  void addfav(ModelProduct product) {
    if (product.myfavorite == true) {
      DioApp.postData(url: REMOVEFAV, data: {
        "id_fav_product": product.id.toString(),
        "id_fav_user": id,
      }).then((value) {
        product.myfavorite = false;
        update();
      });
    } else {
      DioApp.postData(url: ADDFAV, data: {
        "id_fav_product": product.id.toString(),
        "id_fav_user": id,
      }).then((value) {
        product.myfavorite = true;

        update();
      });
    }
  }

  Reviews? reviews;
  void addrate(ModelProduct product) {
    reviews = Reviews(
      comment: comment.text,
      idUser: id,
      imageUser: Get.put(HomeController()).modelProfile!.image,
      nameUser: Get.put(HomeController()).modelProfile!.name,
      productId: product.id,
      review: rate.toString(),
    );
    DioApp.postData(url: ADDRATE, data: reviews!.toMap()).then((value) {
      if (product.rate == "0") {
        product.reviews!.add(reviews!);
        product.rate = rate.toString();
        product.myrate = true;
        update();
        Get.back();
      } else {
        double review = 0;
        product.reviews!.forEach((element) {
          review = double.parse(element.review!) + review; // = 2.5
        });
        review = review + rate; // = 5
        product.reviews!.add(reviews!);
        product.rate = "${review / product.reviews!.length}";
        product.myrate = true;
        update();
        Get.back();
      }
    });
  }

  void addcart(int idproduct) {
    DioApp.postData(url: ADDCART, data: {
      "id_user": id,
      'id_product': idproduct,
    }).then((value) {
      Get.snackbar('addtocart'.tr, "${value.data}".tr,
          backgroundColor: Colors.white);
    });
  }
}
