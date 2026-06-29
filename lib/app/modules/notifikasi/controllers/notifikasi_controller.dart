import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class NotifikasiController extends GetxController {
  final box = GetStorage();

  final notifications = <dynamic>[].obs;
  final selectedIndexes = <int>{}.obs;
  final isSelectionMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadNotifications();
  }

  void loadNotifications() {
    final data =
        List.from(box.read('notifications') ?? []);

    notifications.assignAll(data);
  }

  void clearAll() {
    box.remove('notifications');

    notifications.clear();

    Get.snackbar(
      "Berhasil",
      "Semua notifikasi dihapus",
      snackPosition: SnackPosition.TOP,
    );
  }

  void deleteItem(int index) {
    final data =
        List.from(box.read('notifications') ?? []);

    data.removeAt(index);

    box.write('notifications', data);

    notifications.assignAll(data);
  }

  void toggleSelection(int index) {
    if (selectedIndexes.contains(index)) {
      selectedIndexes.remove(index);
    } else {
      selectedIndexes.add(index);
    }

    isSelectionMode.value = selectedIndexes.isNotEmpty;
  }

  void deleteSelected() {
    final data = List.from(box.read('notifications') ?? []);

    final sortedIndexes =
        selectedIndexes.toList()..sort((a, b) => b.compareTo(a));

    for (var index in sortedIndexes) {
      data.removeAt(index);
    }

    box.write('notifications', data);

    notifications.assignAll(data);

    selectedIndexes.clear();
    isSelectionMode.value = false;

    Get.snackbar(
      "Berhasil",
      "Notifikasi terpilih dihapus",
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}