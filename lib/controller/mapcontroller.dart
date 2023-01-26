import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:darkstore/components/constants.dart';
import 'package:darkstore/controller/homecontroller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:geocoding/geocoding.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapController extends GetxController {
  RxBool isloading = false.obs;
  late LatLng latLng;
  String? loctioninfo;
  Set<Marker> createMarker() {
    return {
      Marker(
        markerId: MarkerId("1"),
        position: latLng,
      ),
    };
  }

  @override
  void onInit() {
    getlatandlong();
    super.onInit();
  }

  void getlatandlong() {
    isloading.value = true;
    Geolocator.getCurrentPosition().then((value) {
      latLng = LatLng(value.latitude, value.longitude);

      convertlatlong();
      isloading.value = false;

      update();
    });
  }

  void convertlatlong() {
    placemarkFromCoordinates(latLng.latitude, latLng.longitude).then((value) {
      loctioninfo =
          "${value[0].street}\n${value[0].subAdministrativeArea}\n${value[0].administrativeArea}\n${value[0].country}";
    });
  }

  void changemarker({required LatLng argument}) {
    latLng = argument;
    convertlatlong();
    update();
  }

  void uploadlocation() {
    FirebaseFirestore.instance.collection('users').doc(id).update({
      "location": FieldValue.arrayUnion([loctioninfo])
    }).then((value) {
      Get.put(HomeController()).profile();
      Timer(Duration(seconds: 1), () {
        Get.offNamed('checkout');
      });
    });
  }
}
