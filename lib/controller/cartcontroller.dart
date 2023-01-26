import 'package:darkstore/components/constants.dart';
import 'package:darkstore/components/linkapi.dart';
import 'package:darkstore/controller/homecontroller.dart';
import 'package:darkstore/model/modelcart.dart';
import 'package:darkstore/model/modelorder.dart';
import 'package:darkstore/network/dioapp.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class CartController extends GetxController {
  RxList cart = [].obs;
  ModelOrder? modelOrder;
  RxBool isloading = false.obs;
  int changepriceafterdic(int discount, int price, int quantity) {
    int i = price * discount ~/ 100;
    int b = price - i;
    int finalprice = b * quantity;
    return finalprice;
  }

  @override
  void onInit() {
    getorders();
    super.onInit();
  }

  void getcart() {
    isloading.value = true;
    DioApp.postData(url: GETCART, data: {'id_user': id}).then((value) {
      cart.value = [];
      value.data!.forEach((elemnt) {
        cart.add(ModelCart.fromJson(elemnt));
      });
      isloading.value = false;
    });
  }

  void addcart(int idproduct) {
    DioApp.postData(url: ADDCART, data: {
      "id_user": id,
      'id_product': idproduct,
    }).then((value) {
      Get.snackbar('addtocart'.tr, "${value.data}".tr,
          backgroundColor: Colors.white);
      getcart();
    }).catchError((e) {});
  }

  void minuscart(int idproduct) {
    DioApp.postData(url: MINUSCART, data: {
      "id_user": id,
      'id_product': idproduct,
    }).then((value) {
      getcart();
    });
  }

  void removecart(int idproduct) {
    DioApp.postData(url: REMOVECART, data: {
      "id_user": id,
      'id_product': idproduct,
    }).then((value) {
      getcart();
    });
  }

  void permissionloc() {
    Permission.location.request().then((status) {
      if (status.isPermanentlyDenied) {
        openAppSettings();
      } else if (status.isGranted) {
        Geolocator.isLocationServiceEnabled().then((services) async {
          if (services == false) {
            await Geolocator.openLocationSettings();
          } else {
            if (Get.put(HomeController()).modelProfile!.location!.isEmpty) {
              Get.toNamed('googlemap');
            } else {
              Get.toNamed('checkout');
            }
          }
        });
      }
    });
  }

  void getorders() {
    DioApp.postData(url: ORDER, data: {'id_user': id}).then((value) {
      modelOrder = ModelOrder.fromJson(value.data[0]);
    });
  }

  int currentStep() {
    switch (modelOrder!.statusOrder!) {
      case 'inreview':
        {
          return 0;
        }
      case 'confirmation':
        {
          return 1;
        }
      case 'indelivery':
        {
          return 2;
        }
      case 'delivered':
        {
          return 3;
        }
    }
    return 0;
  }

  void confirma() {
    DioApp.postData(url: CONFIRMA, data: {'order_id': modelOrder!.orderId})
        .then((value) {
      getcart();
      getorders();
      update();
    });
  }
}
