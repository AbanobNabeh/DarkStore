import 'package:cached_network_image/cached_network_image.dart';
import 'package:darkstore/View/widget/halfheart_icons.dart';
import 'package:darkstore/components/components.dart';
import 'package:darkstore/controller/homecontroller.dart';
import 'package:darkstore/model/modelfavorite.dart';
import 'package:darkstore/view/product/product.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../components/constants.dart';
import '../components/linkapi.dart';

class FavoriteScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetX<HomeController>(builder: (controller) {
      return Scaffold(
        appBar: AppBar(
          title: defText(text: 'favorite'),
        ),
        body: controller.isloading.value == true
            ? Center(
                child: defcirculer(),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  Products product = controller.myfav[index].products!;
                  return Card(
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
                                    text: trans() == 'ar'
                                        ? product.titleAr!
                                        : product.titleEn!,
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
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            defText(
                                              text:
                                                  "${controller.changepriceafterdic(product.discount!, product.price!)}\$",
                                            ),
                                            defText(
                                                text: "${product.price}\$",
                                                color: Colors.red,
                                                decoration:
                                                    TextDecoration.lineThrough,
                                                size: 12),
                                          ],
                                        ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                            padding: EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () =>
                                  controller.removefav(product.id.toString()),
                              child: Icon(
                                Halfheart.heart,
                                color: Colors.red,
                              ),
                            )),
                      ],
                    ),
                  );
                },
                itemCount: controller.myfav.length,
              ),
      );
    });
  }
}
