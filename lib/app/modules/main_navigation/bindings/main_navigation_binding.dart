import 'package:get/get.dart';

import '../../home/controllers/home_controller.dart';
import '../../profile/controllers/profile_controller.dart';
import '../../progres/controllers/progres_controller.dart';

class MainNavigationBinding extends Bindings {
  @override
  void dependencies() {

    /// HOME
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );

    /// PROGRESS
    Get.lazyPut<ProgresController>(
      () => ProgresController(),
    );

    /// PROFILE
    Get.lazyPut<ProfileController>(
      () => ProfileController(),
    );
  }
}