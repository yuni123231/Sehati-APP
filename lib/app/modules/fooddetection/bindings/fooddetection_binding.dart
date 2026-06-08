import 'package:get/get.dart';

import '../controllers/fooddetection_controller.dart';

class FooddetectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FooddetectionController>(
      () => FooddetectionController(),
    );
  }
}
