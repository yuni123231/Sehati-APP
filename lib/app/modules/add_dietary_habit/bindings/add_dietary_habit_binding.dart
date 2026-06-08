import 'package:get/get.dart';

import '../controllers/add_dietary_habit_controller.dart';

class AddDietaryHabitBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddDietaryHabitController>(
      () => AddDietaryHabitController(),
    );
  }
}
