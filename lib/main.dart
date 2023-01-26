import 'package:darkstore/components/constants.dart';
import 'package:darkstore/components/theme/theme.dart';
import 'package:darkstore/locale/locale.dart';
import 'package:darkstore/network/diopayment.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'network/cachehelper.dart';
import 'network/dioapp.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper.init();
  await DioApp.init();
  await DioPayment.init();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      locale: trans() == 'ar' ? Locale('ar') : Locale("en"),
      translations: LocaleApp(),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      theme: themeData,
      getPages: pages,
    );
  }
}
