import 'package:cached_network_image/cached_network_image.dart';
import 'package:darkstore/components/components.dart';
import 'package:darkstore/components/constants.dart';
import 'package:darkstore/components/linkapi.dart';
import 'package:darkstore/controller/productcontroller.dart';
import 'package:darkstore/model/modelproduct.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import '../widget/halfheart_icons.dart';

class ProductScreen extends StatelessWidget {
  ModelProduct product;
  ProductScreen(this.product, {super.key});
  ProductController controller = Get.put(ProductController());
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: defgraycolor,
      appBar: AppBar(
        title: defText(
            text: trans() == 'ar' ? product.titleAr! : product.titleEn!),
      ),
      bottomSheet: Container(
        width: double.infinity,
        color: defgraycolor,
        child: GetBuilder<ProductController>(
          builder: (controller) => Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
                color: defcolor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(8))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      controller.addfav(product);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: defgraycolor,
                      ),
                      child: Padding(
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
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: product.active == 0 || product.quantity == 0
                          ? null
                          : () {
                              controller.addcart(product.id!);
                            },
                      child: Container(
                        width: double.infinity,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: defgraycolor,
                        ),
                        child: product.active == 0 || product.quantity == 0
                            ? Center(
                                child: defText(
                                    text: 'outstock', color: Colors.red),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.add_shopping_cart_outlined,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  defText(
                                    text: 'addtocart',
                                  )
                                ],
                              ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: defcolor,
                  borderRadius:
                      BorderRadius.vertical(bottom: Radius.circular(40))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: "${product.image!}${product.id!}",
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: CachedNetworkImage(
                        width: MediaQuery.of(context).size.width / 1.8,
                        imageUrl: "$STORAGE${product.image}",
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                children: [
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
                      Spacer(),
                      product.discount == 0
                          ? SizedBox(
                              width: 0,
                            )
                          : starcont(
                              text: product.discount.toString(),
                              widget: defText(text: '% ', color: Colors.red)),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    child: defText(
                        text: trans() == 'ar'
                            ? product.descriptionAr!
                            : product.descriptionEn!,
                        size: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      starcont(text: product.rate!),
                      Spacer(),
                      product.myrate == true
                          ? SizedBox(
                              width: 0,
                            )
                          : TextButton(
                              onPressed: () {
                                Get.defaultDialog(
                                    onCancel: () {
                                      Get.off(ProductScreen(product));
                                    },
                                    title: 'addreview'.tr,
                                    content: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          RatingBar.builder(
                                            initialRating: 0.5,
                                            minRating: 0.5,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding: EdgeInsets.symmetric(
                                                horizontal: 4.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              controller.rate = rating;
                                            },
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          Form(
                                            key: formstate,
                                            child: defTextForm(
                                                controller: controller.comment,
                                                validator: (value) {
                                                  if (value!.isEmpty) {
                                                    return "comment".tr;
                                                  }
                                                },
                                                hint: "comment"),
                                          )
                                        ],
                                      ),
                                    ),
                                    textCancel: 'cancel'.tr,
                                    textConfirm: 'send'.tr,
                                    confirmTextColor: Colors.white,
                                    onConfirm: () {
                                      if (formstate.currentState!.validate()) {
                                        controller.addrate(product);
                                      }
                                    });
                              },
                              child: defText(text: 'addreview', size: 12),
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(defcolor)),
                            )
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Divider(color: Colors.white, thickness: 1),
                  Container(
                    width: double.infinity,
                    child: ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return review(product.reviews![index]);
                        },
                        separatorBuilder: (context, index) => SizedBox(
                              height: 0,
                            ),
                        itemCount: product.reviews!.length),
                  ),
                  SizedBox(
                    height: 60,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget review(Reviews review) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              radius: 25,
              backgroundColor: defcolor,
              backgroundImage: NetworkImage(review.imageUser!),
            ),
            SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                defText(text: review.nameUser!, size: 18),
                RatingBarIndicator(
                  rating: double.parse(review.review!),
                  itemBuilder: (context, index) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  itemCount: 5,
                  itemSize: 18.0,
                  direction: Axis.horizontal,
                ),
                defText(text: review.comment!, size: 16)
              ],
            ),
          ],
        ),
      ],
    );
