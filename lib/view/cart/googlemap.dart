import 'package:darkstore/View/widget/halfheart_icons.dart';
import 'package:darkstore/components/components.dart';
import 'package:darkstore/components/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../controller/mapcontroller.dart';

class GoogleMapScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MapController>(
      init: MapController(),
      builder: (controller) => Scaffold(
        appBar: AppBar(
          title: defText(text: 'completeyourpurchase'),
          actions: [
            IconButton(
                onPressed: () {
                  Get.defaultDialog(
                      onConfirm: () {
                        controller.uploadlocation();
                      },
                      title: 'youraddress'.tr,
                      textCancel: 'changed'.tr,
                      textConfirm: 'done'.tr,
                      confirmTextColor: Colors.white,
                      content: defText(
                          text: controller.loctioninfo!,
                          color: Colors.black,
                          size: 14));
                },
                icon: Icon(Icons.done))
          ],
        ),
        body: controller.isloading.value == true
            ? defcirculer()
            : Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  GoogleMap(
                    myLocationEnabled: true,
                    markers: controller.createMarker(),
                    onTap: (argument) =>
                        controller.changemarker(argument: argument),
                    initialCameraPosition: CameraPosition(
                      target: controller.latLng,
                      zoom: 19,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
