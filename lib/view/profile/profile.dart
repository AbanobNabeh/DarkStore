import 'package:darkstore/components/components.dart';
import 'package:darkstore/components/constants.dart';
import 'package:darkstore/controller/homecontroller.dart';
import 'package:darkstore/locale/LocaleController.dart';
import 'package:darkstore/model/modelprofile.dart';
import 'package:darkstore/view/favorite.dart';
import 'package:darkstore/view/support.dart';
import 'package:darkstore/view/widget/halfheart_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: defgraycolor,
        body: GetX<HomeController>(builder: (controller) {
          ModelProfile profile = controller.modelProfile!;
          return controller.isloading.value == true
              ? Center(
                  child: defcirculer(),
                )
              : SingleChildScrollView(
                  child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: defcolor,
                          borderRadius: const BorderRadiusDirectional.vertical(
                              bottom: Radius.circular(15))),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 25,
                            ),
                            Container(
                              width: 100,
                              height: 100,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage(profile.image!),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            defText(text: profile.name!),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    item(
                        icon: Halfheart.heart,
                        text: 'favorite',
                        ontap: () {
                          controller.getfavorite();
                          Get.to(() => FavoriteScreen());
                        }),
                    item(
                        icon: Halfheart.location,
                        text: 'myaddress',
                        ontap: () {
                          Get.bottomSheet(
                            backgroundColor: defcolor,
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 20, horizontal: 8),
                              child: Container(
                                height: 200,
                                child: ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                                color: Colors.black)),
                                        width: 200,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Align(
                                              alignment: AlignmentDirectional
                                                  .topCenter,
                                              child: InkWell(
                                                onTap: () {
                                                  Get.defaultDialog(
                                                    title: 'alert'.tr,
                                                    middleText: 'note'.tr,
                                                    textConfirm: 'delete'.tr,
                                                    onConfirm: () {
                                                      controller.removelocation(
                                                          value:
                                                              profile.location![
                                                                  index]);
                                                    },
                                                    confirmTextColor:
                                                        Colors.white,
                                                    buttonColor: Colors.red,
                                                    textCancel: 'cancel'.tr,
                                                  );
                                                },
                                                child: Icon(
                                                  Halfheart.trash,
                                                  color: Colors.red,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              child: Padding(
                                                  padding: EdgeInsets.all(8),
                                                  child: defText(
                                                      text:
                                                          "${profile.location![index]}",
                                                      size: 14,
                                                      color: Colors.black)),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                        width: 8,
                                      );
                                    },
                                    itemCount: profile.location!.length),
                              ),
                            ),
                          );
                        }),
                    item(
                        icon: Icons.language,
                        text: 'language',
                        widget: DropdownButton(
                          dropdownColor: defcolor,
                          items: ['english'.tr, 'arabic'.tr]
                              .map((e) => DropdownMenuItem(
                                    value: e,
                                    child: defText(
                                        text: e.toString(),
                                        color: Colors.white,
                                        size: 16),
                                  ))
                              .toList(),
                          onChanged: (value) {
                            if (value == 'arabic'.tr) {
                              Get.put(LocaleController()).changelang('ar');
                            } else {
                              Get.put(LocaleController()).changelang('en');
                            }
                          },
                          value: trans() == 'ar' ? 'arabic'.tr : 'english'.tr,
                        )),
                    item(
                        icon: Icons.support_agent,
                        text: 'support',
                        ontap: () => Get.to(() => SupportScreen())),
                    item(
                        icon: Icons.logout,
                        text: 'logout',
                        ontap: () {
                          Get.defaultDialog(
                              title: 'logout'.tr,
                              middleText: 'logoutmessage'.tr,
                              textConfirm: 'logout'.tr,
                              textCancel: 'cancel'.tr,
                              confirmTextColor: Colors.white,
                              buttonColor: Colors.red,
                              onConfirm: () => controller.logout());
                        }),
                  ],
                ));
        }));
  }
}

Widget item(
        {required IconData icon,
        required String text,
        Widget widget = const Icon(
          Icons.arrow_forward_ios_sharp,
          color: Colors.white,
        ),
        Function()? ontap}) =>
    InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        child: Container(
          width: double.infinity,
          height: 45,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: defcolor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Icon(
                  icon,
                  color: Colors.white,
                ),
                const SizedBox(
                  width: 8,
                ),
                defText(text: text, size: 18),
                Spacer(),
                widget
              ],
            ),
          ),
        ),
      ),
    );
