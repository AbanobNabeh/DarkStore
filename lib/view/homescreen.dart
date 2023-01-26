import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:darkstore/components/components.dart';
import 'package:darkstore/controller/categorycontroller.dart';
import 'package:darkstore/controller/homecontroller.dart';
import 'package:darkstore/controller/homescreencontroller.dart';
import 'package:darkstore/model/modelcategory.dart';
import 'package:darkstore/model/modelproduct.dart';
import 'package:darkstore/view/product/product.dart';
import 'package:darkstore/view/widget/halfheart_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lottie/lottie.dart';
import '../components/constants.dart';
import '../components/linkapi.dart';

class HomeScreen extends StatelessWidget {
  HomeScreenController controller = Get.put(HomeScreenController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor('333742'),
      body: GetX<HomeScreenController>(
        init: HomeScreenController(),
        builder: (controller) => controller.isloading.value == true
            ? Center(child: defcirculer())
            : SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CarouselSlider(
                          items: controller.banner.value
                              .map((e) => CachedNetworkImage(
                                    imageUrl: '$STORAGE${e.banner}',
                                    fit: BoxFit.fill,
                                    width: double.infinity,
                                    placeholder: (context, url) {
                                      return defcirculer();
                                    },
                                  ))
                              .toList(),
                          options: CarouselOptions(
                            height: 200,
                            initialPage: 0,
                            viewportFraction: 1,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            scrollDirection: Axis.horizontal,
                          )),
                      SizedBox(
                        height: 7,
                      ),
                      defText(text: 'categories', color: Colors.grey[600]!),
                      Container(
                        width: double.infinity,
                        height: 150,
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.category.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(
                                width: 8,
                              );
                            },
                            itemBuilder: (context, index) {
                              return categories(
                                  controller.category[index], context, index);
                            }),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      defText(text: 'products', color: Colors.grey[600]!),
                      SizedBox(
                        height: 7,
                      ),
                      AspectRatio(
                        aspectRatio: 1,
                        child: PageView.builder(
                          controller: controller.pageController,
                          itemCount: controller.product.length,
                          itemBuilder: (context, index) =>
                              product(controller.product[index], index),
                          physics: ClampingScrollPhysics(),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

Widget categories(ModelCategory categories, BuildContext context, int index) =>
    InkWell(
      onTap: () {
        Get.put(CategoryController())
            .getprocudt(categoryid: categories.id.toString());
        Get.put(CategoryController()).changeappbar(index);
        Get.put(HomeController()).controller!.index = 1;
      },
      child: Container(
        decoration: BoxDecoration(
            color: defgraycolor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.grey[600]!),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[800]!,
                spreadRadius: 2,
                offset: Offset(2, 2), // changes position of shadow
              ),
            ]),
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CachedNetworkImage(
                imageUrl: "${STORAGE}${categories.image}",
                width: 100,
                height: 100,
                placeholder: (context, url) {
                  return defcirculer();
                },
              ),
              Expanded(
                  child: GetBuilder<HomeScreenController>(
                builder: (controller) => defText(
                    text: trans() == 'ar'
                        ? categories.nameAr!
                        : categories.nameEn!,
                    size: 18,
                    color: Colors.white),
              ))
            ],
          ),
        ),
      ),
    );

Widget product(ModelProduct product, int index) {
  return GetBuilder<HomeScreenController>(
    builder: (controller) => AnimatedBuilder(
      animation: controller.pageController,
      builder: (context, child) {
        double value = 0.0;
        if (controller.pageController.position.haveDimensions) {
          value = index.toDouble() - (controller.pageController.page ?? 0);
        }
        return Transform.rotate(
          angle: pi * value,
          child: InkWell(
            onTap: () {
              Get.to(() => ProductScreen(product));
            },
            child: Container(
              decoration: BoxDecoration(
                  color: defgraycolor, borderRadius: BorderRadius.circular(8)),
              child: Column(children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        child: defText(
                            text: trans() == 'ar'
                                ? product.titleAr!
                                : product.titleEn!,
                            size: 16,
                            maxlines: 1,
                            color: Colors.white,
                            overflow: TextOverflow.ellipsis),
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          controller.addfav(product);
                        },
                        icon: product.myfavorite != true
                            ? Icon(
                                Halfheart.heart_empty,
                                color: Colors.white,
                              )
                            : Icon(
                                Halfheart.heart,
                                color: Colors.red,
                              ))
                  ],
                ),
                Expanded(
                    child: Hero(
                  tag: "${product.image!}${product.id!}",
                  child: CachedNetworkImage(
                    imageUrl: "${STORAGE}${product.image}",
                    fit: BoxFit.fill,
                  ),
                )),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      defprice(
                          discount: product.discount!,
                          price: product.price!,
                          finalprice:
                              "${controller.changepriceafterdic(product.discount!, product.price!)}"),
                      Spacer(),
                      starcont(text: product.rate!)
                    ],
                  ),
                ),
              ]),
            ),
          ),
        );
      },
    ),
  );
}
