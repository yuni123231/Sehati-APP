import 'package:get/get.dart';

import '../controllers/enter_details_controller.dart';

class EnterDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EnterDetailsController>(
      () => EnterDetailsController(),
    );
  }
}
