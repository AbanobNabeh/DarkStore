import 'package:darkstore/components/components.dart';
import 'package:darkstore/components/constants.dart';
import 'package:darkstore/controller/cartcontroller.dart';
import 'package:darkstore/controller/categorycontroller.dart';
import 'package:darkstore/controller/homecontroller.dart';
import 'package:darkstore/controller/homescreencontroller.dart';
import 'package:darkstore/view/search.dart';
import 'package:darkstore/view/widget/halfheart_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: defText(
          text: 'appname'.tr,
        ),
        actions: [
          IconButton(
              onPressed: () => Get.to(() => SearchScreen()),
              icon: Icon(Halfheart.search))
        ],
      ),
      body: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (controller) => PersistentTabView(
          context,
          screens: controller.screen,
          items: [
            item(
              text: 'home',
              icon: Icon(Halfheart.home),
            ),
            item(
              text: 'categories',
              icon: Icon(Icons.category),
            ),
            item(
              text: 'cart',
              icon: Icon(Icons.shopping_cart),
            ),
            item(
              text: 'profile',
              icon: Icon(Halfheart.user),
            ),
          ],
          confineInSafeArea: true,
          backgroundColor: defgraycolor,
          handleAndroidBackButtonPress: true,
          resizeToAvoidBottomInset: true,
          stateManagement: true,
          controller: controller.controller,
          hideNavigationBarWhenKeyboardShows: true,
          popAllScreensOnTapOfSelectedTab: true,
          popActionScreens: PopActionScreensType.all,
          onItemSelected: (value) {
            if (value == 1) {
              Get.put(CategoryController()).getprocudt(categoryid: '1');
              Get.put(CategoryController()).changeappbar(0);
            } else if (value == 2) {
              Get.put(CartController()).getorders();
              Get.put(CartController()).getcart();
            } else if (value == 0) {
              Get.put(HomeScreenController()).getprocudt();
            }
          },
          decoration: NavBarDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
          ),
          itemAnimationProperties: ItemAnimationProperties(
            duration: Duration(milliseconds: 200),
            curve: Curves.ease,
          ),
          screenTransitionAnimation: ScreenTransitionAnimation(
            // Screen transition animation on change of selected tab.
            animateTabTransition: true,
            curve: Curves.ease,
            duration: Duration(milliseconds: 200),
          ),
          navBarStyle: NavBarStyle.style10,
        ),
      ),
    );
  }
}

PersistentBottomNavBarItem item({
  required String text,
  required Icon icon,
}) =>
    PersistentBottomNavBarItem(
      activeColorPrimary: HexColor('333742'),
      inactiveColorPrimary: CupertinoColors.systemGrey,
      icon: icon,
      title: (text.tr),
      activeColorSecondary: Colors.white,
    );
