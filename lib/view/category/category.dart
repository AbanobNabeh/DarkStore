import 'package:cached_network_image/cached_network_image.dart';
import 'package:darkstore/components/components.dart';
import 'package:darkstore/components/constants.dart';
import 'package:darkstore/components/linkapi.dart';
import 'package:darkstore/controller/categorycontroller.dart';
import 'package:darkstore/model/modelcategory.dart';
import 'package:darkstore/model/modelproduct.dart';
import 'package:darkstore/view/product/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../widget/halfheart_icons.dart';

class CategoryScreen extends StatelessWidget {
  CategoryController controller = Get.put(CategoryController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: DefaultTabController(
          length: 7,
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Column(
              children: [
                GetBuilder<CategoryController>(
                  builder: (controller) => Container(
                    width: double.infinity,
                    color: defcolor,
                    height: 70,
                    child: ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.category.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            tabbar(index, controller.category[index]),
                            Visibility(
                              visible: controller.currentindex == index,
                              child: Container(
                                width: 5,
                                height: 5,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    shape: BoxShape.circle),
                              ),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                GetX<CategoryController>(
                  builder: (controller) {
                    return Container(
                      width: double.infinity,
                      child: controller.isloading.value == true
                          ? Center(child: defcirculer())
                          : GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: MediaQuery.of(context)
                                              .size
                                              .width /
                                          (MediaQuery.of(context).size.height /
                                              1.3),
                                      crossAxisSpacing: 6,
                                      crossAxisCount: 2,
                                      mainAxisSpacing: 6),
                              itemBuilder: (context, index) {
                                return product(controller.product[index]);
                              },
                              itemCount: controller.product.length),
                    );
                  },
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget tabbar(index, ModelCategory categories) =>
    GetBuilder<CategoryController>(
      builder: (controller) => GestureDetector(
        onTap: () {
          controller.changeappbar(index);
          controller.getprocudt(categoryid: categories.id!.toString());
        },
        child: AnimatedContainer(
          margin: EdgeInsets.all(8),
          constraints: BoxConstraints(minWidth: 80, maxWidth: 100),
          height: 45,
          decoration: BoxDecoration(
              color: controller.currentindex == index
                  ? Colors.white70
                  : Colors.white54,
              borderRadius: controller.currentindex == index
                  ? BorderRadius.circular(15)
                  : BorderRadius.circular(8),
              border: controller.currentindex == index
                  ? Border.all(color: Colors.white)
                  : null),
          duration: Duration(milliseconds: 300),
          child: Center(
              child: defText(
                  text:
                      trans() == 'ar' ? categories.nameAr! : categories.nameEn!,
                  size: 14,
                  color: Colors.white)),
        ),
      ),
    );

Widget product(ModelProduct product) {
  return GetBuilder<CategoryController>(
    builder: (controller) => InkWell(
      onTap: () {
        Get.to(() => ProductScreen(product));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(colors: [
            HexColor('FFFFFF').withOpacity(0),
            HexColor('F4F5F8').withOpacity(0.3),
          ], begin: FractionalOffset(1, 0.0)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        defText(
                            text: product.rate!, size: 14, color: Colors.white),
                        Icon(
                          Halfheart.star,
                          color: Colors.yellow,
                          size: 16,
                        ),
                      ],
                    ),
                  ),
                ),
                Spacer(),
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
                          )),
              ],
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Hero(
                  tag: "${product.image!}${product.id!}",
                  child: CachedNetworkImage(
                    imageUrl: "${STORAGE}${product.image}",
                  ),
                ),
              ),
            ),
            Container(
              child: defText(
                  text: trans() == 'ar' ? product.titleAr! : product.titleEn!,
                  size: 14,
                  maxlines: 1,
                  color: Colors.white,
                  overflow: TextOverflow.ellipsis),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: product.discount == 0
                        ? defText(
                            text: "${product.price} \$",
                            size: 16,
                            color: Colors.white)
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              defText(
                                text:
                                    "${controller.changepriceafterdic(product.discount!, product.price!)} \$",
                                size: 16,
                                color: Colors.white,
                              ),
                              defText(
                                text: "${product.price}",
                                decoration: TextDecoration.lineThrough,
                                size: 12,
                                color: Colors.red,
                              )
                            ],
                          ),
                  ),
                ),
                Spacer(),
                product.quantity == 0 || product.active == 0
                    ? defText(text: 'outstock', color: Colors.red, size: 14)
                    : SizedBox(
                        width: 0,
                      )
              ],
            )
          ]),
        ),
      ),
    ),
  );
}
