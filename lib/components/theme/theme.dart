import 'package:darkstore/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hexcolor/hexcolor.dart';

ThemeData themeData = ThemeData(
  scaffoldBackgroundColor: defcolor,
  appBarTheme: AppBarTheme(
      color: HexColor('333742'),
      iconTheme: IconThemeData(color: Colors.white),
      elevation: 0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: HexColor('333742'),
      )),
);
