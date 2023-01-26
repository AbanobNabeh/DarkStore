import 'dart:async';

import 'package:darkstore/controller/homecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/components.dart';
import '../../components/constants.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      if (onboarding == null) {
        Get.offNamed('boardingScreen');
      } else {
        if (id == null) {
          Get.offNamed('signin');
        } else {
          Get.offNamed('home');
        }
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      body: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: defcolor,
            ),
          ),
          Center(
              child: defText(
                  text: 'appname',
                  size: 30,
                  color: Colors.white,
                  fontWeight: FontWeight.w700)),
        ],
      ),
    );
    ;
  }
}
