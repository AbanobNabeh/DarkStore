import 'package:cached_network_image/cached_network_image.dart';
import 'package:darkstore/components/components.dart';
import 'package:darkstore/components/constants.dart';
import 'package:darkstore/components/linkapi.dart';
import 'package:darkstore/controller/homecontroller.dart';
import 'package:darkstore/model/modelproduct.dart';
import 'package:darkstore/view/product/product.dart';
import 'package:darkstore/view/widget/halfheart_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GetBuilder<HomeController>(
                builder: (controller) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: defTextForm(
                      textdirection: trans() == 'ar'
                          ? TextDirection.rtl
                          : TextDirection.ltr,
                      controller: TextEditingController(),
                      validator: (value) {},
                      hint: 'search',
                      onchange: (value) {
                        controller.search(searchcase: value);
                      },
                      suffixIcon: Halfheart.search),
                ),
              ),
              GetX<HomeController>(
                builder: (controller) {
                  return controller.isloading.value == false
                      ? Container(
                          width: double.infinity,
                          child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => listsearch(
                                  controller.searchproduct[index], controller),
                              itemCount: controller.searchproduct.length),
                        )
                      : defcirculer();
                },
              )
            ],
          ),
        ));
  }
}

Widget listsearch(ModelProduct product, HomeController controller) {
  return InkWell(
    onTap: () => Get.to(() => ProductScreen(product)),
    child: Card(
      color: defgraycolor,
      child: Row(
        children: [
          Hero(
            tag: "${product.image!}${product.id!}",
            child: CachedNetworkImage(
              imageUrl: "$STORAGE${product.image}",
              width: Get.width / 3.5,
              placeholder: (context, url) {
                return defcirculer();
              },
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: defText(
                      text:
                          trans() == 'ar' ? product.titleAr! : product.titleEn!,
                      size: 14,
                      maxlines: 2,
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    product.discount == 0
                        ? defText(text: "${product.price}\$")
                        : Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              defText(
                                text:
                                    "${controller.changepriceafterdic(product.discount!, product.price!)}\$",
                              ),
                              defText(
                                  text: "${product.price}\$",
                                  color: Colors.red,
                                  decoration: TextDecoration.lineThrough,
                                  size: 12),
                            ],
                          ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.25),
                      borderRadius: BorderRadius.circular(8)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Halfheart.star,
                          color: Colors.yellow,
                        ),
                        defText(text: product.rate!, size: 18),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.all(8.0),
              child: product.myfavorite == true
                  ? Icon(
                      Halfheart.heart,
                      color: Colors.red,
                    )
                  : Icon(
                      Halfheart.heart,
                      color: Colors.white,
                    )),
        ],
      ),
    ),
  );
}
