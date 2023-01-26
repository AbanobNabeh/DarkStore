import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darkstore/components/constants.dart';
import 'package:darkstore/controller/homescreencontroller.dart';
import 'package:darkstore/model/modelfavorite.dart';
import 'package:darkstore/model/modelproduct.dart';
import 'package:darkstore/model/modelprofile.dart';
import 'package:darkstore/network/cachehelper.dart';
import 'package:darkstore/network/dioapp.dart';
import 'package:darkstore/view/auth/signin.dart';
import 'package:darkstore/view/cart/cartscreen.dart';
import 'package:darkstore/view/category/category.dart';
import 'package:darkstore/view/homescreen.dart';
import 'package:darkstore/view/profile/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../components/linkapi.dart';

class HomeController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController message = TextEditingController();
  RxBool isloading = false.obs;
  PersistentTabController? controller;
  List<Widget> screen = [
    HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    ProfileScreen()
  ];

  @override
  void onInit() {
    controller = PersistentTabController(initialIndex: 0);
    profile();
    super.onInit();
  }

  ModelProfile? modelProfile;
  void profile() {
    isloading.value = true;
    FirebaseFirestore.instance.collection('users').doc(id).get().then((value) {
      modelProfile = ModelProfile.fromJson(value.data()!);
      isloading.value = false;
    });
  }

  int changepriceafterdic(int discount, int price) {
    int i = price * discount ~/ 100;
    int b = price - i;
    return b;
  }

  List<ModelProduct> searchproduct = [];
  void search({required String searchcase}) {
    isloading.value = true;
    searchproduct = [];
    DioApp.postData(url: SEARCH, data: {"title": searchcase, 'id': id})
        .then((value) {
      value.data.forEach((element) {
        searchproduct.add(ModelProduct.fromJson(element));
      });
      isloading.value = false;
    });
  }

  List<ModelFavorite> myfav = [];
  void getfavorite() {
    isloading.value = true;
    myfav = [];
    DioApp.postData(url: GETFAV, data: {'id_fav_user': id}).then((value) {
      value.data.forEach((element) {
        myfav.add(ModelFavorite.fromJson(element));
      });
      isloading.value = false;
    });
  }

  void removefav(String favid) {
    DioApp.postData(url: REMOVEFAV, data: {
      "id_fav_product": favid,
      "id_fav_user": id,
    }).then((value) {
      Get.put(HomeScreenController()).getprocudt();
      getfavorite();
    });
  }

  void removelocation({required String value}) {
    FirebaseFirestore.instance.collection("users").doc(id).update({
      'location': FieldValue.arrayRemove([value]),
    }).then((value) {
      profile();
      Timer(Duration(seconds: 1), () {
        Get.back();
        Get.back();
      });
    });
  }

  void logout() {
    FirebaseAuth.instance.signOut();
    FacebookAuth.instance.logOut();
    CacheHelper.removeData(key: 'id').then((value) {
      id = null;
      Get.offAll(() => SignInScreen());
    });
  }

  void sendmessagesupport({String? imagee}) {
    isloading.value = true;
    FirebaseFirestore.instance.collection('support').add({
      'idsender': id,
      'image': imagee == null ? null : imagee,
      'message': message.text,
      'date': DateTime.now(),
      'seen': false
    }).then((value) {
      FirebaseFirestore.instance
          .collection('support')
          .doc(value.id)
          .update({'id': value.id});
      isloading.value = false;
      Get.back();
      Get.snackbar('support'.tr, "problemmessage".tr,
          backgroundColor: defcolor, colorText: Colors.white);
      message.text = "";
      image = null;
    });
  }

  permissionstorage() {
    Permission.storage.request().then((status) {
      if (status.isPermanentlyDenied) {
        openAppSettings();
      } else if (status.isGranted) {
        selectImage();
      }
    });
  }

  File? image;
  final ImagePicker pickerimage = ImagePicker();
  Future<void> selectImage() async {
    final cover = await pickerimage.pickImage(source: ImageSource.gallery);
    if (cover != null) {
      image = File(cover.path);
      update();
    } else {
      update();
    }
  }

  uploadimage() {
    isloading.value = true;
    FirebaseStorage.instance
        .ref("users")
        .child(
            "${modelProfile!.email}/${Uri.file(image!.path).pathSegments.last}")
        .putFile(image!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        sendmessagesupport(imagee: value);
      });
    }).catchError((error) {
      isloading.value = false;
    });
  }

  void removeimage() {
    image = null;
    update();
  }
}
