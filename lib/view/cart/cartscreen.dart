import 'package:cached_network_image/cached_network_image.dart';
import 'package:darkstore/components/components.dart';
import 'package:darkstore/components/constants.dart';
import 'package:darkstore/components/linkapi.dart';
import 'package:darkstore/controller/cartcontroller.dart';
import 'package:darkstore/model/modelcart.dart';
import 'package:darkstore/model/modelorder.dart';
import 'package:darkstore/view/widget/halfheart_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';

class CartScreen extends StatelessWidget {
  CartController controller = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetX<CartController>(
      builder: (controller) => controller.isloading.value == false
          ? controller.modelOrder == null
              ? controller.cart.isEmpty
                  ? Center(child: Lottie.asset('asset/image/empty_cart.json'))
                  : Column(
                      children: [
                        Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => productcart(
                                  controller.cart[index], controller),
                              itemCount: controller.cart.length,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: defbutton(
                              text: "completeyourpurchase",
                              tap: () {
                                controller.permissionloc();
                              },
                              boxshade: false),
                        ),
                        SizedBox(
                          height: 15,
                        )
                      ],
                    )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8),
                            child: ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => productorder(
                                  controller.modelOrder!, index, controller),
                              itemCount: controller.modelOrder!.cart!.length,
                            ),
                          ),
                        ),
                        orderstepper(controller.modelOrder!, controller),
                        defText(text: 'details', color: Colors.grey),
                        SizedBox(
                          height: 15,
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: defgraycolor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    defText(text: 'orderdate', size: 14),
                                    Spacer(),
                                    defText(
                                        text: DateFormat.yMd().format(
                                          DateTime.parse(controller
                                              .modelOrder!.createdAt!),
                                        ),
                                        size: 14),
                                  ],
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  children: [
                                    defText(text: 'name', size: 14),
                                    Spacer(),
                                    defText(
                                        text: controller.modelOrder!.nameUser!,
                                        size: 14),
                                  ],
                                ),
                                SizedBox(
                                  height: 9,
                                ),
                                Row(
                                  children: [
                                    defText(text: 'phonnumber', size: 14),
                                    Spacer(),
                                    defText(
                                        text:
                                            controller.modelOrder!.phonenumber!,
                                        size: 14),
                                  ],
                                ),
                                SizedBox(
                                  height: 9,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    defText(text: 'youraddress', size: 14),
                                    Spacer(),
                                    Container(
                                      constraints: BoxConstraints(
                                          minWidth: 60, maxWidth: 120),
                                      child: defText(
                                          text:
                                              controller.modelOrder!.location!,
                                          size: 14),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        )
                      ],
                    ),
                  ),
                )
          : Center(child: defcirculer()),
    ));
  }
}

Widget orderstepper(ModelOrder order, CartController controller) => Theme(
      data: ThemeData(
        colorScheme: ColorScheme.light(primary: defgraycolor),
      ),
      child: Stepper(
        physics: NeverScrollableScrollPhysics(),
        controlsBuilder: (context, details) => Container(),
        steps: [
          Step(
              title: defText(text: 'therequestisbeingreviewed', size: 16),
              content: defText(
                text: DateFormat.yMd().format(DateTime.parse(order.updatedAt!)),
              ),
              isActive: controller.currentStep() > 0 ? true : false,
              state: controller.currentStep() > 0
                  ? StepState.complete
                  : StepState.indexed),
          Step(
              title: defText(text: 'confirmation', size: 16),
              content: defText(
                text: DateFormat.yMd().format(DateTime.parse(order.updatedAt!)),
              ),
              isActive: controller.currentStep() > 1 ? true : false,
              state: controller.currentStep() > 1
                  ? StepState.complete
                  : StepState.indexed),
          Step(
              title: defText(text: 'outfordelivery', size: 16),
              content: defText(
                text: DateFormat.yMd().format(DateTime.parse(order.updatedAt!)),
              ),
              isActive: controller.currentStep() > 2 ? true : false,
              state: controller.currentStep() > 2
                  ? StepState.complete
                  : StepState.indexed),
          Step(
              title: defText(text: 'delivered', size: 16),
              content: defbutton(
                  text: "done",
                  tap: () {
                    controller.confirma();
                  },
                  boxshade: false),
              isActive: controller.currentStep() >= 3 ? true : false,
              state: controller.currentStep() >= 3
                  ? StepState.complete
                  : StepState.indexed),
        ],
        currentStep: controller.currentStep(),
      ),
    );

Widget productcart(ModelCart cart, CartController controller) {
  return InkWell(
    child: Card(
      color: defgraycolor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CachedNetworkImage(
              width: Get.width / 3,
              height: Get.height / 7,
              imageUrl: "${STORAGE}${cart.products!.image}",
              placeholder: (context, url) {
                return defcirculer();
              },
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: defText(
                        text: trans() == 'ar'
                            ? cart.products!.titleAr!
                            : cart.products!.titleEn!,
                        size: 14,
                        maxlines: 2,
                        color: Colors.white,
                        overflow: TextOverflow.ellipsis),
                  ),
                  defText(
                      text:
                          '${controller.changepriceafterdic(cart.products!.discount!, cart.products!.price!, cart.quantityCart!)}\$',
                      size: 16),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: defcolor),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          cart.quantityCart == 1
                              ? InkWell(
                                  onTap: () {
                                    controller.removecart(cart.idProduct!);
                                  },
                                  child: Icon(
                                    Halfheart.trash,
                                    color: Colors.red,
                                    size: 14,
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    controller.minuscart(cart.idProduct!);
                                  },
                                  child: Icon(
                                    Halfheart.minus,
                                    color: Colors.white,
                                    size: 14,
                                  ),
                                ),
                          SizedBox(
                            width: 4,
                          ),
                          defText(
                              text: cart.quantityCart!.toString(), size: 16),
                          SizedBox(
                            width: 4,
                          ),
                          InkWell(
                            onTap: cart.quantityCart! == 2
                                ? null
                                : () {
                                    controller.addcart(cart.idProduct!);
                                  },
                            child: Icon(
                              Halfheart.plus,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );
}

Widget productorder(ModelOrder order, int index, CartController controller) {
  return Card(
    color: defgraycolor,
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CachedNetworkImage(
            width: Get.width / 3,
            height: Get.height / 7,
            imageUrl: "${STORAGE}${order.cart![index].product![0].image}",
            placeholder: (context, url) {
              return defcirculer();
            },
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: defText(
                      text: trans() == "ar"
                          ? order.cart![index].product![0].titleAr!
                          : order.cart![index].product![0].titleEn!,
                      size: 14,
                      maxlines: 2,
                      color: Colors.white,
                      overflow: TextOverflow.ellipsis),
                ),
                defText(
                    text:
                        '${controller.changepriceafterdic(order.cart![index].product![0].discount!, order.cart![index].product![0].price!, order.cart![index].quantityCart!)}\$',
                    size: 16),
              ],
            ),
          )
        ],
      ),
    ),
  );
}
