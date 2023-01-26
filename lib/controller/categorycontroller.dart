import 'package:darkstore/controller/homescreencontroller.dart';
import 'package:get/get.dart';
import 'package:darkstore/model/modelproduct.dart';

import '../components/constants.dart';
import '../components/linkapi.dart';
import '../model/modelcategory.dart';
import '../network/dioapp.dart';

class CategoryController extends GetxController {
  RxBool isloading = false.obs;
  RxList category = [].obs;
  RxList product = [].obs;
  int currentindex = 0;
  changeappbar(int index) {
    currentindex = index;
    update();
  }

  @override
  void onInit() {
    getcategory();
    super.onInit();
  }

  void getcategory() async {
    isloading.value = true;
    DioApp.getData(url: CATEGORY).then((value) {
      category.value = [];
      value.data.forEach((element) {
        category.add(ModelCategory.fromJson(element));
      });
      isloading.value = false;
    });
  }

  void getprocudt({required String categoryid}) async {
    isloading.value = true;
    DioApp.postData(url: CATEGORYpro, data: {'id': id, 'category': categoryid})
        .then((value) {
      product.value = [];
      value.data.forEach((element) {
        product.add(ModelProduct.fromJson(element));
      });
      isloading.value = false;
    });
  }

  int changepriceafterdic(int discount, int price) {
    int i = price * discount ~/ 100;
    int b = price - i;
    return b;
  }

  void addfav(ModelProduct product) {
    update();
    if (product.myfavorite == true) {
      DioApp.postData(url: REMOVEFAV, data: {
        "id_fav_product": product.id.toString(),
        "id_fav_user": id,
      }).then((value) {
        product.myfavorite = false;
        Get.put(HomeScreenController()).getprocudt();
        update();
      });
    } else {
      DioApp.postData(url: ADDFAV, data: {
        "id_fav_product": product.id.toString(),
        "id_fav_user": id,
      }).then((value) {
        product.myfavorite = true;
        Get.put(HomeScreenController()).getprocudt();
        update();
      });
    }
  }
}
