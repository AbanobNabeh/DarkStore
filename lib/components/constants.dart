import 'package:darkstore/components/components.dart';
import 'package:darkstore/network/cachehelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hexcolor/hexcolor.dart';

import '../homepage.dart';
import '../view/auth/signin.dart';
import '../view/auth/singup.dart';
import '../view/boarding/onboarding.dart';
import '../view/boarding/splashscreen.dart';
import '../view/cart/checkout.dart';
import '../view/cart/googlemap.dart';
import '../view/cart/webview.dart';

var id = CacheHelper.getData(key: "id");
var onboarding = CacheHelper.getData(key: "onboarding");
var lang = CacheHelper.getData(key: "lang");
HexColor defcolor = HexColor('333742');
HexColor defgraycolor = HexColor('454D5A');

//PayMob
String paymobapikey = "YOURpaymobapikey";
String PAYMOBTOKEN = "";
String orderid = "";
String finaltokenCard = "";
String InitIDCard = "YOURINITCARD";
//End

// Handle error
handelerror(error) {
  if (error.toString() ==
      "[firebase_auth/invalid-email] The email address is badly formatted.") {
    Get.snackbar(
      'erroroccurred'.tr,
      'emailerror'.tr,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      messageText:
          defText(text: 'emailerror'.tr, size: 14, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
    );
  } else if (error.toString() ==
      "[firebase_auth/email-already-in-use] The email address is already in use by another account.") {
    Get.snackbar(
      'erroroccurred'.tr,
      'thisemailalready'.tr,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      messageText:
          defText(text: 'thisemailalready'.tr, size: 14, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
    );
  } else if (error.toString() ==
      "[firebase_auth/wrong-password] The password is invalid or the user does not have a password.") {
    Get.snackbar(
      'erroroccurred'.tr,
      'passwordisincorrect'.tr,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      messageText: defText(
          text: 'passwordisincorrect'.tr, size: 14, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
    );
  } else if (error.toString() ==
      "[firebase_auth/user-not-found] There is no user record corresponding to this identifier. The user may have been deleted.") {
    Get.snackbar(
      'erroroccurred'.tr,
      'emaile'.tr,
      backgroundColor: Colors.red,
      colorText: Colors.white,
      messageText: defText(text: 'emaile'.tr, size: 14, color: Colors.white),
      snackPosition: SnackPosition.BOTTOM,
    );
  } else {
    Get.snackbar('Error', error.toString(),
        backgroundColor: Colors.red, colorText: Colors.white);
  }
}
// End

// RoutePages
List<GetPage<dynamic>>? pages = [
  GetPage(name: '/', page: () => SplashScreen()),
  GetPage(
    name: '/signin',
    page: () => SignInScreen(),
  ),
  GetPage(
    name: '/signup',
    page: () => SignUpScreen(),
  ),
  GetPage(
    name: '/boardingScreen',
    page: () => OnboardingScreen(),
  ),
  GetPage(
    name: '/home',
    page: () => HomePage(),
  ),
  GetPage(
    name: '/checkout',
    page: () => CheckOutScreen(),
  ),
  GetPage(
    name: '/googlemap',
    page: () => GoogleMapScreen(),
  ),
  GetPage(
    name: '/payment',
    page: () => PaymentScreen(),
  ),
];

// End

// getlang
String trans() {
  if (lang == null) {
    if (Get.deviceLocale.toString() == 'ar_EG') {
      return "ar";
    } else {
      return "en";
    }
  } else {
    if (lang == 'ar') {
      return "ar";
    } else {
      return "en";
    }
  }
}
// end