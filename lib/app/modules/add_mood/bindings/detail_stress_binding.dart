import 'package:get/get.dart';

import '../controllers/detail_stress_controller.dart';

class DetailStressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailStressController>(
      () => DetailStressController(),
    );
  }
}