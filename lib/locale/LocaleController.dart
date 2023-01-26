import 'package:darkstore/network/cachehelper.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../components/constants.dart';

class LocaleController extends GetxController {
  void changelang(lange) {
    Locale locale = Locale(lange);
    lang = lange;
    CacheHelper.saveData(key: 'lang', value: lange);
    Get.updateLocale(locale);
  }
}
