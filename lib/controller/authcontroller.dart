import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darkstore/components/constants.dart';
import 'package:darkstore/model/modelprofile.dart';
import 'package:darkstore/network/cachehelper.dart';
import 'package:darkstore/homepage.dart';
import 'package:darkstore/view/homescreen.dart';
import 'package:darkstore/view/widget/halfheart_icons.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:rive/rive.dart';

class AuthController extends GetxController {
  @override
  void onInit() {
    emailnode.addListener(emailfouse);
    passwordnode.addListener(passwordfouse);
    super.onInit();
  }

  @override
  void dispose() {
    emailnode.removeListener(emailfouse);
    passwordnode.removeListener(passwordfouse);
    super.dispose();
  }

  var FIREUSER = FirebaseFirestore.instance.collection('users');
  StateMachineController? controller;
  SMIInput<bool>? ischeck;
  SMIInput<double>? numlock;
  SMIInput<bool>? ishandsup;
  SMIInput<bool>? sucess;
  SMIInput<bool>? faill;
  TextEditingController emailcontroller = TextEditingController();
  FocusNode emailnode = FocusNode();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController phonenumber = TextEditingController();
  TextEditingController name = TextEditingController();
  String country = "+20";
  FocusNode passwordnode = FocusNode();
  bool obscureText = true;
  IconData eye = Halfheart.eye_off;
  RxBool isloading = false.obs;
  showpassword() {
    obscureText = !obscureText;
    obscureText == true ? eye = Halfheart.eye_off : eye = Halfheart.eye;
    update();
  }

  facebaer(Artboard artboard) {
    controller = StateMachineController.fromArtboard(artboard, 'Login Machine');
    if (controller == null) return;
    artboard.addController(controller!);
    ischeck = controller!.findInput('isChecking');
    numlock = controller!.findInput('numLook');
    ishandsup = controller!.findInput('isHandsUp');
    sucess = controller!.findInput('trigSuccess');
    faill = controller!.findInput('trigFail');
  }

  void emailfouse() {
    ischeck!.change(emailnode.hasFocus);
  }

  void passwordfouse() {
    ishandsup!.change(passwordnode.hasFocus);
  }

  ModelProfile? modelProfile;
  void googlesignin() async {
    isloading.value = true;
    final GoogleSignInAccount? googleuser =
        await GoogleSignIn(scopes: <String>['email']).signIn();
    final GoogleSignInAuthentication googleauth =
        await googleuser!.authentication;
    final Credential = GoogleAuthProvider.credential(
        accessToken: googleauth.accessToken, idToken: googleauth.idToken);
    return await FirebaseAuth.instance
        .signInWithCredential(Credential)
        .then((data) {
      FIREUSER.where("email", isEqualTo: data.user!.email).get().then((value) {
        modelProfile = ModelProfile(
          email: data.user!.email,
          image: data.user!.photoURL,
          location: [],
          name: data.user!.displayName,
          password: '0',
          phonenumber: data.user!.phoneNumber,
          uid: data.user!.uid,
          verify: false,
        );
        if (value.docs.isEmpty) {
          FIREUSER.doc(data.user!.uid).set(modelProfile!.toMap()).then((value) {
            id = modelProfile!.uid;
            CacheHelper.saveData(key: "id", value: modelProfile!.uid)
                .then((value) {
              Get.off(HomePage());
              isloading.value = false;
            });
          });
        } else {
          id = modelProfile!.uid;
          CacheHelper.saveData(key: "id", value: modelProfile!.uid)
              .then((value) {
            Get.off(HomePage());
            isloading.value = false;
          });
        }
      });
    }).catchError((error) {
      isloading.value = false;
    });
  }

  void facebooksignin() async {
    isloading.value = true;
    final LoginResult result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
      final userData = await FacebookAuth.instance.getUserData();
      print("$userData +++++++++");
      FIREUSER.where("email", isEqualTo: userData['email']).get().then((value) {
        if (value.docs.isEmpty) {
          modelProfile = ModelProfile(
            email: userData['email'],
            image: userData['picture']['data']['url'],
            location: [],
            name: userData['name'],
            password: '0',
            phonenumber: userData['phonenumber'],
            uid: userData['id'],
            verify: false,
          );
          FIREUSER.doc(userData['id']).set(modelProfile!.toMap()).then((value) {
            id = modelProfile!.uid;
            CacheHelper.saveData(key: "id", value: modelProfile!.uid)
                .then((value) {
              Get.off(HomePage());
              isloading.value = false;
            });
          });
        } else {
          id = userData['id'];
          CacheHelper.saveData(key: "id", value: userData['id']).then((value) {
            Get.off(HomePage());
            isloading.value = false;
          });
        }
      });
    } else {
      print(result.message);
      isloading.value = false;
    }
  }

  void signup({String? image}) async {
    isloading.value = true;
    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailcontroller.text, password: passwordcontroller.text)
        .then((value) {
      modelProfile = ModelProfile(
          email: emailcontroller.text,
          image: image,
          location: [],
          name: name.text,
          password: passwordcontroller.text,
          phonenumber: "${country}${phonenumber.text}",
          uid: value.user!.uid,
          verify: false);
      FIREUSER.doc(value.user!.uid).set(modelProfile!.toMap()).then((value) {
        id = modelProfile!.uid;
        CacheHelper.saveData(key: "id", value: modelProfile!.uid).then((value) {
          Get.off(HomePage());
          isloading.value = false;
        });
      });
    }).catchError((error) {
      handelerror(error);
      isloading.value = false;
    });
  }

  void signin() async {
    isloading.value = true;
    ishandsup!.change(false);
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: emailcontroller.text, password: passwordcontroller.text)
        .then((value) {
      sucess!.change(true);
      Timer(Duration(seconds: 2), () {
        id = value.user!.uid;
        CacheHelper.saveData(key: "id", value: value.user!.uid).then((value) {
          Get.off(HomePage());
        });
      });
    }).catchError((error) {
      faill!.change(true);
      isloading.value = false;
      handelerror(error);
    });
  }

  forgotpassowrd() {
    FirebaseAuth.instance
        .sendPasswordResetEmail(email: emailcontroller.text)
        .then((value) {
      Get.back();
      Get.snackbar('succeeded'.tr, "${'sendemail'.tr} ${emailcontroller.text}",
          backgroundColor: Color.fromRGBO(76, 175, 80, 1),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }).catchError((error) {
      handelerror(error);
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
            "${emailcontroller.text}/${Uri.file(image!.path).pathSegments.last}")
        .putFile(image!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        signup(image: value);
      });
    }).catchError((error) {
      isloading.value = false;
    });
  }
}
