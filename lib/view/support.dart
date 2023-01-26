import 'package:darkstore/components/components.dart';
import 'package:darkstore/components/constants.dart';
import 'package:darkstore/controller/homecontroller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SupportScreen extends StatelessWidget {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: defText(text: 'support'.tr),
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) => SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formstate,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'problem'.tr;
                      }
                    },
                    controller: controller.message,
                    maxLines: 7,
                    decoration: InputDecoration(
                      hintText: 'problem'.tr,
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
                    )),
                SizedBox(
                  height: 7,
                ),
                controller.image != null
                    ? SizedBox(
                        width: 0,
                      )
                    : TextButton(
                        onPressed: () {
                          controller.permissionstorage();
                        },
                        child: defText(text: 'selectimage')),
                controller.image == null
                    ? SizedBox(
                        width: 0,
                      )
                    : Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(controller.image!))),
                        child: InkWell(onTap: () => controller.removeimage()),
                      ),
                SizedBox(
                  height: 7,
                ),
                GetX<HomeController>(
                    builder: (controller) => controller.isloading.value == true
                        ? Center(
                            child: defcirculer(),
                          )
                        : defbutton(
                            text: 'send',
                            tap: () {
                              if (formstate.currentState!.validate()) {
                                if (controller.image == null) {
                                  controller.sendmessagesupport();
                                } else {
                                  controller.uploadimage();
                                }
                              }
                            },
                            boxshade: false))
              ],
            ),
          ),
        )),
      ),
    );
  }
}
