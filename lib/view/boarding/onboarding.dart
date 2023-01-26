import 'package:darkstore/components/components.dart';
import 'package:darkstore/components/constants.dart';
import 'package:darkstore/view/auth/signin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../network/cachehelper.dart';

class BoardingModel {
  final String? image;
  final String? title;
  final String? body;

  BoardingModel(
      {@required this.image, @required this.title, @required this.body});
}

class OnboardingScreen extends StatefulWidget {
  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  var boardController = PageController();

  bool isLast = false;
  @override
  Widget build(BuildContext context) {
    List<BoardingModel> boarding = [
      BoardingModel(
        image: 'asset/image/cart.json',
        title: 'onboardingscreen1'.tr,
      ),
      BoardingModel(
        image: 'asset/image/cart1.json',
        title: 'onboardingscreen3'.tr,
      ),
      BoardingModel(
        image: 'asset/image/cart3.json',
        title: 'onboardingscreen3'.tr,
      ),
    ];
    return Scaffold(
        body: Stack(
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            Expanded(
                child: Container(
              color: defcolor,
            )),
            Expanded(
                child: Container(
              color: Colors.white,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SmoothPageIndicator(
                      controller: boardController,
                      count: boarding.length,
                      effect: ExpandingDotsEffect(
                          dotColor: Colors.grey,
                          dotHeight: 10,
                          expansionFactor: 4,
                          dotWidth: 10,
                          spacing: 5,
                          activeDotColor: defcolor),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: defbutton(
                          colors: Colors.white,
                          backgroundcolor: defcolor,
                          text: 'next',
                          tap: () {
                            if (!isLast) {
                              boardController.nextPage(
                                  duration: Duration(milliseconds: 750),
                                  curve: Curves.fastLinearToSlowEaseIn);
                            } else {
                              CacheHelper.saveData(
                                      key: "onboarding", value: true)
                                  .then((value) {
                                Get.off(SignInScreen());
                              });
                            }
                          }),
                    )
                  ],
                ),
              ),
            )),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
            ),
            height: 400,
            child: PageView.builder(
              physics: BouncingScrollPhysics(),
              controller: boardController,
              onPageChanged: (index) {
                if (index == boarding.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                } else {
                  setState(() {
                    isLast = false;
                  });
                }
              },
              itemBuilder: (context, index) =>
                  Center(child: buildboraditem(boarding[index])),
              itemCount: boarding.length,
            ),
          ),
        )
      ],
    ));
  }

  Widget buildboraditem(BoardingModel model) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(model.image!, width: 400),
          Expanded(
            child: Container(
                width: 240,
                child: Text(
                  model.title!,
                  style: GoogleFonts.cairo(
                      color: defcolor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                )),
          )
        ],
      );
}
