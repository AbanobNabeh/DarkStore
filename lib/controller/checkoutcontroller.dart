import 'package:darkstore/components/linkapi.dart';
import 'package:darkstore/controller/cartcontroller.dart';
import 'package:darkstore/controller/homecontroller.dart';
import 'package:darkstore/network/dioapp.dart';
import 'package:darkstore/view/cart/webview.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../components/constants.dart';
import '../network/diopayment.dart';

class CheckOutController extends GetxController {
  String contrycode = "+20";
  int indexlocation = 0;
  String couponmessage = '';
  int coupondis = 0;
  List cart = Get.put(CartController()).cart;
  RxBool isloading = false.obs;

  TextEditingController phonenumber = TextEditingController();
  TextEditingController couponcode = TextEditingController();
  changeindexlocation(int index) {
    indexlocation = index;
    update();
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
            Get.toNamed('googlemap');
          }
        });
      }
    });
  }

  void usecoupon() {
    DioApp.postData(url: USECOUPON, data: {'code': couponcode.text})
        .then((value) {
      if (value.data == "coupon code has expired" ||
          value.data == 'coupon code invalid') {
        couponmessage = value.data;
        coupondis = 0;
        update();
      } else {
        coupondis = value.data[0]['discount'];
        update();
      }
    });
  }

  void removecoupon() {
    coupondis = 0;
    couponmessage = '';
    update();
  }

  double totalprice() {
    double total = 0;
    cart.forEach((element) {
      if (element.products.discount == 0) {
        num finalprice = element.products.price * element.quantityCart;
        total = finalprice + total;
      } else {
        int discount =
            element.products.price * element.products.discount ~/ 100;
        int b = element.products.price - discount;
        num finalprice = b * element.quantityCart;
        total = finalprice + total;
      }
    });

    return total;
  }

  Map applaycoupon() {
    if (coupondis != 0) {
      double discount = totalprice() * coupondis / 100;
      double b = totalprice() - discount;
      return {
        'discountpercentage': discount,
        'totalprice': b,
      };
    }
    return {
      'discountpercentage': 0,
      'totalprice': 0,
    };
  }

  void getfirsttoken() {
    isloading.value = true;
    DioPayment.postData(url: "auth/tokens", data: {"api_key": paymobapikey})
        .then((value) {
      PAYMOBTOKEN = value.data['token'];
      getorderid();
    });
  }

  List setitem() {
    List item = [];
    cart.forEach((element) {
      item.add({
        "name": element.idProduct,
        "amount_cents": "${element.products.price}",
        "description": id,
        "quantity": element.quantityCart
      });
    });
    return item;
  }

  void getorderid() async {
    DioPayment.postData(url: "ecommerce/orders", data: {
      "auth_token": PAYMOBTOKEN,
      "delivery_needed": "false",
      "amount_cents": coupondis == 0
          ? "${totalprice().round()}00"
          : '${applaycoupon()['totalprice'].round()}00',
      "currency": "EGP",
      "items": setitem()
    }).then((value) {
      orderid = value.data['id'].toString();
      getfinaltokencard();
    });
  }

  getfinaltokencard() async {
    DioPayment.postData(url: "acceptance/payment_keys", data: {
      "auth_token": PAYMOBTOKEN,
      "amount_cents": coupondis == 0
          ? "${totalprice().round()}00"
          : '${applaycoupon()['totalprice'].round()}00',
      "expiration": 3600,
      "order_id": orderid,
      "billing_data": {
        "apartment": "NA",
        "email": Get.put(HomeController()).modelProfile!.email,
        "floor": "NA",
        "first_name": Get.put(HomeController()).modelProfile!.name,
        "street":
            Get.put(HomeController()).modelProfile!.location![indexlocation],
        "building": "NA",
        "phone_number": "$contrycode${phonenumber.text}",
        "shipping_method": "NA",
        "postal_code": "NA",
        "city": "NA",
        "country": "NA",
        "last_name": id.toString(),
        "state": "NA",
      },
      "currency": "EGP",
      "integration_id": InitIDCard,
      "lock_order_when_paid": "false"
    }).then((value) {
      finaltokenCard = value.data['token'];

      isloading.value = false;
      Get.offNamed('payment');
    });
  }
}
