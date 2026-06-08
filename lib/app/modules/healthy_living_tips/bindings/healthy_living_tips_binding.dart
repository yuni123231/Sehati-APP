import 'package:get/get.dart';

import '../controllers/healthy_living_tips_controller.dart';

class HealthyLivingTipsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HealthyLivingTipsController>(
      () => HealthyLivingTipsController(),
    );
  }
}
