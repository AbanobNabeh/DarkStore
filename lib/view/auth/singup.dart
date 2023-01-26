import 'package:darkstore/components/components.dart';
import 'package:darkstore/controller/authcontroller.dart';
import 'package:darkstore/view/widget/halfheart_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../components/constants.dart';

class SignUpScreen extends StatelessWidget {
  AuthController controller = Get.put(AuthController());
  var formstate = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: defcolor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: formstate,
            child: Column(
              children: [
                defText(text: 'welcometo', size: 22),
                SizedBox(
                  height: 7,
                ),
                InkWell(
                  onTap: () {
                    controller.permissionstorage();
                  },
                  child: GetBuilder<AuthController>(
                    builder: (controller) => Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          image: controller.image == null
                              ? null
                              : DecorationImage(
                                  image: FileImage(controller.image!),
                                  fit: BoxFit.fill)),
                      child: controller.image != null
                          ? null
                          : Center(
                              child: defText(
                                  text: 'selectimage',
                                  size: 14,
                                  color: defcolor)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        defTextForm(
                          prefixIcon: Halfheart.user,
                          textInputAction: TextInputAction.next,
                          textInputType: TextInputType.name,
                          hint: 'name',
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'name'.tr;
                            }
                          },
                          controller: controller.name,
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        defTextForm(
                            prefixIcon: Halfheart.mail_alt,
                            textInputAction: TextInputAction.next,
                            textInputType: TextInputType.emailAddress,
                            hint: 'email',
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'email';
                              }
                            },
                            controller: controller.emailcontroller),
                        SizedBox(
                          height: 15,
                        ),
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
                            controller.country = "+${value.dialCode}";
                          },
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
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
                        GetBuilder<AuthController>(
                          builder: (controller) => defTextForm(
                              textInputAction: TextInputAction.go,
                              textInputType: TextInputType.visiblePassword,
                              hint: 'password',
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'password'.tr;
                                } else if (value.length < 8) {
                                  return 'passwordmust'.tr;
                                }
                              },
                              controller: controller.passwordcontroller,
                              prefixIcon: Halfheart.lock,
                              obscureText: controller.obscureText,
                              suffixIcon: controller.eye,
                              ontapSuff: () {
                                controller.showpassword();
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                GetX<AuthController>(
                  builder: (controller) => controller.isloading.value == true
                      ? defcirculer()
                      : defbutton(
                          text: 'createaccount',
                          tap: () {
                            if (controller.image == null) {
                              Get.snackbar('erroroccurred'.tr, 'selectimage'.tr,
                                  backgroundColor: Colors.red,
                                  colorText: Colors.white,
                                  snackPosition: SnackPosition.BOTTOM);
                            } else {
                              if (formstate.currentState!.validate()) {
                                controller.uploadimage();
                              }
                            }
                          }),
                ),
                SizedBox(
                  height: 5,
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: defText(text: 'back'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
