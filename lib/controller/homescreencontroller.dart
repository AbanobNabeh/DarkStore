import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../components/constants.dart';
import '../components/linkapi.dart';
import '../model/modelbanner.dart';
import '../model/modelcategory.dart';
import '../model/modelproduct.dart';
import '../network/dioapp.dart';

class HomeScreenController extends GetxController {
  RxBool isloading = false.obs;
  RxList banner = [].obs;
  RxList category = [].obs;
  RxList product = [].obs;
  late PageController pageController;
  int currentPage = 0;
  @override
  void onInit() {
    pageController =
        PageController(initialPage: currentPage, viewportFraction: 0.9);
    getbanner();
    getcategory();
    getprocudt();
    super.onInit();
  }

  void getbanner() async {
    isloading.value = true;
    DioApp.getData(url: 'banner').then((value) {
      banner.value = [];
      value.data.forEach((element) {
        banner.add(ModelBanner.fromJson(element));
      });
      isloading.value = false;
    });
  }

  void getcategory() async {
    isloading.value = true;
    DioApp.getData(url: CATEGORY).then((value) {
      category.value = [];
      value.data.forEach((element) {
        category.add(ModelCategory.fromJson(element));
      });
      isloading.value = false;
    });
  }

  void getprocudt() async {
    isloading.value = true;
    DioApp.postData(url: PRODUCT, data: {'id': id}).then((value) {
      product.value = [];
      value.data.forEach((element) {
        product.add(ModelProduct.fromJson(element));
      });
      isloading.value = false;
    });
  }

  int changepriceafterdic(int discount, int price) {
    int i = price * discount ~/ 100;
    int b = price - i;
    return b;
  }

  void addfav(ModelProduct product) {
    update();
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
}
