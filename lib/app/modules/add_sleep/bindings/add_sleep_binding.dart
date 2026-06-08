import 'package:get/get.dart';

import '../controllers/add_sleep_controller.dart';

class AddSleepBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddSleepController>(
      () => AddSleepController(),
    );
  }
}
