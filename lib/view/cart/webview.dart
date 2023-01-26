import 'dart:async';

import 'package:darkstore/controller/cartcontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../components/constants.dart';

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: WebView(
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl:
            "https://accept.paymob.com/api/acceptance/iframes/698136?payment_token=$finaltokenCard",
        onPageFinished: (url) {
          if (url.substring(0, 58) ==
              "https://accept.paymobsolutions.com/api/acceptance/post_pay") {
            Get.put(CartController()).getcart();
            Timer(Duration(seconds: 3), () {
              Get.back();
            });
          }
        },
      ),
    );
  }
}
