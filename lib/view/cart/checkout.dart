import 'package:darkstore/components/components.dart';
import 'package:darkstore/components/constants.dart';
import 'package:darkstore/controller/checkoutcontroller.dart';
import 'package:darkstore/controller/homecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class CheckOutScreen extends StatelessWidget {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    List profile = Get.put(HomeController()).modelProfile!.location!;
    return Scaffold(
      appBar: AppBar(
        title: defText(text: 'completeyourpurchase'),
      ),
      bottomSheet: GetX<CheckOutController>(
        builder: (controller) => Container(
          width: double.infinity,
          color: defgraycolor,
          height: 60,
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: controller.isloading.value == true
                  ? Center(
                      child: defcirculer(),
                    )
                  : defbutton(
                      text: 'checkout',
                      tap: () {
                        if (formstate.currentState!.validate()) {
                          controller.getfirsttoken();
                        }
                      },
                      colors: Colors.white,
                      backgroundcolor: defcolor,
                      boxshade: false)),
        ),
      ),
      body: GetBuilder<CheckOutController>(
        init: CheckOutController(),
        builder: (controller) => SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Form(
              key: formstate,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IntlPhoneField(
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.next,
                    validator: (value) {
                      if (controller.phonenumber.text == null) {
                        return 'phonnumber'.tr;
                      }
                    },
                    controller: controller.phonenumber,
                    onCountryChanged: (value) {
                      controller.contrycode = "+${value.dialCode}";
                    },
                    decoration: InputDecoration(
                      hintText: 'phonnumber'.tr,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: defcolor,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide(
                          color: defcolor,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      fillColor: Colors.grey[350],
                      filled: true,
                    ),
                    initialCountryCode: 'EG',
                    onSubmitted: (value) {},
                    onChanged: (phone) {},
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 200,
                    child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          if (index == profile.length) {
                            return InkWell(
                              onTap: () {
                                controller.permissionloc();
                              },
                              child: Container(
                                width: 200,
                                height: 200,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: defText(
                                      text: 'addnewlocation',
                                      size: 14,
                                      color: Colors.black),
                                ),
                              ),
                            );
                          } else {
                            return InkWell(
                              onTap: () {
                                controller.changeindexlocation(index);
                              },
                              child: Container(
                                decoration: controller.indexlocation == index
                                    ? BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(color: Colors.black))
                                    : BoxDecoration(
                                        color: Colors.grey[300],
                                        border: Border.all(color: Colors.grey)),
                                width: 200,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    controller.indexlocation == index
                                        ? Align(
                                            alignment:
                                                AlignmentDirectional.topCenter,
                                            child: Container(
                                              width: 7,
                                              height: 7,
                                              decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: defcolor),
                                            ),
                                          )
                                        : SizedBox(
                                            height: 7,
                                          ),
                                    Expanded(
                                      child: Padding(
                                          padding: EdgeInsets.all(8),
                                          child: defText(
                                              text: "${profile[index]}",
                                              size: 14,
                                              color: Colors.black)),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 8,
                          );
                        },
                        itemCount: profile.length + 1),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    readOnly: controller.coupondis == 0 ? false : true,
                    controller: controller.couponcode,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        hintText: 'couponcode'.tr,
                        hintStyle: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: defcolor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8.0),
                          borderSide: BorderSide(
                            color: defcolor,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        fillColor: Colors.grey[350],
                        filled: true,
                        suffixIcon: controller.coupondis == 0
                            ? IconButton(
                                icon: Icon(
                                  Icons.check_box,
                                  color: Colors.blue,
                                ),
                                onPressed: () {
                                  controller.usecoupon();
                                },
                              )
                            : IconButton(
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  controller.removecoupon();
                                },
                              )),
                  ),
                  controller.coupondis == 0
                      ? controller.couponmessage == null
                          ? SizedBox(
                              width: 0,
                            )
                          : defText(
                              text: controller.couponmessage,
                              color: Colors.red,
                              size: 14)
                      : defText(
                          text:
                              "${'has been discount'.tr}${controller.coupondis}% ${'on your products'.tr}",
                          color: Colors.green,
                          size: 14),
                  defText(text: 'order details'),
                  Row(
                    children: [
                      defText(text: 'total price'),
                      Spacer(),
                      defText(text: controller.totalprice().toString())
                    ],
                  ),
                  Row(
                    children: [
                      defText(text: 'coupondiscount'),
                      Spacer(),
                      defText(text: "${controller.coupondis}%")
                    ],
                  ),
                  Row(
                    children: [
                      defText(text: 'discount percentage'),
                      Spacer(),
                      defText(
                          text: controller
                              .applaycoupon()['discountpercentage']
                              .toString())
                    ],
                  ),
                  Divider(
                    color: Colors.white,
                  ),
                  Row(
                    children: [
                      defText(text: 'the total'),
                      Spacer(),
                      defText(
                          text: controller.coupondis == 0
                              ? controller.totalprice().toString()
                              : controller
                                  .applaycoupon()['totalprice']
                                  .round()
                                  .toString())
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
