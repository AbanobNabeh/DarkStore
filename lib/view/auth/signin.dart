import 'package:darkstore/components/components.dart';
import 'package:darkstore/controller/authcontroller.dart';
import 'package:darkstore/view/auth/singup.dart';
import 'package:darkstore/view/widget/halfheart_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rive/rive.dart';
import '../../components/constants.dart';

class SignInScreen extends StatelessWidget {
  AuthController controller = Get.put(AuthController());
  var formstate = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: defcolor,
      body: SingleChildScrollView(
        physics: NeverScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formstate,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: 200,
                  height: 200,
                  child: RiveAnimation.asset(
                    'asset/image/bear.riv',
                    fit: BoxFit.fill,
                    stateMachines: ['Login Machine'],
                    onInit: (artboard) => controller.facebaer(artboard),
                  ),
                ),
                Card(
                  margin: EdgeInsets.zero,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        defTextForm(
                            onchange: (value) {
                              controller.numlock!
                                  .change(value.length.toDouble());
                            },
                            focusNode: controller.emailnode,
                            controller: controller.emailcontroller,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'email'.tr;
                              }
                            },
                            prefixIcon: Halfheart.mail_alt,
                            hint: 'email'),
                        SizedBox(
                          height: 8,
                        ),
                        GetBuilder<AuthController>(
                          builder: (controller) => defTextForm(
                              obscureText: controller.obscureText,
                              focusNode: controller.passwordnode,
                              controller: controller.passwordcontroller,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'password'.tr;
                                }
                              },
                              prefixIcon: Halfheart.lock,
                              hint: 'password',
                              onchange: (value) {},
                              ontapSuff: () {
                                controller.showpassword();
                              },
                              suffixIcon: controller.eye),
                        ),
                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: TextButton(
                            onPressed: () {
                              Get.bottomSheet(
                                  Container(
                                    width: double.infinity,
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          defTextForm(
                                            hint: 'email',
                                            validator: (value) {
                                              if (value!.isEmpty) {
                                                return 'email'.tr;
                                              }
                                            },
                                            controller:
                                                controller.emailcontroller,
                                          ),
                                          SizedBox(
                                            height: 20,
                                          ),
                                          defbutton(
                                              text: 'send',
                                              tap: () {
                                                controller.forgotpassowrd();
                                              }),
                                          SizedBox(
                                            height: 20,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  backgroundColor: defcolor);
                            },
                            child: defText(
                                text: "forgotpw", size: 16, color: defcolor),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                GetX<AuthController>(
                    builder: (controller) => controller.isloading.value == true
                        ? defcirculer()
                        : defbutton(
                            text: 'login',
                            tap: () {
                              if (formstate.currentState!.validate()) {
                                controller.signin();
                              } else {
                                controller.faill!.change(true);
                              }
                            },
                          )),
                SizedBox(
                  height: 25,
                ),
                defText(
                  text: "createaccount",
                  size: 22,
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.to(() => SignUpScreen());
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        child: Icon(
                          Halfheart.mail,
                          color: defcolor,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    InkWell(
                      onTap: () {
                        controller.googlesignin();
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        child: Icon(
                          Halfheart.google,
                          color: defcolor,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    InkWell(
                      onTap: () {
                        controller.facebooksignin();
                      },
                      child: Container(
                        width: 50,
                        height: 50,
                        child: Icon(
                          Halfheart.facebook,
                          color: defcolor,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    ;
  }
}
